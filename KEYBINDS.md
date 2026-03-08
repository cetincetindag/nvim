# Neovim Custom Keybinds

This document lists all custom keybinds from your Neovim configuration, categorized by their functionality.

---

## General

| Keybind         | Mode(s)   | Action                                      |
|-----------------|-----------|---------------------------------------------|
| `<leader><CR>`  | Normal    | Source config (`:so`)                       |
| `<leader>pv`    | Normal    | Open netrw (if enabled)                     |
| `<leader>q`     | Normal    | Quit                                       |
| `<leader>Q`     | Normal    | Force quit                                 |
| `<leader>w`     | Normal    | Save and format buffer                     |
| `<leader>bd`    | Normal    | Delete buffer                              |
| `<leader>y`     | Normal/Visual | Copy to system clipboard               |
| `<leader>Y`     | Normal    | Copy line to system clipboard              |
| `<leader>p`     | Visual    | Paste without replacing clipboard          |
| `<leader>s`     | Normal    | Search and replace word under cursor       |
| `<leader>u`     | Normal    | Toggle Undotree                            |

## Window & Buffer Navigation

| Keybind         | Mode(s)   | Action                                      |
|-----------------|-----------|---------------------------------------------|
| `<C-h>`         | Normal    | Move to left window                         |
| `<C-j>`         | Normal    | Move to below window                        |
| `<C-k>`         | Normal    | Move to above window                        |
| `<C-l>`         | Normal    | Move to right window                        |
| `<C-d>`         | Normal    | Half-page down, center cursor               |
| `<C-u>`         | Normal    | Half-page up, center cursor                 |

## Line & Text Manipulation

| Keybind         | Mode(s)   | Action                                      |
|-----------------|-----------|---------------------------------------------|
| `J`             | Visual    | Move selected lines down                    |
| `K`             | Visual    | Move selected lines up                      |
| `J`             | Normal    | Join lines, keep cursor position            |
| `n`             | Normal    | Next search result, center cursor           |
| `N`             | Normal    | Previous search result, center cursor       |

## Terminal Mode

| Keybind         | Mode(s)   | Action                                      |
|-----------------|-----------|---------------------------------------------|
| `<C-x>`         | Terminal  | Exit terminal mode and move to left window  |
| `<Esc><Esc>`    | Terminal  | Exit terminal mode                          |


## Telescope

| Keybind         | Mode(s)   | Action                                      |
|-----------------|-----------|---------------------------------------------|
| `<leader>ff`    | Normal    | Find files (builtin.find_files)             |
| `<leader>fg`    | Normal    | Live grep (builtin.live_grep)               |
| `<leader>fb`    | Normal    | List buffers (builtin.buffers)              |
| `<leader>fh`    | Normal    | Help tags (builtin.help_tags)               |
| `<leader>pf`    | Normal    | Find files (builtin.find_files)             |
| `<leader>pg`    | Normal    | Find git files (builtin.git_files)          |
| `<leader>ps`    | Normal    | Grep string (prompted input)                |

## Harpoon

| Keybind         | Mode(s)   | Action                                      |
|-----------------|-----------|---------------------------------------------|
| `<leader>a`     | Normal    | Add file to Harpoon list                    |
| `<C-e>`         | Normal    | Toggle Harpoon quick menu                   |
| `<C-f>h`        | Normal    | Go to Harpoon file 1                        |
| `<C-f>j`        | Normal    | Go to Harpoon file 2                        |
| `<C-f>k`        | Normal    | Go to Harpoon file 3                        |
| `<C-f>l`        | Normal    | Go to Harpoon file 4                        |
| `<C-f>p`        | Normal    | Previous Harpoon file                       |
| `<C-f>n`        | Normal    | Next Harpoon file                           |

## Fugitive

| Keybind         | Mode(s)   | Action                                      |
|-----------------|-----------|---------------------------------------------|
| `<leader>gs`    | Normal    | Open Fugitive Git status                    |

## Undotree

| Keybind         | Mode(s)   | Action                                      |
|-----------------|-----------|---------------------------------------------|
| `<leader>u`     | Normal    | Toggle Undotree                             |

## Trouble

| Keybind         | Mode(s)   | Action                                      |
|-----------------|-----------|---------------------------------------------|
| `<leader>xd`    | Normal    | Document diagnostics                        |
| `<leader>xw`    | Normal    | Workspace diagnostics                       |

## Insert Mode

| Keybind         | Mode(s)   | Action                                      |
|-----------------|-----------|---------------------------------------------|
| `jj`            | Insert    | Exit insert mode                            |

## LSP (Language Server Protocol)

| Keybind         | Mode(s)   | Action                                      |
|-----------------|-----------|---------------------------------------------|
| `gp`            | Normal    | LSP Hover                                   |
| `gP`            | Normal    | LSP Go to definition                        |
| `gi`            | Normal    | LSP Go to implementation                    |
| `<leader>ca`    | Normal    | LSP Code action                             |
| `<leader>rn`    | Normal    | LSP Rename symbol                           |

---

**Legend:**
- `<leader>` is set to the spacebar (` `)
- Modes: Normal, Visual, Insert, Terminal

This list is generated from your current config as of December 26, 2025.

