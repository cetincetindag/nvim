# Neovim Config

## Sources
- A lot of pain

## Installation Guide (macOS & Linux)

### Prerequisites
- Git
- Neovim (>= 0.9.0)
- A terminal that supports true colors and modern fonts (iTerm2, Alacritty, Kitty, etc.)
- A [Nerd Font](https://www.nerdfonts.com/) for proper icon display

### Step 1: Install Neovim
Choose the method that works best for your system:

#### macOS
```bash
# Using Homebrew
brew install neovim

# Using MacPorts
sudo port install neovim
```

#### Linux
```bash
# Ubuntu/Debian
sudo apt update
sudo apt install neovim

# Arch Linux
sudo pacman -S neovim

# Fedora
sudo dnf install neovim

# Using AppImage (any distro)
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim
```

### Step 2: Clear any previous Neovim configuration
```bash
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
```

### Step 3: Clone this configuration
```bash
# Create the config directory
mkdir -p ~/.config/nvim

# Clone the repository
git clone https://github.com/cetincetindag/nvim.git ~/.config/nvim
```

### Step 4: Start Neovim
```bash
nvim
```
The package manager will automatically install all plugins on the first run.

## Key Features
- Modern and minimalist interface
- Fuzzy finding with Telescope
- File explorer with NvimTree
- LSP support for various languages
- Treesitter for better syntax highlighting
- Git integration

## Troubleshooting

### Common Issues
- If you encounter plugin installation errors, try running `:PackerSync` manually
- For LSP issues, check if the language server is installed with `:LspInfo`
- Font issues: Make sure you have a Nerd Font installed and configured in your terminal

### Dependencies
Some features may require external tools:
- `ripgrep` for better search functionality
- Language servers for specific languages (install via `:LspInstall`)
- `fd` for improved file finding

## Customization
Edit the configuration files in `~/.config/nvim/` to customize your setup.

## License
This project is open-source and available under the MIT License.
