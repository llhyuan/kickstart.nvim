-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
  },
  keys = {
    -- Basic debugging keymaps, feel free to change to your liking!
    {
      '<leader>dS',
      function()
        require('dap').continue()
      end,
      desc = 'Debug: Start/Continue',
    },
    {
      '<leader>di',
      function()
        require('dap').step_into()
      end,
      desc = 'Debug: Step Into',
    },
    {
      '<leader>do',
      function()
        require('dap').step_over()
      end,
      desc = 'Debug: Step Over',
    },
    {
      '<leader>dO',
      function()
        require('dap').step_out()
      end,
      desc = 'Debug: Step Out',
    },
    {
      '<leader>b',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'Debug: Toggle Breakpoint',
    },
    {
      '<leader>B',
      function()
        require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end,
      desc = 'Debug: Set Breakpoint',
    },
    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    {
      '<leader>dl',
      function()
        require('dapui').toggle()
      end,
      desc = 'Debug: See last session result.',
    },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'delve',
        'js-debug-adapter',
      },
    }
    if not dap.adapters['pwa-node'] then
      require('dap').adapters['pwa-node'] = {
        type = 'server',
        host = 'localhost',
        port = '${port}',
        executable = {
          command = vim.fn.stdpath 'data' .. '/mason/bin/js-debug-adapter',
          args = {
            '${port}',
          },
        },
        options = {
          initialize_timeout_sec = 30,
        },
      }
    end

    -- Add pwa-chrome adapter for debugging web applications
    if not dap.adapters['pwa-chrome'] then
      dap.adapters['pwa-chrome'] = {
        type = 'server',
        host = 'localhost',
        port = '${port}',
        executable = {
          command = vim.fn.stdpath 'data' .. '/mason/bin/js-debug-adapter',
          args = {
            '${port}',
          },
        },
        options = {
          initialize_timeout_sec = 30,
        },
      }
    end
    for _, language in ipairs { 'typescript', 'javascript' } do
      if not dap.configurations[language] then
        dap.configurations[language] = {
          {
            type = 'pwa-node',
            request = 'launch',
            name = 'Launch file',
            program = '${file}',
            cwd = '${workspaceFolder}',
          },
          -- Debug nodejs processes (make sure to add --inspect when you run the process)
          -- {
          --   type = 'pwa-node',
          --   request = 'attach',
          --   name = 'Attach to Node',
          --   processId = require('dap.utils').pick_process,
          --   cwd = '${workspaceFolder}',
          --   restart = true,
          --   sourceMaps = true,
          --   skipFiles = { '<node_internals>/**' },
          --   resolveSourceMapLocations = { '${workspaceFolder}/**', '!**/node_modules/**' },
          -- },
          {
            type = 'pwa-node',
            request = 'attach',
            name = 'Attach to Node (Port 9229)',
            address = 'localhost',
            port = 9229,
            cwd = '${workspaceFolder}',
            restart = true,
            sourceMaps = true,
            skipFiles = { '<node_internals>/**' },
            resolveSourceMapLocations = { '${workspaceFolder}/**', '!**/node_modules/**' },
          },
          -- {
          --   type = 'pwa-node',
          --   request = 'attach',
          --   name = 'Attach to Node (Custom Port)',
          --   address = 'localhost',
          --   port = function()
          --     return tonumber(vim.fn.input('Debug port: ', '9229'))
          --   end,
          --   cwd = '${workspaceFolder}',
          --   restart = true,
          --   sourceMaps = true,
          --   skipFiles = { '<node_internals>/**' },
          --   resolveSourceMapLocations = { '${workspaceFolder}/**', '!**/node_modules/**' },
          -- },
          -- Debug web applications (client side)
          {
            type = 'pwa-chrome',
            request = 'launch',
            name = 'Launch & Debug Chrome',
            url = function()
              return coroutine.create(function(dap_run_co)
                vim.ui.input({
                  prompt = 'Enter URL: ',
                  default = 'http://localhost:3000',
                }, function(url)
                  if url and url ~= '' then
                    coroutine.resume(dap_run_co, url)
                  end
                end)
              end)
            end,
            webRoot = vim.fn.getcwd(),
            protocol = 'inspector',
            sourceMaps = true,
            userDataDir = false,
          },
        }
      end
    end

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = 'i',
          step_over = 'o',
          step_out = 'O',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = 'x',
        },
      },
    }

    -- Change breakpoint icons
    vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
    vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
    -- local breakpoint_icons = vim.g.have_nerd_font
    --     and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
    --   or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
    -- for type, icon in pairs(breakpoint_icons) do
    --   local tp = 'Dap' .. type
    --   local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
    --   vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
    -- end

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = function()
      vim.notify('Debug session terminated', vim.log.levels.INFO)
      dapui.close()
    end
    dap.listeners.before.event_exited['dapui_config'] = function()
      vim.notify('Debug session exited', vim.log.levels.INFO)
      dapui.close()
    end

    -- Add error handler
    dap.listeners.after.event_output['dapui_config'] = function(_, body)
      if body.category == 'stderr' then
        vim.notify('DAP Error: ' .. (body.output or ''), vim.log.levels.ERROR)
      end
    end

    -- Install golang specific config
    -- require('dap-go').setup {
    --   delve = {
    --     -- On Windows delve must be run attached or it crashes.
    --     -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
    --     detached = vim.fn.has 'win32' == 0,
    --   },
    -- }
  end,
}
