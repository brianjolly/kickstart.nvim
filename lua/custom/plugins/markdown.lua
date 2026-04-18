return {
  'MeanderingProgrammer/render-markdown.nvim',
  ft = { 'markdown', 'codecompanion' },
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    -- Define custom groups for icon & background
    vim.api.nvim_set_hl(0, 'MyMarkdownH1', { fg = '#ffffff', bold = true })
    vim.api.nvim_set_hl(0, 'MyMarkdownH2', { fg = '#ffffff', bold = false })
    vim.api.nvim_set_hl(0, 'MyMarkdownH1Bg', { bg = '#303030' })
    vim.api.nvim_set_hl(0, 'MyMarkdownH2Bg', { bg = '#303030' })

    -- Inline `code` — explicit fg/bg so text stays readable over the pill background
    vim.api.nvim_set_hl(0, 'MyMarkdownCodeInline', { fg = '#f0f0f0', bg = '#3d3d3d' })

    -- Override Treesitter group for actual H2 text
    vim.api.nvim_set_hl(0, '@markup.heading.1.markdown', { fg = '#ffffff', bold = true })
    vim.api.nvim_set_hl(0, '@markup.heading.2.markdown', { fg = '#ffffff', bold = false })

    -- Also re-apply it after colorscheme changes
    vim.api.nvim_create_autocmd('ColorScheme', {
      pattern = '*',
      callback = function()
        vim.api.nvim_set_hl(0, '@markup.heading.1.markdown', { fg = '#ffffff', bold = true })
        vim.api.nvim_set_hl(0, '@markup.heading.2.markdown', { fg = '#ffffff', bold = false })
        vim.api.nvim_set_hl(0, 'MyMarkdownCodeInline', { fg = '#f0f0f0', bg = '#3d3d3d' })
      end,
    })

    -- Set up the plugin
    require('render-markdown').setup {
      heading = {
        border = false,
        border_virtual = true,
        backgrounds = {
          --'RenderMarkdownH1Bg',
          'MyMarkdownH1Bg',
          'MyMarkdownH2Bg',
        },
        foregrounds = {
          --'RenderMarkdownH1',
          'MyMarkdownH1',
          'MyMarkdownH2',
        },
      },
      indent = {
        enabled = true,
        skip_heading = true,
      },
      code = {
        highlight_inline = 'MyMarkdownCodeInline',
      },
    }
  end,
}
