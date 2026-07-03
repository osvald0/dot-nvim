local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- File operations
opts.desc = "Save file"
keymap.set("n", "<C-s>", "<cmd>w<CR>", opts)

opts.desc = "Save file (insert mode)"
keymap.set("i", "<C-s>", "<C-o>:update<CR>", opts)

opts.desc = "Save without formatting"
keymap.set("n", "<leader>sN", "<cmd>noautocmd w<CR>", opts)

opts.desc = "Quit all files"
keymap.set("n", "<leader>qq", "<cmd>qa<CR>", opts)

opts.desc = "Quit current window"
keymap.set("n", "<C-q>", "<cmd>q<CR>", opts)

-- File explorer

opts.desc = "Toggle file explorer"
keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", opts)

-- Scrolling & search
opts.desc = "Scroll down and center"
keymap.set("n", "<C-d>", "<C-d>zz", opts)

opts.desc = "Scroll up and center"
keymap.set("n", "<C-u>", "<C-u>zz", opts)

opts.desc = "Find next and center"
keymap.set("n", "n", "nzzzv", opts)

opts.desc = "Find previous and center"
keymap.set("n", "N", "Nzzzv", opts)

opts.desc = "Highlight + label matches of selection"
keymap.set("x", "*", function()
	-- Yank the visual selection into register v without clobbering the
	-- clipboard, then restore whatever was in v afterwards.
	local save = vim.fn.getreg("v")
	local save_type = vim.fn.getregtype("v")
	vim.cmd('noautocmd normal! "vy')
	local text = vim.fn.getreg("v")
	vim.fn.setreg("v", save, save_type)

	-- Search literally (\V = very nomagic): only escape "\" and "/",
	-- and turn newlines into \n so multiline selections still match.
	local pat = vim.fn.escape(text, [[\/]]):gsub("\n", [[\n]])
	vim.fn.setreg("/", [[\V]] .. pat)
	vim.fn.histadd("search", vim.fn.getreg("/"))
	vim.o.hlsearch = true

	-- Label every match so you can jump straight to a specific one
	-- (press the shown letter). Falls back to plain highlight if flash
	-- isn't available yet.
	local ok, flash = pcall(require, "flash")
	if ok then
		flash.jump({ pattern = text, search = { mode = "exact" } })
	end
end, opts)

-- Text editing
-- opts.desc = "Delete without yanking"
-- keymap.set("n", "x", '"_x', opts)
--
-- opts.desc = "Paste without overwriting register"
-- keymap.set("v", "p", '"_dP', opts)
--
-- opts.desc = "Indent left and keep selection"
-- keymap.set("v", "<", "<gv", opts)
--
-- opts.desc = "Indent right and keep selection"
-- keymap.set("v", ">", ">gv", opts)

-- UI / visual
opts.desc = "Clear search highlight"
keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", opts)
--
-- opts.desc = "Toggle line wrap"
-- keymap.set("n", "<leader>lw", "<cmd>set wrap!<CR>", opts)
--
-- opts.desc = "Show hover documentation"
-- keymap.set("n", "K", vim.lsp.buf.hover, opts)
--
-- -- Terminal
-- opts.desc = "Exit terminal mode"
-- keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", opts)
--
-- -- Window navigation
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

-- opts.desc = "First buffer"
-- keymap.set("n", "gH", ":bfirst<CR>", opts)
--
-- opts.desc = "Last buffer"
-- keymap.set("n", "gL", ":blast<CR>", opts)
--
opts.desc = "Alternate buffer"
keymap.set("n", "<leader><Tab>", "<C-^>", opts)
--
opts.desc = "Delete current buffer"
keymap.set("n", "<leader>bd", ":bdelete<CR>", opts)
--
-- vim.keymap.set("n", "<leader>fT", function()
-- 	local file_dir = vim.fn.expand("%:p:h")
-- 	vim.fn.system("tmux new-window -c " .. vim.fn.shellescape(file_dir))
-- end, { desc = "Open new tmux window in file directory" })
--
-- vim.keymap.set("n", "<leader>cp", ":let @+ = expand('%:p')<CR>", { silent = true, desc = "Copy file path" })
--
-- vim.keymap.set("n", "<leader>cn", ":let @+ = expand('%:t')<CR>", { silent = true, desc = "Copy file name" })
--
-- -- Open the file's directory in Finder
-- vim.keymap.set("n", "<leader>of", function()
-- 	vim.fn.system("open " .. vim.fn.expand("%:h"))
-- end, { silent = true, desc = "Open file directory in Finder" })
--
-- -- Search selected text with Telescope's live_grep
-- vim.api.nvim_set_keymap(
-- 	"v",
-- 	"<C-f>",
-- 	'y<cmd>lua require("telescope.builtin").live_grep({ default_text = vim.fn.escape(vim.fn.getreg(0), " ") })<CR>',
-- 	{ noremap = true, silent = true }
-- )
--
-- vim.keymap.set("v", "<D-j>", ":m '>+1<CR>gv", { noremap = true, silent = true, desc = "Move selection down" })
--
-- vim.keymap.set("v", "<D-k>", ":m '<-2<CR>gv", { noremap = true, silent = true, desc = "Move selection up" })
--
-- vim.keymap.set("x", "<leader>P", [["_dP]], { desc = "Paste without yanking replaced text" })
