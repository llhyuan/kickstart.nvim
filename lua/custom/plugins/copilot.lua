return {
  'zbirenbaum/copilot.lua',
  requires = {
    'copilotlsp-nvim/copilot-lsp', -- (optional) for NES functionality
  },
  cmd = 'Copilot',
  event = 'InsertEnter',
  config = function()
    require('copilot').setup {
      panel = {
        enabled = false,
        -- auto_refresh = false,
        -- keymap = {
        --   jump_prev = '[[',
        --   jump_next = ']]',
        --   accept = '<CR>',
        --   refresh = 'gr',
        --   open = '<M-o>',
        -- },
        -- layout = {
        --   position = 'bottom', -- | top | left | right | bottom |
        --   ratio = 0.3,
        -- },
      },
      suggestion = {
        enabled = false,
        -- auto_trigger = false,
        -- hide_during_completion = true,
        -- debounce = 75,
        -- trigger_on_accept = true,
        -- keymap = {
        --   accept = '<M-l>',
        --   accept_word = false,
        --   accept_line = false,
        --   next = '<M-j>',
        --   prev = '<M-k>',
        --   dismiss = '<M-h>',
        -- },
      },
      nes = {
        enabled = true,
      },
      filetypes = {
        sh = function()
          if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), '^%.env.*') then
            -- disable for .env files
            return false
          end
          return true
        end,
      },
      workspace_folders = {
        '/Users/hangyuan/Documents/Repositories/flowplan/',
        '/Users/hangyuan/Documents/Repositories/flowplan-server/',
        '/Users/hangyuan/Documents/Repositories/flowplan-shared/',
        '/Users/hangyuan/Documents/Repositories/flowplan-field-office/',
      },
    }

    vim.api.nvim_create_autocmd('User', {
      pattern = 'BlinkCmpMenuOpen',
      callback = function()
        vim.b.copilot_suggestion_hidden = true
      end,
    })

    vim.api.nvim_create_autocmd('User', {
      pattern = 'BlinkCmpMenuClose',
      callback = function()
        vim.b.copilot_suggestion_hidden = false
      end,
    })
  end,
}
