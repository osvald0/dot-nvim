-- For conciseness
local opt = vim.opt

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Make line numbers default
opt.number = true

-- Relative line numbers for navigation
opt.relativenumber = true

-- 2 spaces for tabs (prettier default)
opt.tabstop = 2

-- 2 spaces for indent width
opt.shiftwidth = 2

-- expand tab to spaces
opt.expandtab = true

-- copy indent from current line when starting new one
opt.autoindent = true

-- Enable mouse mode
opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
opt.showmode = false

-- Sync clipboard between OS and Neovim.
vim.schedule(function()
	opt.clipboard = "unnamedplus"
end)

-- Enable break indent
opt.breakindent = true

-- Save undo history
opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
opt.ignorecase = true
opt.smartcase = true

-- Keep signcolumn on by default
opt.signcolumn = "yes"

-- Decrease update time
opt.updatetime = 250

-- Decrease mapped sequence wait time
opt.timeoutlen = 300

-- Configure how new splits should be opened
opt.splitright = true
opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
opt.inccommand = "split"

-- Show which line your cursor is on
opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
opt.confirm = true

-- Turn on termguicolors
opt.termguicolors = true

-- Colorschemes that can be light or dark will be made dark
opt.background = "dark"

-- Show sign column so that text doesn't shift
opt.signcolumn = "yes"

-- Allow backspace on indent, end of line or insert mode start position
opt.backspace = "indent,eol,start"

-- Turn off swapfile
opt.swapfile = false
