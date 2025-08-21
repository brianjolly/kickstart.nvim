--		return {
--		  'Davidyz/VectorCode',
--		  version = '*', -- optional, depending on whether you're on nightly or release
--		  build = 'uv tool upgrade vectorcode', -- This helps keeping the CLI up-to-date
--		  dependencies = { 'nvim-lua/plenary.nvim' },
--		  cmd = 'VectorCode', -- if you're lazy-loading VectorCode
--		}

return {
  'Davidyz/VectorCode',
  -- dir = "~/git/VectorCode/",
  version = '*',
  -- build = "uv tool upgrade vectorcode",
  build = function(plugin)
    if vim.fn.executable 'uv' ~= 1 then
      return vim.notify('Failed to install VectorCode because `uv` is missing.', vim.log.levels.WARN)
    end
    local stdpath = vim.fn.stdpath 'data'
    if string.find(plugin.dir, stdpath) then
      local command
      if vim.fn.executable 'vectorcode' == 1 then
        command = 'uv tool upgrade vectorcode'
      else
        command = 'uv tool install "vectorcode[lsp,mcp]"'
      end
      vim.system(vim.split(command, ' ', { trimempty = true }), {}, nil)
    end
  end,
  opts = function()
    return {
      async_backend = 'lsp',
      notify = true,
      on_setup = { lsp = true },
      n_query = 10,
      timeout_ms = -1,
      async_opts = {
        events = { 'BufWritePost' },
        single_job = true,
        query_cb = require('vectorcode.utils').make_surrounding_lines_cb(40),
        debounce = -1,
        n_query = 30,
      },
    }
  end,
  config = function(_, opts)
    vim.lsp.config('vectorcode_server', {
      cmd_env = {
        HTTP_PROXY = 'http://localhost:8000', --os.getenv 'HTTP_PROXY',
        HTTPS_PROXY = 'https://localhost:8000', --os.getenv 'HTTPS_PROXY',
      },
    })
    require('vectorcode').setup(opts)
    -- vim.api.nvim_create_autocmd("LspAttach", {
    --   callback = function()
    --     require("vectorcode.config").get_cacher_backend().register_buffer(0)
    --   end,
    -- })
  end,
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  cmd = 'VectorCode',
  cond = function()
    --return vim.fn.executable 'vectorcode' == 1 and utils.no_vscode()
  end,
}
