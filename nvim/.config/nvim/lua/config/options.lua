-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options hereby

-- Vim options
local vimOptions = {
  -- guifont = "VictorMono Nerd Font:h17", -- set font
  title = true, -- set title of window
  titlestring = "%<%F", -- set title to filename
  number = true, -- set numbered lines
  relativenumber = true, -- set relative numbered lines
  termguicolors = true, -- set term gui colors (most terminals support this)
  cursorline = true, -- highlight cursor line
  fileencoding = "utf-8", -- the encoding written to a file
  pumblend = 0,
  colorcolumn = "80",
  laststatus = 0, -- disable statusline
  -- smoothscroll = true,
  joinspaces = false,
  belloff = "all",
  wildmode = "longest:full",
  wildoptions = "pum",
  showmode = false,
  showcmd = true,
  cmdheight = 1, -- Height of the command bar
  showmatch = true, -- show matching brackets when text indicator is over them
  hidden = true, -- I like having buffers stay around
  equalalways = false, -- I don't like my windows changing all the time
  splitright = true, -- Prefer windows splitting to the right
  splitbelow = true, -- Prefer windows splitting to the bottom
  updatetime = 1000, -- Make updates happen faster
  scrolloff = 10, -- Make it so there are always ten lines below my cursor

  -- search
  hlsearch = true,
  incsearch = true,
  ignorecase = true,

  -- backup
  backup = false,
  swapfile = false,
  undofile = true, -- enable persistent undo
  undodir = os.getenv("HOME") .. "/.vim/undodir",

  -- wrapping
  wrap = true,
  linebreak = true,
  breakindent = true,
  showbreak = string.rep(" ", 3), -- Make it so that long lines wrap smartly

  -- spelling
  spell = false,
  spelllang = { "en_us" },

  -- indent
  tabstop = 2,
  softtabstop = 2,
  shiftwidth = 2,
  expandtab = true,
  smartindent = true,
  autoindent = true,
  cindent = true,
}

for k, v in pairs(vimOptions) do
  vim.opt[k] = v
end

-- Disable auto-formatting
vim.g.autoformat = false -- globally
vim.b.autoformat = false -- buffer-local

-- Cursorline highlighting control
--  Only have it on in the active buffer
local group = vim.api.nvim_create_augroup("CursorLineControl", { clear = true })
local set_cursorline = function(event, value, pattern)
  vim.api.nvim_create_autocmd(event, {
    group = group,
    pattern = pattern,
    callback = function()
      vim.opt_local.cursorline = value
    end,
  })
end
set_cursorline("WinLeave", false)
set_cursorline("WinEnter", true)
set_cursorline("FileType", false, "TelescopePrompt")

-- Vim options: disable ~ on empty lines
vim.opt.fillchars = vim.opt.fillchars + "eob: "
vim.opt.fillchars:append({
  stl = " ",
})

-- Copy Relative Path
vim.api.nvim_create_user_command("CopyRelPath", function()
  local relative_path = vim.fn.expand("%:.")
  vim.fn.setreg("+", relative_path)
  vim.notify('Copied "' .. relative_path .. '" to the clipboard!')
end, {})

-- Copy Absolute Path
vim.api.nvim_create_user_command("CopyPath", function()
  local absolute_path = vim.fn.expand("%:p")
  vim.fn.setreg("+", absolute_path)
  vim.notify('Copied "' .. absolute_path .. '" to the clipboard!')
end, {})

-- Add new commands
vim.cmd([[command! -nargs=0 GoToCommand :FzfLua commands]])
vim.cmd([[command! -nargs=0 GoToFile :FzfLua files]])
vim.cmd([[command! -nargs=0 Grep :FzfLua grep]])

-- Enable this option to avoid conflicts with Prettier.
vim.g.lazyvim_prettier_needs_config = true
