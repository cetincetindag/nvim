local M = {}

-- Get the correct build command based on project type
local function get_build_command()
  -- Check for make
  if vim.fn.filereadable("Makefile") == 1 then
    return "make"
  end
  
  -- Check for CMake
  if vim.fn.filereadable("CMakeLists.txt") == 1 then
    local build_dir = "build"
    if vim.fn.isdirectory(build_dir) == 0 then
      vim.fn.mkdir(build_dir, "p")
    end
    return "cmake -B " .. build_dir .. " -S . && cmake --build " .. build_dir
  end
  
  -- Check for cargo (Rust)
  if vim.fn.filereadable("Cargo.toml") == 1 then
    return "cargo build"
  end
  
  -- Check for npm/yarn (JavaScript/TypeScript)
  if vim.fn.filereadable("package.json") == 1 then
    if vim.fn.filereadable("yarn.lock") == 1 then
      return "yarn build"
    else
      return "npm run build"
    end
  end
  
  -- Default: Try to compile the current file (C/C++)
  local file_extension = vim.fn.expand("%:e")
  if file_extension == "c" or file_extension == "cpp" then
    local current_file = vim.fn.shellescape(vim.fn.expand("%:p"))
    local output = vim.fn.shellescape(vim.fn.expand("%:r"))
    if file_extension == "c" then
      return "gcc " .. current_file .. " -o " .. output .. " -g"
    else
      return "g++ " .. current_file .. " -o " .. output .. " -std=c++17 -Wall -g"
    end
  end
  
  return nil
end

-- Get the correct clean command based on project type
local function get_clean_command()
  if vim.fn.filereadable("Makefile") == 1 then
    return "make clean"
  end
  if vim.fn.filereadable("CMakeLists.txt") == 1 then
    return "rm -rf build/"
  end
  if vim.fn.filereadable("Cargo.toml") == 1 then
    return "cargo clean"
  end
  if vim.fn.filereadable("package.json") == 1 then
    return "rm -rf dist/ build/ node_modules/.cache"
  end
  return nil
end

-- Get the correct run command based on project type
local function get_run_command()
  local current_dir = vim.fn.getcwd()
  vim.notify("Getting run command in: " .. current_dir, vim.log.levels.INFO)

  -- Check for Makefile with run target
  if vim.fn.filereadable("Makefile") == 1 then
    local makefile_content = vim.fn.readfile("Makefile")
    for _, line in ipairs(makefile_content) do
      if line:match("^run:") or line:match("^run *:") then
        vim.notify("Found 'make run' target", vim.log.levels.INFO)
        return "make run"
      end
    end
    -- Fallback for make: Try executable name from current file
    local executable = vim.fn.expand("%:r")
    if vim.fn.executable(executable) == 1 then
       vim.notify("Found executable '" .. executable .. "' for Makefile project", vim.log.levels.INFO)
       return "cd " .. vim.fn.shellescape(current_dir) .. " && ./" .. vim.fn.shellescape(executable)
    end
  end

  -- Check for CMake project
  if vim.fn.filereadable("CMakeLists.txt") == 1 then
    local build_dir = current_dir .. "/build"
    vim.notify("Checking CMake build directory: " .. build_dir, vim.log.levels.INFO)
    local files = vim.fn.glob(build_dir .. "/*", false, true)
    local executables = {}
    for _, file in ipairs(files) do
      if vim.fn.executable(file) == 1 and vim.fn.isdirectory(file) == 0 then
        table.insert(executables, file)
      end
    end

    if #executables > 0 then
      if #executables == 1 then
        vim.notify("Found CMake executable: " .. executables[1], vim.log.levels.INFO)
        return executables[1]
      else
        vim.notify("Multiple CMake executables found, prompting user", vim.log.levels.INFO)
        return function()
          vim.ui.select(executables, { prompt = "Select executable to run:" }, function(choice)
            if choice then
              vim.notify("User selected: " .. choice, vim.log.levels.INFO)
              local term_cmd = "cd " .. vim.fn.shellescape(build_dir) .. " && " .. vim.fn.shellescape(choice)
              vim.cmd("split | terminal")
              local bufnr = vim.api.nvim_get_current_buf()
              vim.api.nvim_chan_send(vim.api.nvim_get_option_value("channel", { buf = bufnr }), term_cmd .. "\r")
              vim.cmd("startinsert")
            end
          end)
          return nil -- Indicate command handled by callback
        end
      end
    else
      vim.notify("No executable found in CMake build directory", vim.log.levels.WARN)
    end
  end

  -- Check for Cargo (Rust)
  if vim.fn.filereadable("Cargo.toml") == 1 then
    vim.notify("Using 'cargo run'", vim.log.levels.INFO)
    return "cargo run"
  end

  -- Check for npm/yarn (JavaScript/TypeScript)
  if vim.fn.filereadable("package.json") == 1 then
    local package_json_content = table.concat(vim.fn.readfile("package.json"), "\n")
    local ok, package_json = pcall(vim.fn.json_decode, package_json_content)
    if ok and package_json and package_json.scripts then
      if package_json.scripts.start then
        local cmd = vim.fn.filereadable("yarn.lock") == 1 and "yarn start" or "npm start"
        vim.notify("Using '" .. cmd .. "'", vim.log.levels.INFO)
        return cmd
      elseif package_json.scripts.dev then
        local cmd = vim.fn.filereadable("yarn.lock") == 1 and "yarn dev" or "npm run dev"
        vim.notify("Using '" .. cmd .. "'", vim.log.levels.INFO)
        return cmd
      end
    end
  end

  -- Default: For C/C++ files compiled directly
  local file_extension = vim.fn.expand("%:e")
  if file_extension == "c" or file_extension == "cpp" then
    local executable = vim.fn.expand("%:r")
    if vim.fn.executable(executable) == 1 then
      vim.notify("Found executable '" .. executable .. "' for simple C/C++ file", vim.log.levels.INFO)
      return "cd " .. vim.fn.shellescape(current_dir) .. " && ./" .. vim.fn.shellescape(executable)
    end
  end

  vim.notify("No suitable run command found", vim.log.levels.WARN)
  return nil
