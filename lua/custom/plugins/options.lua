vim.opt.foldmethod = 'indent'
-- open a terminal
vim.keymap.set('n', '<leader>tt', '<cmd>below split | terminal<CR>', { desc = 'Open a terminal buffer' })
-- escape to normal mode terminal
vim.keymap.set('t', '<leader><Esc><Esc>', '<C-\\><C-n>', {desc = 'Exit terminal mode'})
-- edit this configuration file
vim.keymap.set('n', '<leader>ec', ':e $MYVIMRC<CR>', { desc = 'Edit Neovim config' })
--
          -- Function to toggle virtual text diagnostics
          function ToggleVirtualText()
            if vim.g.virtual_text_enabled == nil then
              --vim.g.virtual_text_enabled = true
              vim.g.virtual_lines = true
            end

            --vim.g.virtual_text_enabled = not vim.g.virtual_text_enabled
            vim.g.virtual_lines = not vim.g.virtual_lines

            -- vim.diagnostic.config({
            --   virtual_text = vim.g.virtual_text_enabled
            -- })
            vim.diagnostic.config({
              virtual_lines = vim.g.virtual_lines
            })
          end
          -- Map the function to a key combination (e.g., <leader>tv)
          vim.api.nvim_set_keymap('n', '<leader>dh', ':lua ToggleVirtualText()<CR>', { noremap = true, silent = true })

return {
  'varnishcache-friends/vim-varnish',
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },
  {
    "toppair/peek.nvim",
    event = { "VeryLazy" },
    build = "deno task --quiet build:fast",
    config = function()
      require("peek").setup()
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
  },
}
