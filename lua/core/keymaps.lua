-- fet leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- vim.o.timeout = true
-- vim.o.timeoutlen = 350
--
-- For conciseness
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Treat <leader>s as a prefix (normal + visual)
-- opts.desc = "[S]earch prefix"
-- vim.keymap.set({ "n", "x" }, "<leader>s", "<Nop>")

-- Leader key behavior
opts.desc = "Disable default spacebar action"
keymap.set({ "n", "v" }, "<Space>", "<Nop>", opts)

-- File operations
opts.desc = "Save file"
keymap.set("n", "<C-s>", "<cmd>w<CR>", opts)

opts.desc = "Save file (insert mode)"
keymap.set("i", "<C-s>", "<C-o>:update<CR>", opts)

opts.desc = "Save without formatting"
keymap.set("n", "<leader>sn", "<cmd>noautocmd w<CR>", opts)

opts.desc = "Quit all files"
keymap.set("n", "<leader>qq", "<cmd>qa<CR>", opts)

opts.desc = "Quit current window"
keymap.set("n", "<C-q>", "<cmd>q<CR>", opts)

-- Scrolling & search
opts.desc = "Scroll down and center"
keymap.set("n", "<C-d>", "<C-d>zz", opts)

opts.desc = "Scroll up and center"
keymap.set("n", "<C-u>", "<C-u>zz", opts)

opts.desc = "Find next and center"
keymap.set("n", "n", "nzzzv", opts)

opts.desc = "Find previous and center"
keymap.set("n", "N", "Nzzzv", opts)

-- Text editing
opts.desc = "Delete without yanking"
keymap.set("n", "x", '"_x', opts)

opts.desc = "Paste without overwriting register"
keymap.set("v", "p", '"_dP', opts)

opts.desc = "Indent left and keep selection"
keymap.set("v", "<", "<gv", opts)

opts.desc = "Indent right and keep selection"
keymap.set("v", ">", ">gv", opts)

-- UI / visual
opts.desc = "Clear search highlight"
keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", opts)

opts.desc = "Toggle line wrap"
keymap.set("n", "<leader>lw", "<cmd>set wrap!<CR>", opts)

opts.desc = "Show hover documentation"
keymap.set("n", "K", vim.lsp.buf.hover, opts)

-- Terminal
opts.desc = "Exit terminal mode"
keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", opts)

-- Window navigation
opts.desc = "Move to left window"
keymap.set("n", "<C-h>", "<C-w>h", opts)

opts.desc = "Move to right window"
keymap.set("n", "<C-l>", "<C-w>l", opts)

opts.desc = "Move to lower window"
keymap.set("n", "<C-j>", "<C-w>j", opts)

opts.desc = "Move to upper window"
keymap.set("n", "<C-k>", "<C-w>k", opts)

-- Buffers
opts.desc = "Prev buffer"
keymap.set("n", "H", ":bprevious<CR>", opts)

opts.desc = "Next buffer"
keymap.set("n", "L", ":bnext<CR>", opts)

opts.desc = "First buffer"
keymap.set("n", "gH", ":bfirst<CR>", opts)

opts.desc = "Last buffer"
keymap.set("n", "gL", ":blast<CR>", opts)

opts.desc = "Alternate buffer"
keymap.set("n", "<leader><Tab>", "<C-^>", opts)

opts.desc = "Delete current buffer"
keymap.set("n", "<leader>bd", ":bdelete<CR>", opts)

-- Open a terminal in the directory of the current file in a new tmux window
vim.keymap.set("n", "<leader>fT", function()
	local file_dir = vim.fn.expand("%:p:h")
	vim.fn.system("tmux new-window -c " .. vim.fn.shellescape(file_dir))
end, { desc = "Open new tmux window in file directory" })

-- Copy the full file path to the clipboard
vim.keymap.set("n", "<leader>cp", ":let @+ = expand('%:p')<CR>", { silent = true, desc = "Copy file path" })
vim.keymap.set("n", "<leader>cn", ":let @+ = expand('%:t')<CR>", { silent = true, desc = "Copy file name" })

-- Open the file's directory in Finder
vim.keymap.set("n", "<leader>of", function()
	vim.fn.system("open " .. vim.fn.expand("%:h"))
end, { silent = true, desc = "Open file directory in Finder" })

-- Search selected text with Telescope's live_grep
vim.api.nvim_set_keymap(
	"v",
	"<C-f>",
	'y<cmd>lua require("telescope.builtin").live_grep({ default_text = vim.fn.escape(vim.fn.getreg(0), " ") })<CR>',
	{ noremap = true, silent = true }
)

vim.keymap.set("v", "<D-j>", ":m '>+1<CR>gv", { noremap = true, silent = true, desc = "Move selection down" })

vim.keymap.set("v", "<D-k>", ":m '<-2<CR>gv", { noremap = true, silent = true, desc = "Move selection up" })

-- Paste over selection without overwriting the default yank register
vim.keymap.set("x", "<leader>P", [["_dP]], { desc = "Paste without yanking replaced text" })
