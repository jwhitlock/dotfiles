-- VSCode color scheme
-- This one looks decent in light mode in command line nvim
-- https://github.com/Mofiqul/vscode.nvim

return {
  'Mofiqul/vscode.nvim',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  init = function()
    -- Load the colorscheme here.
    -- Like many other themes, this one has different styles, and you could load
    -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
    vim.o.background = 'light'
    if not vim.g.gui_vimr then
      vim.cmd.colorscheme 'vscode'
    end

    -- You can configure highlights by doing something like:
    vim.cmd.hi 'Comment gui=none'
  end,
}
