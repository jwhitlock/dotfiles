-- Thanks to https://github.com/nvim-lua/kickstart.nvim for initial version
-- See `:help vim.opt`, `:help option-list`

-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true
local opt = vim.opt

-- Save buffers when losing focus
vim.g.autowrite = true

-- Make line numbers default
opt.number = true

-- Enable mouse mode in (almost all) contexts
opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent (use visual indentation of previous line)
opt.breakindent = true

-- Save undo history
opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
opt.ignorecase = true
opt.smartcase = true

-- Keep signcolumn on by default
opt.signcolumn = 'yes'

-- Decrease update time (default 4000)
opt.updatetime = 250

-- Decrease mapped sequence wait time (default 1000)
-- Displays which-key popup sooner
opt.timeoutlen = 300

-- Configure how new splits should be opened
opt.splitright = true
opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, in the buffer and a preview window
opt.inccommand = 'split'

-- Show which line your cursor is on
opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 10

-- auto-read if file has changed outside vim but not inside
opt.autoread = true
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold', 'CursorHoldI' }, {
  desc = 'Check if the file changed on disk',
  group = vim.api.nvim_create_augroup('jw-autoreload', { clear = true }),
  callback = function()
    if vim.api.nvim_get_mode().mode ~= 'c' then
      vim.cmd 'checktime'
    end
  end,
})

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Older config
--[[
opt.secure = true -- limit commands .nvimrc can run
opt.autoindent = true -- copy indent from current line when starting new line
opt.expandtab = true -- use spaces instead of tabs
opt.history = 1000 -- remember the last 1000 commands used
opt.hlsearch = true -- highlight matches when searching
opt.incsearch = true -- jump to next match when searching
opt.shiftwidth = 4 -- 4 spaces for indents when using << or >>
opt.smarttab = true -- use <BS> to delete shiftwidth worth of space at start of line
opt.softtabstop = 4 -- 4 spaces for tabsin INSERT mode
opt.tabstop = 4 -- 4 spaces for tabs
]]
--

opt.termguicolors = vim.fn.has 'termguicolors' == 1 and true or false

if vim.g.gui_vimr then
  -- VimR config
  opt.background = 'light'
end
vim.cmd 'colorscheme zellner'
vim.cmd 'filetype plugin indent on'

-- Disable some providers for clean healthcheck
-- https://neovim.io/doc/user/provider.html
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

-- neovim 0.11
-- LSP: https://gpanders.com/blog/whats-new-in-neovim-0-11/#lsp
vim.lsp.enable {
  'ts_ls',
  'lua_ls',
  'pylsp',
  'typos_lsp',
  'taplo',
  'groovyls',
}
