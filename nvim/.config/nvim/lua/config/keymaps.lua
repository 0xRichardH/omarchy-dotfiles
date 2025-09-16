-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function map(mode, lhs, rhs, opts)
    local keys = require("lazy.core.handler").handlers.keys
    ---@cast keys LazyKeysHandler
    -- do not create the keymap if a lazy keys handler exists
    if not keys.active[keys.parse({ lhs, mode = mode }).id] then
        opts = opts or {}
        opts.silent = opts.silent ~= false
        if opts.remap and not vim.g.vscode then
            opts.remap = nil
        end
        vim.keymap.set(mode, lhs, rhs, opts)
    end
end

local function defaultOptsWithDesc(desc)
    local default_opts = { noremap = true, silent = true }
    default_opts.desc = desc
    return default_opts
end

-- map enter to ciw
map("n", "<CR>", "ciw", defaultOptsWithDesc("ciw"))

-- move lines with a pair of keymaps
map("v", "J", ":m '>+1<CR>gv=gv", defaultOptsWithDesc("Move Line Down"))
map("v", "K", ":m '<-2<CR>gv=gv", defaultOptsWithDesc("Move Line Up"))

-- move to start/end of the line
map({ "n", "x", "o" }, "H", "^", defaultOptsWithDesc("Move to Start of Line"))
map({ "n", "x", "o" }, "L", "$", defaultOptsWithDesc("Move to End of Line"))

-- navigate buffers
-- map("n", "<Right>", ":bnext<CR>", defaultOptsWithDesc("Next Buffer"))
-- map("n", "<Left>", ":bprevious<CR>", defaultOptsWithDesc("Previous Buffer"))

-- Move between windows using arrow keys
map("n", "<Up>", "<C-w>k", defaultOptsWithDesc("Move to Window Above"))
map("n", "<Down>", "<C-w>j", defaultOptsWithDesc("Move to Window Below"))
map("n", "<Left>", "<C-w>h", defaultOptsWithDesc("Move to Window Left"))
map("n", "<Right>", "<C-w>l", defaultOptsWithDesc("Move to Window Right"))

-- exit insert mode on jj and jk
map("i", "jj", "<ESC>", defaultOptsWithDesc("Exit Insert Mode"))
map("i", "jk", "<ESC>", defaultOptsWithDesc("Exit Insert Mode"))

-- save file to disk only when there are changes
map("n", "<ESC>", "<CMD>update<CR><ESC>", defaultOptsWithDesc("Save File"))

-- custom keymaps
map("n", "gl", vim.diagnostic.open_float, defaultOptsWithDesc("Show Diagnostics"))

-- use tab to navigate buffers
map("n", "<Tab>", ":bnext<CR>", defaultOptsWithDesc("Next Buffer"))
map("n", "<S-Tab>", ":bprevious<CR>", defaultOptsWithDesc("Previous Buffer"))

-- Copy relative path or absolute path of the current file
map("n", "<leader>fy", ":CopyRelPath<CR>", defaultOptsWithDesc("Copy Relative Path"))
map("n", "<leader>fY", ":CopyPath<CR>", defaultOptsWithDesc("Copy Full Path"))

-- Inside the tmux
if os.getenv("TMUX") then
    -- tmux navigator
    vim.cmd([[
  noremap <silent> <c-h> :<C-U>TmuxNavigateLeft<cr>
  noremap <silent> <c-j> :<C-U>TmuxNavigateDown<cr>
  noremap <silent> <c-k> :<C-U>TmuxNavigateUp<cr>
  noremap <silent> <c-l> :<C-U>TmuxNavigateRight<cr>
  noremap <silent> <c-\> :<C-U>TmuxNavigatePrevious<cr>
]])
    map("n", "<Left>", ":TmuxNavigateLeft<CR>", defaultOptsWithDesc("Tmux Navigate Left"))
    map("n", "<Down>", ":TmuxNavigateDown<CR>", defaultOptsWithDesc("Tmux Navigate Down"))
    map("n", "<Up>", ":TmuxNavigateUp<CR>", defaultOptsWithDesc("Tmux Navigate Up"))
    map("n", "<Right>", ":TmuxNavigateRight<CR>", defaultOptsWithDesc("Tmux Navigate Right"))
end
