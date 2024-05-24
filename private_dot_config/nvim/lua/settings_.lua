local opt = vim.opt

opt.secure = true -- limit commands .nvimrc can run
opt.autoindent = true -- copy indent from current line when starting new line
opt.autoread = true -- auto-read if file has changed outside vim but not inside
opt.expandtab = true -- use spaces instead of tabs
opt.history = 1000 -- remember the last 1000 commands used
opt.hlsearch = true -- highlight matches when searching
opt.incsearch = true -- jump to next match when searching
opt.shiftwidth = 4 -- 4 spaces for indents when using << or >>
opt.smarttab = true -- use <BS> to delete shiftwidth worth of space at start of line
opt.softtabstop = 4 -- 4 spaces for tabsin INSERT mode
opt.tabstop = 4 -- 4 spaces for tabs

opt.cursorline = true
opt.number = true
opt.termguicolors = vim.fn.has("termguicolors") == 1 and true or false

if vim.g.gui_vimr
then
  -- VimR config
  opt.background=light
  vim.cmd 'colorscheme zellner'
end

vim.cmd 'filetype plugin indent on'
