-- https://github.com/CopilotC-Nvim/CopilotChat.nvim
--
return {
  "CopilotC-Nvim/CopilotChat.nvim",
  branch = "canary",
  dependencies = {
    { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
    { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
  },
  build = "make tiktoken", -- Only on MacOS or Linux
  opts = {
    debug = true, -- Enable debugging
    model = 'gpt-4o' -- 'gpt-4o' -- 'gpt-3.5-turbo' 'gpt-4' 'gpt-4o' 'o1-preview'
    -- See Configuration section for rest
  },
  -- See Commands section for default commands if you want to lazy load on them
  keys = {
    { "<c-s>", "<CR>", ft = "copilot-chat", desc = "Submit Prompt", remap = true },
    { "<leader>cp", "", desc = "+copilot", mode = { "n", "v" } },
    {
      "<leader>cpt",
      function()
        return require("CopilotChat").toggle()
      end,
      desc = "Toggle (CopilotChat)",
      mode = { "n", "v" },
    },
    {
      "<leader>cpx",
      function()
        return require("CopilotChat").reset()
      end,
      desc = "Clear (CopilotChat)",
      mode = { "n", "v" },
    },
    {
      "<leader>cpq",
      function()
        local input = vim.fn.input("Quick Chat: ")
        if input ~= "" then
          require("CopilotChat").ask(input)
        end
      end,
      desc = "Quick Chat (CopilotChat)",
      mode = { "n", "v" },
    },
    {
      "<leader>cph",
      function()
        local actions = require("CopilotChat.actions")
        require("CopilotChat.integrations.telescope").pick(actions.help_actions())
      end,
      desc = "Help actions (CopilotChat)",
    },
    -- Show prompts actions with telescope
    {
      "<leader>cpp",
      function()
        local actions = require("CopilotChat.actions")
        require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
      end,
      mode = { "n", "v" },
      desc = "Telescope Prompt (CopilotChat)",
    },
    -- Show help actions with telescope
    --{ "<leader>ad", M.pick("help"), desc = "Diagnostic Help (CopilotChat)", mode = { "n", "v" } },
    -- Show prompts actions with telescope
    --{ "<leader>ap", M.pick("prompt"), desc = "Prompt Actions (CopilotChat)", mode = { "n", "v" } },
  }
}
