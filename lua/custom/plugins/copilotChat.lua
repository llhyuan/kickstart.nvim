return {
  'CopilotC-Nvim/CopilotChat.nvim',
  dependencies = {
    { 'nvim-lua/plenary.nvim', branch = 'master' },
  },
  build = 'make tiktoken',
  init = function()
    -- Auto-command to customize chat buffer behavior
    vim.api.nvim_create_autocmd('BufEnter', {
      pattern = 'copilot-*',
      callback = function()
        vim.opt_local.relativenumber = false
        vim.opt_local.number = false
        vim.opt_local.conceallevel = 0
      end,
    })
  end,
  opts = {
    model = 'gpt-4.1', -- AI model to use
    temperature = 0.1, -- Lower = focused, higher = creative
    window = {
      layout = 'vertical', -- 'vertical', 'horizontal', 'float'
      width = 0.5, -- 50% of screen width
    },
    auto_insert_mode = true,
    -- See Configuration section for options
  },
}
