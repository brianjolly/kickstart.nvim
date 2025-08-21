return {
  --'varnishcache-friends/vim-varnish',
  'cappyzawa/telescope-terraform.nvim',
  ft = { 'terraform', 'hcl' },
  config = function()
    LazyVim.on_load('telescope.nvim', function()
      require('telescope').load_extension 'terraform'
    end)
  end,
  'cappyzawa/telescope-terraform.nvim',
  ft = { 'terraform', 'hcl' },
  config = function()
    LazyVim.on_load('telescope.nvim', function()
      require('telescope').load_extension 'terraform'
    end)
  end,
  'neovim/nvim-lspconfig',
  opts = {
    servers = {
      terraformls = {},
    },
  },
}
