return {
  'carbon-steel/detour.nvim',
  config = function()
    require('detour').setup {
      -- Put custom configuration here
    }
    vim.keymap.set('n', '<leader>pp', ':Detour<cr>')
    vim.keymap.set('n', '<leader>pc', ':DetourCurrentWindow<cr>')
  end,
}
