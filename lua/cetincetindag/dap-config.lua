local dap = require('dap')
local dapui = require('dapui')

-- Get the install path for codelldb from mason
local mason_registry = require('mason-registry')
local codelldb_path = nil

-- Check if codelldb is installed and get path
if mason_registry.is_installed('codelldb') then
  local codelldb = mason_registry.get_package('codelldb')
  -- Try the standard Mason API method
  if type(codelldb.get_install_path) == 'function' then
    local ok, path = pcall(codelldb.get_install_path, codelldb)
    if ok and path then
      codelldb_path = path
    end
  end
  
  -- Fallback to standard Mason path structure if the above fails
  if not codelldb_path then
    codelldb_path = vim.fn.stdpath('data') .. '/mason/packages/codelldb'
  end
else
  vim.notify('codelldb is not installed via Mason. Run :MasonInstall codelldb', vim.log.levels.ERROR)
  return
end

local codelldb_extension = codelldb_path .. '/extension/'
local codelldb_adapter = codelldb_extension .. 'adapter/codelldb'

-- Verify that the codelldb adapter exists
if vim.fn.executable(codelldb_adapter) == 0 then
  vim.notify('codelldb adapter not found at: ' .. codelldb_adapter, vim.log.levels.WARN)
  return
end

-- Configure LLDB adapter for C/C++/Rust debugging
dap.adapters.codelldb = {
  type = 'server',
  port = '${port}',
  executable = {
    command = codelldb_adapter,
    args = {'--port', '${port}'},
  }
}

-- Configure the debug configurations for different languages
dap.configurations.cpp = {
  {
    name = 'Launch',
    type = 'codelldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = function()
      local args_str = vim.fn.input('Arguments: ')
      return vim.split(args_str, ' ', { trimempty = true })
    end,
    runInTerminal = false,
  },
  {
    name = 'Attach to process',
    type = 'codelldb',
    request = 'attach',
    pid = function()
      local output = vim.fn.system({'ps', 'aux'})
      local lines = vim.split(output, '\n')
      local procs = {}
      for i, line in ipairs(lines) do
        if i > 1 then  -- Skip the header line
          table.insert(procs, line)
        end
      end
      
      -- Display process selection
      vim.ui.select(procs, {
        prompt = 'Select process to attach:',
        format_item = function(item)
          return item
        end,
      }, function(choice)
        if not choice then return end
        
        -- Extract PID from the selected process line
        local pid = choice:match('%s*(%d+)')
        return pid
      end)
    end,
  },
}

-- Link C and Rust to the same configurations
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

-- Keymappings for debugging
vim.keymap.set('n', '<F5>', function() dap.continue() end)
vim.keymap.set('n', '<F10>', function() dap.step_over() end)
vim.keymap.set('n', '<F11>', function() dap.step_into() end)
vim.keymap.set('n', '<F12>', function() dap.step_out() end)
vim.keymap.set('n', '<leader>db', function() dap.toggle_breakpoint() end)
vim.keymap.set('n', '<leader>dB', function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end)
vim.keymap.set('n', '<leader>dl', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<leader>dr', function() dap.repl.open() end)

-- UI related mappings
vim.keymap.set('n', '<leader>du', function() dapui.toggle() end)

-- Add diagnostic signs for breakpoints
vim.fn.sign_define('DapBreakpoint', {text='🔴', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointCondition', {text='🟡', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointRejected', {text='⚪', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapLogPoint', {text='📝', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='▶️', texthl='', linehl='', numhl=''})