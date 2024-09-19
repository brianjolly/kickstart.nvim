-- https://theosteiner.de/debugging-javascript-frameworks-in-neovim
-- https://nextjs.org/docs/pages/building-your-application/configuring/debugging
-- https://www.lazyvim.org/extras/dap/core

return {
  "mfussenegger/nvim-dap",
  lazy = true,
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "theHamsta/nvim-dap-virtual-text",
    "mxsdev/nvim-dap-vscode-js",
    -- lazy spec to build "microsoft/vscode-js-debug" from source
    {
      "microsoft/vscode-js-debug",
      version = "1.x",
      build = "npm i && npm run compile vsDebugServerBundle && mv dist out"
    }
  },

  keys = {
    { "<leader>D", "", desc = "+debug", mode = {"n", "v"} },
    { "<leader>DB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
    { "<leader>Db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<leader>Dc", function() require("dap").continue() end, desc = "Continue" },
    { "<leader>Da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
    { "<leader>DC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
    { "<leader>Dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
    { "<leader>Di", function() require("dap").step_into() end, desc = "Step Into" },
    { "<leader>Dj", function() require("dap").down() end, desc = "Down" },
    { "<leader>Dk", function() require("dap").up() end, desc = "Up" },
    { "<leader>Dl", function() require("dap").run_last() end, desc = "Run Last" },
    { "<leader>Do", function() require("dap").step_out() end, desc = "Step Out" },
    { "<leader>DO", function() require("dap").step_over() end, desc = "Step Over" },
    { "<leader>Dp", function() require("dap").pause() end, desc = "Pause" },
    { "<leader>Dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
    { "<leader>Ds", function() require("dap").session() end, desc = "Session" },
    { "<leader>Dt", function() require("dap").terminate() end, desc = "Terminate" },
    { "<leader>Dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
  },

  config = function()
    require("dap-vscode-js").setup({
      debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
      adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
    })

    for _, language in ipairs({ "typescript", "javascript", "svelte" }) do
      require("dap").configurations[language] = {
        -- attach to a node process that has been started with
        -- `--inspect` for longrunning tasks or `--inspect-brk` for short tasks
        -- npm script -> `node --inspect-brk ./node_modules/.bin/vite dev`
        {
          -- name of the debug action you have to select for this config
          name = "Attach debugger to existing `node --inspect` process",
          -- use nvim-dap-vscode-js's pwa-node debug adapter
          type = "pwa-node",
          -- attach to an already running node process with --inspect flag
          -- default port: 9224
          request = "attach",
          -- allows us to pick the process using a picker
          processId = require 'dap.utils'.pick_process,
          -- for compiled languages like TypeScript or Svelte.js
          sourceMaps = true,
          -- resolve source maps in nested locations while ignoring node_modules
          resolveSourceMapLocations = {
            "${workspaceFolder}/**",
            "!**/node_modules/**" },
          -- path to src in vite based projects (and most other projects as well)
          -- cwd = "${workspaceFolder}/src",
          cwd = "${workspaceFolder}/",
          -- we don't want to debug code inside node_modules, so skip it!
          skipFiles = { "${workspaceFolder}/node_modules/**/*.js" },
        },
        {
          -- https://nextjs.org/docs/pages/building-your-application/configuring/debugging
          name = "Next.js launch test",
          type = "pwa-node",
          request = "launch",
          cwd = "${workspaceFolder}",
          runtimeExecutable = "npm",
          runtimeArgs = {
            "run", "start",
          }
        },
        -- only if language is javascript, offer this debug action
        language == "javascript" and {
          -- use nvim-dap-vscode-js's pwa-node debug adapter
          type = "pwa-node",
          -- launch a new process to attach the debugger to
          request = "launch",
          -- name of the debug action you have to select for this config
          name = "Launch file in new node process",
          -- launch current file
          program = "${file}",
          cwd = "${workspaceFolder}",
        } or nil,
      }
    end

  require("nvim-dap-virtual-text").setup {
    commented = false,
  }

  require("dapui").setup {
    -- Set icons to characters that are more likely to work in every terminal.
    --    Feel free to remove or use ones that you like more! :)
    --    Don't feel like these are good choices.
    icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
    controls = {
      icons = {
        pause = '⏸',
        play = '▶',
        step_into = '⏎',
        step_over = '⏭',
        step_out = '⏮',
        step_back = 'b',
        run_last = '▶▶',
        terminate = '⏹',
        disconnect = '⏏',
      },
    },
    layouts = { {
      elements = { {
        id = "scopes",
        size = 0.50
      }, {
        id = "breakpoints",
        size = 0.10
      }, {
        id = "stacks",
        size = 0.20
      }, {
        id = "watches",
        size = 0.20
      } },
    position = "left",
    size = 80
   }, {
      elements = { {
        id = "repl",
        size = 0.7
      }, {
        id = "console",
        size = 0.3
      } },
      position = "bottom",
      size = 25
    } },
    }

    local dap, dapui = require("dap"), require("dapui")
    dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open({ reset = true })
    end
    dap.listeners.before.event_terminated["dapui_config"] = dapui.close
    dap.listeners.before.event_exited["dapui_config"] = dapui.close
    dap.defaults.fallback.exception_breakpoints = {'raised'}
  end
  }
