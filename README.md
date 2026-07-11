# dot-nvim

My personal Neovim configuration, based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) and managed with [lazy.nvim](https://github.com/folke/lazy.nvim).

## Requirements

- **Neovim** ≥ 0.10
- **git**
- **[ripgrep](https://github.com/BurntSushi/ripgrep)** — for Telescope grep
- **make** + a C compiler — for `telescope-fzf-native` and Treesitter parsers
- A **[Nerd Font](https://www.nerdfonts.com/)** selected in your terminal (for icons)
- Optional external tools used by LSP/formatting: `node`, `stylua`, `prettierd`/`prettier`

## Install

```sh
git clone <this-repo> ~/.config/nvim
nvim
```

On first launch, `lazy.nvim` bootstraps itself and installs all plugins automatically.

## Structure

```
init.lua              -- entry point (sets leader keys, loads core)
lua/core/
  options.lua         -- editor options
  keymaps.lua         -- key mappings
  lazy.lua            -- plugin manager bootstrap + spec import
  snippets.lua
lua/plugins/          -- one file per plugin (auto-imported)
```

Leader keys: `<Space>` (leader), `,` (localleader).

## What's included

- **Colorscheme** — Dracula
- **Completion** — blink.cmp
- **LSP** — nvim-lspconfig (clangd, gopls, pyright, rust_analyzer, ts_ls, lua_ls, jsonls)
- **Formatting** — conform.nvim (stylua, prettier)
- **Fuzzy finder** — Telescope (+ fzf-native, ui-select)
- **File explorer** — nvim-tree
- **Syntax** — nvim-treesitter, nvim-ts-autotag
- **Git** — gitsigns
- **Navigation** — flash.nvim (labeled jumps)
- **Buffer tabs** — bufferline.nvim
- **Editing/UI** — mini.nvim, which-key, trouble, todo-comments, indent-blankline, render-markdown

## Keymaps

Leader is `<Space>`. `<leader>` below means Space.

### Files, buffers & windows

| Key | Action |
| --- | --- |
| `<C-s>` | Save file (normal & insert) |
| `<leader>sN` | Save without formatting |
| `<leader>qq` | Quit all |
| `<C-q>` | Quit current window |
| `<leader>e` | Toggle file explorer (nvim-tree) |
| `<leader>bd` | Delete current buffer |
| `<leader><Tab>` | Alternate buffer |
| `H` / `L` | Previous / next buffer tab (visible order) |
| `<leader>1`…`<leader>9` | Jump to tab 1–9 |
| `<leader>bp` | Pick a tab by letter |
| `<leader><leader>` | Find existing buffers |
| `<C-h/j/k/l>` | Move between windows |
| `<C-d>` / `<C-u>` | Scroll half-page & center |
| `n` / `N` | Next / prev search result & center |
| `<Esc>` | Clear search highlight |

### Search (Telescope)

| Key | Action |
| --- | --- |
| `<leader>sf` | Find files |
| `<leader>sg` | Live grep (project) |
| `<leader>sw` | Grep word under cursor (normal) / selection (visual), project-wide |
| `<leader>s/` | Live grep in open files |
| `<leader>/` | Fuzzy search current buffer |
| `<leader>sh` | Search help |
| `<leader>sk` | Search keymaps |
| `<leader>ss` | Select Telescope builtins |
| `<leader>sd` | Search diagnostics |
| `<leader>sr` | Resume last picker |
| `<leader>s.` | Recent files |
| `<leader>sn` | Search Neovim config files |
| `<leader>st` | Search TODOs |

### Navigation (flash)

| Key | Action |
| --- | --- |
| `s` | Flash jump |
| `S` | Flash Treesitter |
| `*` (visual) | Highlight + label all matches of the selection |

### LSP

| Key | Action |
| --- | --- |
| `gd` | Goto definition |
| `gD` | Goto declaration |
| `gi` | Goto implementation |
| `gr` | References |
| `<leader>rn` | Rename |
| `<leader>ca` | Code action |
| `<leader>ds` | Document symbols |
| `<leader>ws` | Workspace symbols |
| `<leader>td` | Type definition |
| `<leader>th` | Toggle inlay hints |
| `<leader>f` | Format buffer (conform) |

### Git (gitsigns)

| Key | Action |
| --- | --- |
| `]h` / `[h` | Next / previous hunk |
| `<leader>hs` | Stage hunk (normal & visual) |
| `<leader>hr` | Reset hunk (normal & visual) |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame line |
| `<leader>hd` | Diff against index |
| `<leader>tb` | Toggle line blame |

### Diagnostics (Trouble)

| Key | Action |
| --- | --- |
| `<leader>xx` | Diagnostics |
| `<leader>xX` | Buffer diagnostics |
| `<leader>xs` | Symbols |
| `<leader>xl` | LSP definitions / references |
| `<leader>xL` | Location list |
| `<leader>xQ` | Quickfix list |
| `<leader>xt` | TODOs |
