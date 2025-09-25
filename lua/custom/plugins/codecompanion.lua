local ollama_addr = 'localhost:11434'

return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'ravitemer/codecompanion-history.nvim',
    'j-hui/fidget.nvim',
    {
      'MeanderingProgrammer/render-markdown.nvim',
      dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
      ft = { 'markdown', 'codecompanion' },
    },
  },
  init = function()
    require('custom.plugins.codecompanion.fidget-spinner'):init()
  end,
  keys = {
    { '<leader>cc', '', desc = '+codecompanion', mode = { 'n', 'v' } },
    { '<leader>ccp', '<cmd>CodeCompanionActions<cr>', mode = { 'n', 'v' }, desc = 'Prompt Actions (CodeCompanion)' },
    { '<leader>cct', '<cmd>CodeCompanionChat Toggle<cr>', mode = { 'n', 'v' }, desc = 'Toggle (CodeCompanion)' },
    { '<leader>cca', '<cmd>CodeCompanionChat Add<cr>', mode = 'v', desc = 'Add code to CodeCompanion' },
    { '<leader>cci', '<cmd>CodeCompanion<cr>', mode = 'n', desc = 'Inline prompt (CodeCompanion)' },
  },
  opts = {
    opts = {
      log_level = 'DEBUG',
    },
    strategies = {
      chat = {
        adapter = 'claude',
      },
      inline = {
        adapter = 'claude',
        keymaps = {
          accept_change = { modes = { n = '<leader>gda' } }, -- gDiffAccept },
          reject_change = { modes = { n = '<leader>gdr' } }, -- gDiffReject },
          always_accept = { modes = { n = '<leader>gdt' } },
        },
      },
      cmd = {
        adapter = 'claude',
      },
    },
    display = {
      chat = {
        auto_scroll = false,
        -- intro_message = "Welcome to CodeCompanion ✨! Press ? for options",
        show_header_separator = false, -- Show header separators in the chat buffer? Set this to false if you're using an external markdown formatting plugin
        separator = '─', -- The separator between the different messages in the chat buffer
        show_references = true, -- Show references (from slash commands and variables) in the chat buffer?
        show_settings = false, -- Show LLM settings at the top of the chat buffer?
        show_token_count = true, -- Show the token count for each response?
        start_in_insert_mode = true, -- Open the chat buffer in insert mode?
      },
    },
    extensions = {
      mcphub = {
        callback = 'mcphub.extensions.codecompanion',
        opts = {
          make_tools = true,
          show_server_tools_in_chat = true,
          add_mcp_prefix_to_tool_names = false,
          show_result_in_chat = true,
          make_vars = true,
          make_slash_commands = true,
        },
      },
      vectorcode = {},
      -- vectorcode = {
      --   opts = function()
      --     return { add_tool = true }
      --   end,
      --   -- opts = {
      --   --   add_tool = true,
      --   -- },
      -- },
    },
    adapters = {
      http = {
        gemini = function()
          return require('codecompanion.adapters').extend('gemini', {
            schema = {
              model = { default = 'gemini-2.5-pro' },
            },
            env = { api_key = 'cmd: cat ~/.gemini-token' },
          })
        end,
        claude = function()
          return require('codecompanion.adapters').extend('anthropic', {
            schema = {
              model = { default = 'claude-3-5-sonnet-latest' },
            },
            env = {
              api_key = 'cmd: cat ~/.anthropic-token',
            },
          })
        end,
        gptoss = function()
          return require('codecompanion.adapters').extend('ollama', {
            env = {
              url = ollama_addr,
            },
            schema = { model = { default = 'gpt-oss:20b' } },
            headers = {
              ['Content-Type'] = 'application/json',
              ['Authorization'] = 'Bearer ${api_key}',
            },
            parameters = { sync = true },
          })
        end,
        devstral = function()
          return require('codecompanion.adapters').extend('ollama', {
            env = {
              url = ollama_addr,
            },
            schema = {
              model = {
                default = 'devstral:24b',
              },
            },
            headers = {
              ['Content-Type'] = 'application/json',
              ['Authorization'] = 'Bearer ${api_key}',
            },
            parameters = {
              sync = true,
            },
          })
        end,
        awen3coder = function()
          return require('codecompanion.adapters').extend('ollama', {
            env = {
              url = ollama_addr,
            },
            schema = {
              model = {
                default = 'qwen3-coder:30b',
              },
            },
            headers = {
              ['Content-Type'] = 'application/json',
              ['Authorization'] = 'Bearer ${api_key}',
            },
            parameters = {
              sync = true,
            },
          })
        end,
        gemma3 = function()
          return require('codecompanion.adapters').extend('ollama', {
            env = {
              url = 'http://192.168.1.9:11434',
            },
            schema = {
              model = {
                default = 'gemma3:27b',
              },
            },
            headers = {
              ['Content-Type'] = 'application/json',
              ['Authorization'] = 'Bearer ${api_key}',
            },
            parameters = {
              sync = true,
            },
          })
        end,
        deepseek = function()
          return require('codecompanion.adapters').extend('ollama', {
            env = {
              url = 'http://192.168.1.9:11434',
            },
            schema = {
              model = {
                default = 'deepseek-coder:6.7b',
              },
            },
            headers = {
              ['Content-Type'] = 'application/json',
              ['Authorization'] = 'Bearer ${api_key}',
            },
            parameters = {
              sync = true,
            },
          })
        end,
      },
    },
  },
}
