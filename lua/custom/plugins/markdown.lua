return {
  'MeanderingProgrammer/render-markdown.nvim',
  ft = { 'markdown', 'codecompanion' },
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    local function set_my_markdown_inline_code_hl()
      if vim.o.background == 'light' then
        vim.api.nvim_set_hl(0, 'MyMarkdownCodeInline', { fg = '#24292f', bg = '#e7eaee' })
        vim.api.nvim_set_hl(0, 'MyMarkdownCodeBlock', { fg = '#24292f', bg = '#e7eaee' })
      else
        vim.api.nvim_set_hl(0, 'MyMarkdownCodeInline', { fg = '#f0f0f0', bg = '#000000' })
        vim.api.nvim_set_hl(0, 'MyMarkdownCodeBlock', { fg = '#f0f0f0', bg = '#000000' })
      end
    end

    -- Define custom groups for icon & background
    vim.api.nvim_set_hl(0, 'MyMarkdownH1', { fg = '#ffffff', bold = true })
    vim.api.nvim_set_hl(0, 'MyMarkdownH2', { fg = '#ffffff', bold = false })
    vim.api.nvim_set_hl(0, 'MyMarkdownH1Bg', { bg = '#303030' })
    vim.api.nvim_set_hl(0, 'MyMarkdownH2Bg', { bg = '#303030' })

    set_my_markdown_inline_code_hl()

    -- Override Treesitter group for actual H2 text
    vim.api.nvim_set_hl(0, '@markup.heading.1.markdown', { fg = '#ffffff', bold = true })
    vim.api.nvim_set_hl(0, '@markup.heading.2.markdown', { fg = '#ffffff', bold = false })

    local group = vim.api.nvim_create_augroup('MyMarkdownCustomHls', { clear = true })
    vim.api.nvim_create_autocmd('ColorScheme', {
      group = group,
      pattern = '*',
      callback = function()
        vim.api.nvim_set_hl(0, '@markup.heading.1.markdown', { fg = '#ffffff', bold = true })
        vim.api.nvim_set_hl(0, '@markup.heading.2.markdown', { fg = '#ffffff', bold = false })
        set_my_markdown_inline_code_hl()
      end,
    })
    vim.api.nvim_create_autocmd('OptionSet', {
      group = group,
      pattern = 'background',
      callback = set_my_markdown_inline_code_hl,
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
        highlight = 'MyMarkdownCodeBlock',
      },
    }
  end,
}
