# NixVim

## Prerequisites

Install [Nix: The Package Manager](https://nixos.org/download/).

## Try the NixVim Config

Clone this repo and run the following command:

```bash
nix run .
```

## LSPs

General:

| LSP            | Description                                                                        |
| -------------- | ---------------------------------------------------------------------------------- |
| ast-grep       | Fast and polyglot tool for code structural search, lint, rewriting at large scale. |
| asm-lsp        | LSP for assembly languages.                                                        |
| bashls         | LSP for Bash scripts.                                                              |
| markdown_oxide | A Markdown language server in Rust.                                                |
| tinymist       | A language server for the Typst language.                                          |

## Plugins

This configuration uses a variety of plugins to enhance the Neovim experience.
Here's a categorized list:

### Completion

| Plugin            | Description                                                          |
| ----------------- | -------------------------------------------------------------------- |
| blink-cmp         | Autocompletion plugin for Neovim.                                    |
| LuaSnip           | Snippet engine for Neovim written in Lua.                            |
| friendly-snippets | A set of preconfigured snippets for different programming languages. |
| lazydev.nvim      | Faster LuaLS setup for Neovim.                                       |

### Coding Utilities

| Plugin               | Description                                                                      |
| -------------------- | -------------------------------------------------------------------------------- |
| Comment.nvim         | Smart commenting plugin that supports various comment styles.                    |
| comment-divider.nvim | Plugin to create noticeable comment dividers.                                    |
| neogen               | A plugin to generate annotations and docstrings.                                 |
| nvim-autopairs       | Inserts and deletes matching pairs of brackets, quotes, etc.                     |
| todo-comments.nvim   | Highlights and lists TODO, FIXME, NOTE, etc. comments.                           |
| nvim-treesitter      | Treesitter configurations and abstraction layer.                                 |
| trouble.nvim         | A pretty diagnostics, references, telescope results, quickfix and location list. |
| vim-suda             | Allows editing files with sudo privileges.                                       |

### Editor Enhancements

| Plugin               | Description                                                              |
| -------------------- | ------------------------------------------------------------------------ |
| gitsigns.nvim        | Git integration: signs for added, changed, and removed lines.            |
| lazygit.nvim         | Plugin for fugitive.vim to bring up lazygit in a floating terminal.      |
| render-markdown.nvim | Plugin to improve viewing Markdown files in Neovim.                      |
| neo-tree.nvim        | A file explorer tree.                                                    |
| nvim-ufo             | An ultra fold in Neovim.                                                 |
| toggleterm.nvim      | A Neovim plugin to persist and toggle multiple terminals during editing. |

### Core Infrastructure

| Plugin                | Description                                                         |
| --------------------- | ------------------------------------------------------------------- |
| nvim-config-local     | Load local configuration files.                                     |
| flash.nvim            | Enhanced jump motions for Neovim.                                   |
| mini.nvim (bufremove) | Part of the mini.nvim suite, provides buffer removal functionality. |
| telescope.nvim        | Highly extendable fuzzy finder over lists.                          |
| which-key.nvim        | Displays a popup with possible keybindings.                         |

### Visuals & UI

| Plugin           | Description                                                           |
| ---------------- | --------------------------------------------------------------------- |
| bufferline.nvim  | A snazzy buffer line for Neovim.                                      |
| dressing.nvim    | Improves the default vim.ui interfaces.                               |
| lualine.nvim     | A blazing fast and easy to configure Neovim statusline.               |
| noice.nvim       | Replaces the UI for messages, cmdline and the popupmenu.              |
| nvim-notify      | A notification manager for Neovim.                                    |
| virt-column.nvim | Displays a virtual column (e.g., for colorcolumn) without text shift. |

## Get started

**NOTE:** This project is pre-configured with nix-direnv, as well as Nixd
support for VSCode.

Prerequisites: Make sure to also have [direnv](https://direnv.net) and
[nixd](https://github.com/nix-community/nixd) installed.

```bash
# Enable devshell
direnv allow

# Build nixvim under `./result`
nix build

# Run nixvim directly
nix run

# Install nixvim via `nix profile`
nix profile install

# You may also include this flake in system configuration
# e.g. inputs.nixvim.url = "github:definfo/nixvim";
# You may add
# inputs.nixvim.inputs.nixpkgs.follows = "nixpkgs";
# to reuse existing nixpkgs.
# However this may lead to incompatibilities.

# Run treefmt to format the project
nix fmt

# Run checks
nix flake check

# NOTE:
# pre-commit-hook automatically runs before `git commit`
# See details with
pre-commit --all-files --verbose
```

### Optional steps for NixVim completion

To enable completion for NixVim options in VSCode:

1. Install `Nix IDE` VSCode extension,

2. Follow the instructions in `.vscode/settings.json.bak`,

3. Rename it to `.vscode/settings.json`.

   Enjoy completion!

## Contributing

Issues / PRs are welcomed :)
