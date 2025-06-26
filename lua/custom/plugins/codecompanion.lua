local ollama_addr = 'localhost:11434'

return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'j-hui/fidget.nvim',
  },
  init = function()
    require('custom.plugins.codecompanion.fidget-spinner'):init()
  end,
  opts = {
    opts = {
      log_level = 'DEBUG',
    },
    strategies = {
      chat = {
        adapter = 'qwen',
      },
      inline = {
        adapter = 'qwen',
      },
      cmd = {
        adapter = 'qwen',
      },
    },
    display = {
      chat = {
        auto_scroll = false,
        -- intro_message = "Welcome to CodeCompanion ✨! Press ? for options",
        -- show_header_separator = false, -- Show header separators in the chat buffer? Set this to false if you're using an external markdown formatting plugin
        -- separator = "─", -- The separator between the different messages in the chat buffer
        show_references = true, -- Show references (from slash commands and variables) in the chat buffer?
        show_settings = true, -- Show LLM settings at the top of the chat buffer?
        show_token_count = true, -- Show the token count for each response?
        start_in_insert_mode = true, -- Open the chat buffer in insert mode?
      },
    },
    adapters = {
      devstral = function()
        return require('codecompanion.adapters').extend('ollama', {
          env = {
            url = ollama_addr, --"http://localhost:11434",
            --url = "http://192.168.2.146:11434",
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
      qwen = function()
        return require('codecompanion.adapters').extend('ollama', {
          env = {
            url = ollama_addr, --"http://192.168.2.147:11434",
            --url = "http://192.168.1.9:11434",
            --api_key = "OLLAMA_API_KEY",
          },
          schema = {
            model = {
              --default = "qwen2.5-coder:14b",
              default = 'qwen2.5-coder:32b',
              --default = "qwen2.5-coder:7b",
              --default = "deepseek-coder:6.7b",
              --default = "llama3:latest",
              --default = "gemma3:27b",
              --default = "qwq:latest",
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
            --api_key = "OLLAMA_API_KEY",
          },
          schema = {
            model = {
              default = 'gemma3:27b',
              --default = "qwen2.5-coder:7b",
              --default = "deepseek-coder:6.7b",
              --default = "llama3:latest",
              --default = "qwq:latest",
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
            --api_key = "OLLAMA_API_KEY",
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
}
