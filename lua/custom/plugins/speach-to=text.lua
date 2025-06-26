-- return {'eyalk11/speech-to-text.nvim'}

return {
  vim.api.nvim_set_keymap('n', '<leader>st', ':!python stt.py | tee speech.txt | xargs -I {} echo "{}" >> %<CR>', { noremap = true, silent = true });
}
