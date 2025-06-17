#!/bin/bash

echo "=== Tailwind CSS LSP Diagnostic ==="
echo

echo "1. Checking Mason packages..."
ls -la ~/.local/share/nvim/mason/packages/ | grep -E "(tailwind|html|css)"
echo

echo "2. Checking if Tailwind config exists..."
if [ -f "/Users/cetincetindag/.config/nvim/tailwind.config.js" ]; then
    echo "✓ tailwind.config.js found"
else
    echo "✗ tailwind.config.js not found"
fi
echo

echo "3. Starting Neovim with test files..."
echo "Please open one of these test files in Neovim:"
echo "  - test-tailwind.html (HTML with Tailwind classes)"
echo "  - test-tailwind.jsx (React component with Tailwind)"
echo
echo "In Neovim, try:"
echo "  1. :LspInfo - to see active LSP servers"
echo "  2. Position cursor on a Tailwind class and press 'K' for hover info"
echo "  3. Start typing 'bg-' in a class attribute to see autocomplete"
echo "  4. Use :Mason to verify tailwindcss-language-server is installed"