end

-- Build the current project
function M.build()
  local cmd = get_build_command()
  if cmd then
    vim.notify("Build command: " .. cmd, vim.log.levels.INFO)
    vim.cmd("split | terminal")
    local bufnr = vim.api.nvim_get_current_buf()
    vim.api.nvim_chan_send(vim.api.nvim_get_option_value("channel", { buf = bufnr }), cmd .. "\r")
    vim.cmd("startinsert")
  else
    vim.notify("No build system detected", vim.log.levels.WARN)
  end
end

-- Clean the current project
function M.clean()
  local cmd = get_clean_command()
  if cmd then
    vim.notify("Clean command: " .. cmd, vim.log.levels.INFO)
    vim.cmd("split | terminal")
    local bufnr = vim.api.nvim_get_current_buf()
    vim.api.nvim_chan_send(vim.api.nvim_get_option_value("channel", { buf = bufnr }), cmd .. "\r")
    vim.cmd("startinsert")
  else
    vim.notify("No clean command available for this project", vim.log.levels.WARN)
  end
end

-- Run the current project or executable
function M.run()
  local cmd = get_run_command()
  if cmd then
    if type(cmd) == "function" then
      vim.notify("Executing run command function (CMake multiple executables)", vim.log.levels.INFO)
      cmd() -- Execute the function that handles selection
    else
      vim.notify("Run command: " .. cmd, vim.log.levels.INFO)
      vim.cmd("split | terminal")
      local bufnr = vim.api.nvim_get_current_buf()
      vim.api.nvim_chan_send(vim.api.nvim_get_option_value("channel", { buf = bufnr }), cmd .. "\r")
      vim.cmd("startinsert")
    end
  else
    vim.notify("No executable found or run method available for M.run", vim.log.levels.WARN)
  end
end

-- Build and run in one command
function M.build_and_run()
  local build_cmd = get_build_command()
  if not build_cmd then
    vim.notify("No build system detected for build_and_run", vim.log.levels.WARN)
    return
  end

  vim.notify("Build & Run: Starting build with command: " .. build_cmd, vim.log.levels.INFO)
  vim.cmd("split | terminal")
  local build_bufnr = vim.api.nvim_get_current_buf()
  vim.api.nvim_chan_send(vim.api.nvim_get_option_value("channel", { buf = build_bufnr }), build_cmd .. "\r")

  local augroup = vim.api.nvim_create_augroup("BuildAndRun", { clear = true })
  vim.api.nvim_create_autocmd("TermClose", {
    group = augroup,
    buffer = build_bufnr, -- Only trigger for the build terminal
    callback = function(args)
      vim.notify("Build & Run: TermClose event triggered. Status: " .. tostring(vim.v.event.status), vim.log.levels.INFO)
      if vim.v.event.status == 0 then
        vim.notify("Build & Run: Build successful, attempting to run...", vim.log.levels.INFO)
        vim.api.nvim_del_augroup_by_name("BuildAndRun")
        vim.defer_fn(function()
          vim.notify("Build & Run: Executing M.run() after delay.", vim.log.levels.INFO)
          M.run()
        end, 700) -- Increased delay slightly
      else
         vim.notify("Build & Run: Build failed or terminated with non-zero status.", vim.log.levels.WARN)
         vim.api.nvim_del_augroup_by_name("BuildAndRun")
      end
    end,
    once = true,
  })

  vim.cmd("startinsert") -- Start insert in the build terminal
end


-- Define keymaps
vim.keymap.set("n", "<leader>b", M.build, { desc = "Build project" })
vim.keymap.set("n", "<leader>c", M.clean, { desc = "Clean project" })
vim.keymap.set("n", "<leader>r", M.run, { desc = "Run executable" })
vim.keymap.set("n", "<leader>br", M.build_and_run, { desc = "Build and run" })

return M 