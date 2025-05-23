return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "j-hui/fidget.nvim",
  },
  init = function()
    require("custom.plugins.codecompanion.fidget-spinner"):init()
  end,
  opts = {
    opts = {
      log_level = "DEBUG",
    },
    strategies = {
      chat = {
        adapter = "qwen",
      },
      inline = {
        adapter = "qwen",
      },
      cmd = {
        adapter = "qwen",
      }
    },
    adapters = {
      qwen = function()
        return require("codecompanion.adapters").extend("ollama", {
          env = {
            url = "http://192.168.2.147:11434",
            --url = "http://192.168.1.9:11434",
            --api_key = "OLLAMA_API_KEY",
          },
          schema = {
            model = {
              default = "qwen2.5-coder:32b",
              --default = "qwen2.5-coder:7b",
              --default = "deepseek-coder:6.7b",
              --default = "llama3:latest",
              --default = "gemma3:27b",
              --default = "qwq:latest",
            },
          },
          headers = {
            ["Content-Type"] = "application/json",
            ["Authorization"] = "Bearer ${api_key}",
          },
          parameters = {
            sync = true,
          },
        })
      end,
      gemma3 = function()
        return require("codecompanion.adapters").extend("ollama", {
          env = {
            url = "http://192.168.1.9:11434",
            --api_key = "OLLAMA_API_KEY",
          },
          schema = {
            model = {
              default = "gemma3:27b",
              --default = "qwen2.5-coder:7b",
              --default = "deepseek-coder:6.7b",
              --default = "llama3:latest",
              --default = "qwq:latest",
            },
          },
          headers = {
            ["Content-Type"] = "application/json",
            ["Authorization"] = "Bearer ${api_key}",
          },
          parameters = {
            sync = true,
          },
        })
      end,
      deepseek = function()
        return require("codecompanion.adapters").extend("ollama", {
          env = {
            url = "http://192.168.1.9:11434",
            --api_key = "OLLAMA_API_KEY",
          },
          schema = {
            model = {
              default = "deepseek-coder:6.7b",
            },
          },
          headers = {
            ["Content-Type"] = "application/json",
            ["Authorization"] = "Bearer ${api_key}",
          },
          parameters = {
            sync = true,
          },
        })
      end,
    },
  },
}
