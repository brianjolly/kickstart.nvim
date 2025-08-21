return {
  'folke/edgy.nvim',
  event = 'VeryLazy',
  init = function()
    vim.opt.laststatus = 3
    vim.opt.splitkeep = 'screen'
  end,
  opts = {
    wo = {
      winbar = false,
      winfixwidth = false,
    },
    keys = {
      ['o'] = false,
      ['<c-w>>'] = function(win)
        win:resize('width', 10)
      end,
      ['<c-w><lt>'] = function(win)
        win:resize('width', -10)
      end,
      ['<c-w>+'] = function(win)
        win:resize('height', 2)
      end,
      ['<c-w>-'] = function(win)
        win:resize('height', -2)
      end,
    },
    left = {
      {
        title = function()
          local buf_name = vim.api.nvim_buf_get_name(0) or '[No Name]'
          return vim.fn.fnamemodify(buf_name, ':t')
        end,
        ft = 'Outline',
        pinned = false,
        open = 'SymbolsOutlineOpen',
        wo = { winfixwidth = false },
      },
      {
        title = 'Neo-Tree',
        ft = 'neo-tree',
        filter = function(buf)
          return vim.b[buf].neo_tree_source == 'filesystem'
        end,
        wo = { winfixwidth = false },
        --size = { height = 0.5, width = 75 },
      },
      {
        title = 'Neo-Tree Git',
        ft = 'neo-tree',
        filter = function(buf)
          return vim.b[buf].neo_tree_source == 'git_status'
        end,
        pinned = false,
        collapsed = true, -- show window as closed/collapsed on start
        open = 'Neotree position=right git_status',
        wo = { winfixwidth = false },
      },
      {
        title = 'Neo-Tree Buffers',
        ft = 'neo-tree',
        filter = function(buf)
          return vim.b[buf].neo_tree_source == 'buffers'
        end,
        pinned = false,
        collapsed = true, -- show window as closed/collapsed on start
        open = 'Neotree position=top buffers',
        wo = { winfixwidth = false },
      },
      -- any other neo-tree windows
      'neo-tree',
    },
  },
}
