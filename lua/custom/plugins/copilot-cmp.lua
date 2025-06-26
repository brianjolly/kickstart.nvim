--return {}

return {
  'saghen/blink.cmp',
  dependencies = {
    {
      'giuxtaposition/blink-cmp-copilot',
    },
  },
  opts = {
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer', 'copilot' },
      providers = {
        copilot = {
          name = 'copilot',
          module = 'blink-cmp-copilot',
          score_offset = 100,
          async = true,
        },
      },
    },
  },
}

--return {
--  'zbirenbaum/copilot-cmp',
--  --dependencies =
--  dependencies = {
--    'copilot.lua',
--    { 'giuxtaposition/blink-cmp-copilot' },
--  },
--  opts = {},
--  config = function(_, opts)
--    local copilot_cmp = require 'copilot_cmp'
--    copilot_cmp.setup(opts)
--    -- attach cmp source whenever copilot attaches
--    -- fixes lazy-loading issues with the copilot cmp source
--    local on_attach = function(client, _)
--      if client.name == 'copilot' then
--        copilot_cmp._on_insert_enter {}
--      end
--    end
--    vim.api.nvim_create_autocmd('LspAttach', {
--      callback = function(args)
--        local buffer = args.buf ---@type number
--        local client = vim.lsp.get_client_by_id(args.data.client_id)
--        on_attach(client, buffer)
--      end,
--    })
--  end,
--}
