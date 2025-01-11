-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.showmatch = true
vim.opt.matchtime = 10

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = {
  tab = '▸ ',
  trail = '+',
  nbsp = '␣',
}

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- search
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- terminal
vim.opt_global.shell = '/bin/zsh'

-- tabs
vim.opt.autoindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.cindent = true
vim.opt.smartindent = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Setup sonokai colortheme
vim.g.sonokai_style = 'andromeda'
vim.g.sonokai_better_performance = 1

vim.g.gruvbox_material_foreground = 'original'

local icons = {
  dap = {
    Stopped = { ' ', 'DiagnosticWarn', 'DapStoppedLine' },
    Breakpoint = ' ',
    BreakpointCondition = ' ',
    BreakpointRejected = { ' ', 'DiagnosticError' },
    LogPoint = '> ',
  },
  diagnostics = {
    Error = 'E',
    Warn = 'W',
    Hint = 'H',
    Info = 'I',
  },
  git = {
    added = '+',
    modified = '~',
    removed = '-',
  },
  kinds = {
    Array = ' ',
    Boolean = ' ',
    Copilot = ' ',
    Key = ' ',
    Namespace = ' {}',
    Null = ' ∅',
    Number = ' №',
    Object = ' ',
    Package = ' ',
    String = ' 󰅳',
    Text = ' 󰦨',
    Method = ' m',
    Function = ' 󰊕', -- 
    Constructor = ' ',
    Field = ' ',
    Variable = ' 󰫧',
    Class = ' ',
    Interface = ' ',
    Module = ' ',
    Property = ' ',
    Unit = ' ',
    Value = ' v',
    Enum = ' ',
    Keyword = ' ',
    Snippet = ' ',
    Color = ' ',
    File = ' ',
    Reference = ' ',
    Folder = ' ',
    EnumMember = ' ',
    Constant = ' ',
    Struct = ' ',
    Event = ' ',
    TypeParameter = ' ',
    Operator = ' ',
  },
}

-- Disables automatic commenting on newline
-- vim.api.nvim_create_autocmd({ 'FileType' }, {
--   pattern = { '*' },
--   command = 'setlocal formatoptions-=c formatoptions-=r formatoptions-=o',
-- })

-- Configuring database connection
--    vim.g.dbs = {
--      dev = "Replace with your database connection URL.",
--      staging = "Replace with your database connection URL.",
--    }

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
local map = vim.keymap.set
local options = { noremap = true, silent = true }

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- use jk to switch from i to n mode
map('i', 'jk', '<esc>', options)

-- Diagnostic keymaps
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- TIP: Disable arrow keys in normal mode
map('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
map('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
map('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
map('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
-- vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
-- Window Navigating: intergrated with tmux
map('n', '<C-h>', '<cmd> TmuxNavigateLeft<cr>', { desc = 'Go to left window' })
map('n', '<C-j>', '<cmd> TmuxNavigateDown<cr>', { desc = 'Go to lower window' })
map('n', '<C-k>', '<cmd> TmuxNavigateUp<cr>', { desc = 'Go to upper window' })
map('n', '<C-l>', '<cmd> TmuxNavigateRight<cr>', { desc = 'Go to right window' })
map('t', '<C-h>', '<cmd> TmuxNavigateLeft<cr>', { desc = 'Go to left window' })
map('t', '<C-j>', '<cmd> TmuxNavigateDown<cr>', { desc = 'Go to lower window' })
map('t', '<C-k>', '<cmd> TmuxNavigateUp<cr>', { desc = 'Go to upper window' })
map('t', '<C-l>', '<cmd> TmuxNavigateRight<cr>', { desc = 'Go to right window' })

-- jump to the begining and end of the line
map('v', 'H', '^', options)
map('n', 'H', '^', options)
map('v', 'L', '$', options)
map('n', 'L', '$', options)

-- delete the highlighted text
map('n', 'x', '"zx', options)
map('v', 'x', '"zx', options)
map('v', 'p', '"_dP', options)
-- paste without replacing the content in current register.
map('x', '<leader>p', '"_dp', options)

-- Resize window using <ctrl> arrow keys
map('n', '<Up>', '<cmd>resize +2<cr>', { desc = 'Increase window height' })
map('n', '<Down>', '<cmd>resize -2<cr>', { desc = 'Decrease window height' })
map('n', '<Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease window width' })
map('n', '<Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase window width' })

-- Move Lines
map('n', '∆', '<cmd>m .+1<cr>==', { desc = 'Move down' })
map('n', '˚', '<cmd>m .-2<cr>==', { desc = 'Move up' })
map('i', '∆', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move down' })
map('i', '˚', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move up' })
map('v', '∆', ":m '>+1<cr>gv=gv", { desc = 'Move down' })
map('v', '˚', ":m '<-2<cr>gv=gv", { desc = 'Move up' })

-- buffers
-- if Util.has 'bufferline.nvim' then
--   map('n', '{', '<cmd>BufferLineCyclePrev<cr>', { desc = 'Prev buffer' })
--   map('n', '}', '<cmd>BufferLineCycleNext<cr>', { desc = 'Next buffer' })
-- else
map('n', '{', '<cmd>bprevious<cr>', { desc = 'Prev buffer' })
map('n', '}', '<cmd>bnext<cr>', { desc = 'Next buffer' })
--end
map('n', '<leader>nb', '<cmd>e #<cr>', { desc = 'Switch to Other Buffer' })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map('n', '=', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
map('x', '=', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
map('o', '=', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
map('n', '-', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })
map('x', '-', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })
map('o', '-', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })

-- save file
map({ 'i', 'v', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save file' })

-- better indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Terminal Mappings
map('n', '<leader>t', ':ToggleTerm<cr>', { desc = 'Toggle terminal' })
map('t', '<esc>', '<c-\\><c-n>', { desc = 'Enter Normal Mode' })

-- Tabs
map('n', 'ti', '<cmd>tabnew<cr>', { desc = 'New Tab' })
map('n', '+', '<cmd>tabnext<cr>', { desc = 'Next Tab' })
map('n', '_', '<cmd>tabprevious<cr>', { desc = 'Previous Tab' })

-- Diagnostics
map('n', '<leader>d', vim.diagnostic.open_float, options)
map('n', '[d', vim.diagnostic.goto_prev, options)
map('n', ']d', vim.diagnostic.goto_next, options)

-- telescope
-- local builtin = require 'telescope.builtin'
-- end, { desc = 'Search in open files' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to force a plugin to be loaded.
  --

  -- Here is a more advanced example where we pass configuration
  -- options to `gitsigns.nvim`. This is equivalent to the following Lua:
  --    require('gitsigns').setup({ ... })
  --
  -- See `:help gitsigns` to understand what the configuration keys do
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },
  {
    'vhyrro/luarocks.nvim',
    priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
    config = true,
  },

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `opts` key (recommended), the configuration runs
  -- after the plugin has been loaded as `require(MODULE).setup(opts)`.

  {                     -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      -- Document existing key chains
      spec = {
        { '<leader>c', group = '[C]ode',     mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      },
    },
  },

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons',            enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        -- pickers = {}
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('v', '<leader>fs', function()
        local text = vim.getVisualSelection()
        builtin.live_grep({ default_text = text })
      end, { desc = '[S]earch [S]elected' })
      vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>f/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>fn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },

  -- LSP Plugins
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
  { 'Bilal2453/luvit-meta',                        lazy = true },
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim',       opts = {} },

      -- Allows extra capabilities provided by nvim-cmp
      'hrsh7th/cmp-nvim-lsp',
      'saghen/blink.cmp',
    },
    config = function(_, opts)
      -- Brief aside: **What is LSP?**
      --
      -- LSP is an initialism you've probably heard, but might not understand what it is.
      --
      -- LSP stands for Language Server Protocol. It's a protocol that helps editors
      -- and language tooling communicate in a standardized fashion.
      --
      -- In general, you have a "server" which is some tool built to understand a particular
      -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
      -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
      -- processes that communicate with some "client" - in this case, Neovim!
      --
      -- LSP provides Neovim with features like:
      --  - Go to definition
      --  - Find references
      --  - Autocompletion
      --  - Symbol Search
      --  - and more!
      --
      -- Thus, Language Servers are external tools that must be installed separately from
      -- Neovim. This is where `mason` and related plugins come into play.
      --
      -- If you're wondering about lsp vs :treesitter, you can check out the wonderfully
      -- and elegantly composed help section, `:help lsp-vs-treesitter`

      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- Find references for the word under your cursor.
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('<leader>gt', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- if lsp supports formatting, create auto command to format on file save
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_formatting) then
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = event.buf,
              callback = function()
                vim.lsp.buf.format { bufnr = event.buf, id = client.id }
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>uh', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, 'Toggle Inlay [H]ints')
          end
        end,
      })

      -- Change diagnostic symbols in the sign column (gutter)
      if vim.g.have_nerd_font then
        local signs = { ERROR = '', WARN = '', INFO = '', HINT = '' }
        local diagnostic_signs = {}
        for type, icon in pairs(signs) do
          diagnostic_signs[vim.diagnostic.severity[type]] = icon
        end
        vim.diagnostic.config { signs = { text = diagnostic_signs } }
      end

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        -- clangd = {},
        -- gopls = {},
        -- pyright = {},
        rust_analyzer = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`ts_ls`) will work just fine
        -- ts_ls = {
        --   capabilities = {
        --     lsp_format = false,
        --     format_on_save = false,
        --   },
        -- },
        --

        lua_ls = {
          -- cmd = { ... },
          -- filetypes = { ... },
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
        eslint = {
          on_attach = function(_, bufnr)
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = bufnr,
              command = 'EslintFixAll',
            })
          end,
        },
      }

      local lspconfig = require 'lspconfig'
      for server, config in pairs(servers) do
        -- passing config.capabilities to blink.cmp merges with the capabilities in your
        -- `opts[server].capabilities, if you've defined it
        config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end

      -- Ensure the servers and tools above are installed
      --  To check the current status of installed tools and/or manually install
      --  other tools, you can run
      --    :Mason
      --
      --  You can press `g?` for help in this menu.
      require('mason').setup()

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
        ensure_installed = { 'eslint', 'lua_ls', 'rust_analyzer' },
        automatic_installation = false,
      }
    end,
  },
  -- {
  --   'stevearc/conform.nvim',
  --   dependencies = { 'mason.nvim', 'MunifTanjim/prettier.nvim' },
  --   event = { 'BufWritePre' },
  --   lazy = true,
  --   cmd = 'ConformInfo',
  --   keys = {
  --     {
  --       '<leader>F',
  --       function()
  --         require('conform').format { timeout_ms = 3000 }
  --       end,
  --       mode = { 'n', 'v' },
  --       desc = 'Format Injected Langs',
  --     },
  --   },
  --   opts = function()
  --     local opts = {
  --       default_format_opts = {
  --         timeout_ms = 3000,
  --         async = false, -- not recommended to change
  --         quiet = false, -- not recommended to change
  --         lsp_format = 'fallback', -- not recommended to change
  --       },
  --       format_on_save = function(bufnr)
  --         -- Disable "format_on_save lsp_fallback" for languages that don't
  --         -- have a well standardized coding style. You can add additional
  --         -- languages here or re-enable it for the disabled ones.
  --         local disable_filetypes = { c = true, cpp = true, javascript = true, typescript = true, javascriptreact = true, typescriptreact = true }
  --         local lsp_format_opt
  --         if disable_filetypes[vim.bo[bufnr].filetype] then
  --           lsp_format_opt = 'never'
  --         else
  --           lsp_format_opt = 'fallback'
  --         end
  --         return {
  --           timeout_ms = 500,
  --           lsp_format = lsp_format_opt,
  --         }
  --       end,
  --       formatters_by_ft = {
  --         lua = { 'stylua' },
  --         fish = { 'fish_indent' },
  --         sh = { 'shfmt' },
  --       },
  --       -- The options you set here will be merged with the builtin formatters.
  --       -- You can also define any custom formatters here.
  --       --@type table<string, conform.FormatterConfigOverride|fun(bufnr: integer): nil|conform.FormatterConfigOverride>
  --       formatters = {
  --         injected = { options = { ignore_errors = true } },
  --         prettierd = {
  --           prepend_args = { '--bracket-same-line', '--single-quote', '--trailing-comma none' },
  --         },
  --         -- # Example of using dprint only when a dprint.json file is present
  --         -- dprint = {
  --         --   condition = function(ctx)
  --         --     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
  --         --   end,
  --         -- },
  --         --
  --         -- # Example of using shfmt with extra args
  --         -- shfmt = {
  --         --   prepend_args = { "-i", "2", "-ci" },
  --         -- },
  --       },
  --     }
  --     return opts
  --   end,
  -- },
  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = { 'rafamadriz/friendly-snippets', { 'L3MON4D3/LuaSnip', version = 'v2.*' } },

    -- use a release tag to download pre-built binaries
    version = 'v0.*',
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' for mappings similar to built-in completion
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      -- see the "default configuration" section below for full documentation on how to define
      -- your own keymap.
      enabled = function()
        return not vim.bo.buftype ~= "prompt"
            and vim.b.completion ~= false
      end,
      keymap = {
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'hide', 'fallback' },
        ['<CR>'] = { 'accept', 'fallback' },

        ['<Tab>'] = { 'snippet_forward', 'fallback' },
        ['<S-Tab>'] = { 'snippet_backward', 'fallback' },

        ['<Up>'] = { 'select_prev', 'fallback' },
        ['<Down>'] = { 'select_next', 'fallback' },
        ['<C-p>'] = { 'select_prev', 'fallback' },
        ['<C-n>'] = { 'select_next', 'fallback' },

        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
      },
      completion = {
        list = {
          max_items = 20,
          selection = {
            preselect = function(ctx)
              return ctx.mode ~= 'cmdline' and not require('blink.cmp').snippet_active({ direction = 1 })
            end,
            auto_insert = true,
          },
        },
        menu = {
          draw = {
            columns = { { 'label', gap = 2, 'kind' }, { 'label_description' } },
          },
          auto_show = function(ctx)
            if vim.bo.buftype ~= nil and vim.bo.buftype ~= '' then return false end
            return ctx.mode ~= 'cmdline' or
                not vim.tbl_contains({ '/', '?', ':' }, vim.fn.getcmdtype())
          end,
        },
      },

      appearance = {
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        -- Useful for when your theme doesn't support blink.cmp
        -- will be removed in a future release
        use_nvim_cmp_as_default = true,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
      },
      snippets = {
        expand = function(snippet)
          require('luasnip').lsp_expand(snippet)
        end,
        active = function(filter)
          if filter and filter.direction then
            return require('luasnip').jumpable(filter.direction)
          end
          return require('luasnip').in_snippet()
        end,
        jump = function(direction)
          require('luasnip').jump(direction)
        end,
      },

      -- default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        -- optionally disable cmdline completions
        -- cmdline = {},
      },

      -- experimental signature help support
      -- signature = { enabled = true }
    },
    -- allows extending the providers array elsewhere in your config
    -- without having to redefine it
    opts_extend = { 'sources.default' },
  },
  -- { -- Autocompletion
  --   'hrsh7th/nvim-cmp',
  --   version = '*',
  --   event = 'InsertEnter',
  --   dependencies = {
  --     -- Snippet Engine & its associated nvim-cmp source
  --     {
  --       'L3MON4D3/LuaSnip',
  --       build = (function()
  --         -- Build Step is needed for regex support in snippets.
  --         -- This step is not supported in many windows environments.
  --         -- Remove the below condition to re-enable on windows.
  --         if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
  --           return
  --         end
  --         return 'make install_jsregexp'
  --       end)(),
  --       dependencies = {
  --         -- `friendly-snippets` contains a variety of premade snippets.
  --         --    See the README about individual language/framework/plugin snippets:
  --         --    https://github.com/rafamadriz/friendly-snippets
  --         {
  --           'rafamadriz/friendly-snippets',
  --           config = function()
  --             require('luasnip.loaders.from_vscode').lazy_load()
  --           end,
  --         },
  --       },
  --     },
  --     'saadparwaiz1/cmp_luasnip',
  --
  --     -- Adds other completion capabilities.
  --     --  nvim-cmp does not ship with all sources by default. They are split
  --     --  into multiple repos for maintenance purposes.
  --     'hrsh7th/cmp-nvim-lsp',
  --     'hrsh7th/cmp-path',
  --     {
  --       'Saecki/crates.nvim',
  --       event = { 'BufRead Cargo.toml' },
  --       config = true,
  --     },
  --     { 'roobert/tailwindcss-colorizer-cmp.nvim', config = true },
  --     'hrsh7th/cmp-emoji',
  --   },
  --   config = function()
  --     -- See `:help cmp`
  --     local cmp = require 'cmp'
  --     local defaults = require 'cmp.config.default'()
  --     local luasnip = require 'luasnip'
  --     luasnip.config.setup {}
  --
  --     cmp.setup {
  --       snippet = {
  --         expand = function(args)
  --           luasnip.lsp_expand(args.body)
  --         end,
  --       },
  --       completion = { completeopt = 'menu,menuone,noinsert' },
  --
  --       -- For an understanding of why these mappings were
  --       -- chosen, you will need to read `:help ins-completion`
  --       --
  --       -- No, but seriously. Please read `:help ins-completion`, it is really good!
  --       mapping = cmp.mapping.preset.insert {
  --         -- Select the [n]ext item
  --         ['<C-n>'] = cmp.mapping.select_next_item(),
  --         -- Select the [p]revious item
  --         ['<C-p>'] = cmp.mapping.select_prev_item(),
  --
  --         -- Scroll the documentation window [b]ack / [f]orward
  --         ['<C-b>'] = cmp.mapping.scroll_docs(-4),
  --         ['<C-f>'] = cmp.mapping.scroll_docs(4),
  --
  --         -- Accept ([y]es) the completion.
  --         --  This will auto-import if your LSP supports it.
  --         --  This will expand snippets if the LSP sent a snippet.
  --         -- ['<C-y>'] = cmp.mapping.confirm { select = true },
  --
  --         -- If you prefer more traditional completion keymaps,
  --         -- you can uncomment the following lines
  --         ['<CR>'] = cmp.mapping.confirm { select = true },
  --         ['<Tab>'] = cmp.mapping.select_next_item(),
  --         ['<S-Tab>'] = cmp.mapping.select_prev_item(),
  --
  --         -- Manually trigger a completion from nvim-cmp.
  --         --  Generally you don't need this, because nvim-cmp will display
  --         --  completions whenever it has completion options available.
  --         ['<C-Space>'] = cmp.mapping.complete {},
  --
  --         -- Think of <c-l> as moving to the right of your snippet expansion.
  --         --  So if you have a snippet that's like:
  --         --  function $name($args)
  --         --    $body
  --         --  end
  --         --
  --         -- <c-l> will move you to the right of each of the expansion locations.
  --         -- <c-h> is similar, except moving you backwards.
  --         ['<C-l>'] = cmp.mapping(function()
  --           if luasnip.expand_or_locally_jumpable() then
  --             luasnip.expand_or_jump()
  --           end
  --         end, { 'i', 's' }),
  --         ['<C-h>'] = cmp.mapping(function()
  --           if luasnip.locally_jumpable(-1) then
  --             luasnip.jump(-1)
  --           end
  --         end, { 'i', 's' }),
  --
  --         -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
  --         --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
  --       },
  --       sources = cmp.config.sources {
  --         { name = 'nvim_lua' },
  --         { name = 'nvim_lsp' },
  --         { name = 'luasnip' },
  --         { name = 'buffer', max_item_count = 4, keyword_length = 5 },
  --         { name = 'path', max_item_count = 4 },
  --       },
  --       formatting = {
  --         expandable_indicator = true,
  --         format = function(entry, vim_item)
  --           -- Kind icons
  --           vim_item.kind = string.format('%s %s', icons.kinds[vim_item.kind], vim_item.kind) -- This concatenates the icons with the name of the item kind
  --           -- Source
  --           vim_item.menu = ({
  --             buffer = '[Buffer]',
  --             nvim_lsp = '[LSP]',
  --             luasnip = '[LuaSnip]',
  --             nvim_lua = '[Lua]',
  --             latex_symbols = '[LaTeX]',
  --           })[entry.source.name]
  --           return vim_item
  --         end,
  --         fields = { cmp.ItemField.Abbr, cmp.ItemField.Kind, cmp.ItemField.Menu },
  --       },
  --       experimental = {
  --         native_menu = false,
  --         ghost_text = {
  --           hl_group = 'CmpGhostText',
  --         },
  --       },
  --       sorting = defaults.sorting,
  --     }
  --   end,
  -- },
  {
    'L3MON4D3/LuaSnip',
    keys = function()
      return {}
    end,
    opts = {
      history = true,
      delete_check_events = 'TextChanged',
    },
  },
  {
    'rafamadriz/friendly-snippets',
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load()
    end,
  },
  { 'JoosepAlviste/nvim-ts-context-commentstring', lazy = true },
  { -- Debug
    'mfussenegger/nvim-dap',
    lazy = true,
    optional = true,
    dependencies = {
      {
        'williamboman/mason.nvim',
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          table.insert(opts.ensure_installed, 'js-debug-adapter')
        end,
      },
    },
    opts = function()
      local dap = require 'dap'
      if not dap.adapters['pwa-node'] then
        require('dap').adapters['pwa-node'] = {
          type = 'server',
          host = 'localhost',
          port = '${port}',
          executable = {
            command = 'node',
            -- 💀 Make sure to update this path to point to your installation
            args = {
              require('mason-registry').get_package('js-debug-adapter'):get_install_path() ..
              '/js-debug/src/dapDebugServer.js',
              '${port}',
            },
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
            {
              type = 'pwa-node',
              request = 'attach',
              name = 'Attach',
              processId = require('dap.utils').pick_process,
              cwd = '${workspaceFolder}',
            },
          }
        end
      end
    end,
  },
  { -- Color Scheme
    -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    lazy = true,
  },
  { 'ellisonleao/gruvbox.nvim', lazy = true },
  {
    'sainnhe/gruvbox-material',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme 'gruvbox-material'

      -- You can configure highlights by doing something like:
      vim.cmd.hi 'Comment gui=none'
    end,
  },
  { 'mhartington/oceanic-next', lazy = true },
  { 'sainnhe/sonokai' },
  { 'EdenEast/nightfox.nvim',   lazy = true },
  {
    'xero/miasma.nvim',
    lazy = true,
  },
  {
    'catppuccin/nvim',
    priority = 1000,
    name = 'catppuccin',
    opts = {
      integrations = {

        cmp = true,
        gitsigns = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        lsp_trouble = true,
        mason = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { 'undercurl' },
            hints = { 'undercurl' },
            warnings = { 'undercurl' },
            information = { 'undercurl' },
          },
        },
        navic = { enabled = true, custom_bg = 'lualine' },
        neotest = true,
        noice = true,
        notify = true,
        neotree = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        which_key = true,
      },
    },
  },

  {
    'nvim-lualine/lualine.nvim',
    opts = function()
      return {
        options = {
          theme = 'auto',
          globalstatus = true,
          disabled_filetypes = { statusline = { 'dashboard', 'alpha' } },
          section_separators = { left = '', right = '' },
          component_separators = { left = '', right = '' },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch' },
          lualine_c = {
            {
              'diagnostics',
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },
            { 'filetype', icon_only = true, separator = '', padding = { left = 1, right = 0 } },
            { 'filename', path = 1, symbols = { modified = '  ', readonly = '', unnamed = '' } },
            -- stylua: ignore
            {
              function() return require("nvim-navic").get_location() end,
              cond = function() return package.loaded["nvim-navic"] and require("nvim-navic").is_available() end,
            },
          },
          lualine_x = {
            -- stylua: ignore
            {
              function() return require("noice").api.status.command.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
            },
            -- stylua: ignore
            {
              function()
                return require("noice").api.status.mode.get()
              end,
              cond = function()
                return package.loaded["noice"] and require("noice").api.status.mode.has()
              end,
            },
            -- stylua: ignore
            {
              function() return "  " .. require("dap").status() end,
              cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
            },
            { require('lazy.status').updates, cond = require('lazy.status').has_updates },
            {
              'diff',
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              },
            },
          },
          lualine_y = {
            { 'progress', separator = ' ', padding = { left = 1, right = 1 } },
          },
          lualine_z = {
            'location',
          },
        },
        extensions = { 'neo-tree', 'lazy' },
      }
    end,
  },
  {
    'echasnovski/mini.starter',
    event = 'VimEnter',
    opts = function()
      -- local logo = table.concat({
      --   '              ██╗   ██╗██╗███╗   ███╗          ',
      --   '              ██║   ██║██║████╗ ████║          ',
      --   '              ██║   ██║██║██╔████╔██║          ',
      --   '              ╚██╗ ██╔╝██║██║╚██╔╝██║          ',
      --   '               ╚████╔╝ ██║██║ ╚═╝ ██║          ',
      --   '         neo.   ╚═══╝  ╚═╝╚═╝     ╚═╝          ',
      --   '                                              ',
      -- }, '\n')
      local logo = table.concat({
        '                                               ',
        '               hello world                      ',
        '                                              ',
      }, '\n')

      local pad = string.rep(' ', 18)
      local new_section = function(name, action, section)
        return { name = name, action = action, section = pad .. section }
      end

      local starter = require 'mini.starter'
      --stylua: ignore
      local config = {
        evaluate_single = true,
        header = logo,
        items = {
          new_section("File", "Telescope find_files", ""),
          new_section("Grep", "Telescope live_grep", ""),
        },
        content_hooks = {
          starter.gen_hook.adding_bullet(pad .. "░ ", false),
          starter.gen_hook.aligning("center", "center"),
        },
        footer = '',
      }
      return config
    end,

    config = function(_, config)
      -- close Lazy and re-open when starter is ready
      if vim.o.filetype == 'lazy' then
        vim.cmd.close()
        vim.api.nvim_create_autocmd('User', {
          pattern = 'MiniStarterOpened',
          callback = function()
            require('lazy').show()
          end,
        })
      end

      local starter = require 'mini.starter'
      starter.setup(config)

      vim.api.nvim_create_autocmd('User', {
        pattern = 'VimEnter',
        callback = function(ev)
          local stats = require('lazy').stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          local pad_footer = string.rep(' ', 8)
          starter.config.footer = pad_footer .. '⚡' .. stats.count .. ' plugins loaded in ' .. ms .. 'ms'
          if vim.bo[ev.buf].filetype == 'ministarter' then
            pcall(starter.refresh)
          end
        end,
      })
    end,
  },

  {
    'echasnovski/mini.surround',
    opts = {
      mappings = {
        add = 'gsa',
        delete = 'gsd',
        find = 'gsf',
        find_left = 'gsF',
        highlight = 'gsh',
        replace = 'gsr',
        update_n_lines = 'gsn',
      },
    },
  },
  {
    'echasnovski/mini.ai',
    keys = {
      { 'a', mode = { 'x', 'o' } },
      { 'i', mode = { 'x', 'o' } },
    },
    dependencies = { 'nvim-treesitter-textobjects', config = true },
    opts = function()
      local ai = require 'mini.ai'
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { '@block.outer', '@conditional.outer', '@loop.outer' },
            i = { '@block.inner', '@conditional.inner', '@loop.inner' },
          }, {}),
          f = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }, {}),
          c = ai.gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }, {}),
        },
      }
    end,
    config = function(_, opts)
      require('mini.ai').setup(opts)
      -- register all text objects with which-key
      if require('lazyvim.util').has 'which-key.nvim' then
        ---@type table<string, string|table>
        local i = {
          [' '] = 'Whitespace',
          ['"'] = 'Balanced "',
          ["'"] = "Balanced '",
          ['`'] = 'Balanced `',
          ['('] = 'Balanced (',
          [')'] = 'Balanced ) including white-space',
          ['>'] = 'Balanced > including white-space',
          ['<lt>'] = 'Balanced <',
          [']'] = 'Balanced ] including white-space',
          ['['] = 'Balanced [',
          ['}'] = 'Balanced } including white-space',
          ['{'] = 'Balanced {',
          ['?'] = 'User Prompt',
          _ = 'Underscore',
          a = 'Argument',
          b = 'Balanced ), ], }',
          c = 'Class',
          f = 'Function',
          o = 'Block, conditional, loop',
          q = 'Quote `, ", \'',
          t = 'Tag',
        }
        local a = vim.deepcopy(i)
        for k, v in pairs(a) do
          a[k] = v:gsub(' including.*', '')
        end

        local ic = vim.deepcopy(i)
        local ac = vim.deepcopy(a)
        for key, name in pairs { n = 'Next', l = 'Last' } do
          i[key] = vim.tbl_extend('force', { name = 'Inside ' .. name .. ' textobject' }, ic)
          a[key] = vim.tbl_extend('force', { name = 'Around ' .. name .. ' textobject' }, ac)
        end
        require('which-key').add {
          mode = { 'o', 'x' },
          i = i,
          a = a,
        }
      end
    end,
  },
  -- {
  --   'echasnovski/mini.animate',
  --   event = 'VeryLazy',
  --   opts = function()
  --     -- don't use animate when scrolling with the mouse
  --     local mouse_scrolled = false
  --     for _, scroll in ipairs { 'Up', 'Down' } do
  --       local key = '<ScrollWheel' .. scroll .. '>'
  --       vim.keymap.set({ '', 'i' }, key, function()
  --         mouse_scrolled = true
  --         return key
  --       end, { expr = true })
  --     end
  --
  --     local animate = require 'mini.animate'
  --     return {
  --       cursor = {
  --         timing = animate.gen_timing.cubic { duration = 60, unit = 'total' },
  --         path = animate.gen_path.line(),
  --       },
  --       resize = {
  --         timing = animate.gen_timing.linear { duration = 80, unit = 'total' },
  --       },
  --       scroll = {
  --         timing = animate.gen_timing.cubic { ease = 'in-out', duration = 60, unit = 'total' },
  --         subscroll = animate.gen_subscroll.equal {
  --           predicate = function(total_scroll)
  --             if mouse_scrolled then
  --               mouse_scrolled = false
  --               return false
  --             end
  --             return total_scroll > 1
  --           end,
  --         },
  --       },
  --     }
  --   end,
  -- },
  {
    'echasnovski/mini.hipatterns',
    event = 'BufReadPre',
    opts = function()
      local hi = require 'mini.hipatterns'
      return {
        -- custom LazyVim option to enable the tailwind integration
        tailwind = {
          enabled = true,
          ft = { 'typescriptreact', 'javascriptreact', 'css', 'javascript', 'typescript', 'html' },
          -- full: the whole css class will be highlighted
          -- compact: only the color will be highlighted
          style = 'full',
        },
        highlighters = {
          hex_color = hi.gen_highlighter.hex_color { priority = 2000 },
        },
      }
    end,
  },
  -- {
  --   'folke/noice.nvim',
  --   event = 'VeryLazy',
  --   -- REMOVE THIS once this issue is fixed: https://github.com/yioneko/vtsls/issues/159
  --   opts = {
  --     notify = {
  --       enabled = false,
  --     },
  --     routes = {
  --       {
  --         filter = {
  --           event = 'notify',
  --           find = 'Request textDocument',
  --         },
  --         opts = { skip = true },
  --       },
  --     },
  --   },
  -- },
  -- {
  --   'folke/snacks.nvim',
  --   opts = {
  --     notifier = {
  --       enabled = false,
  --       -- your notifier configuration comes here
  --       -- or leave it empty to use the default settings
  --       -- refer to the configuration section below
  --     },
  --     words = {
  --       enabled = true, -- enable/disable the plugin
  --       debounce = 200, -- time in ms to wait before updating
  --       notify_jump = false, -- show a notification when jumping
  --       notify_end = true, -- show a notification when reaching the end
  --       foldopen = true, -- open folds after jumping
  --       jumplist = true, -- set jump point before jumping
  --       modes = { 'n', 'i', 'c' }, -- modes to show references
  --     },
  --   },
  -- },
  {
    'stevearc/oil.nvim',
    lazy = false,
    opts = {
      columns = {
        'icon',
        'size',
        --"permissions",
        --"mtime",
      },
    },
    keys = {
      { '<leader>d', 'actions.open_cwd', desc = 'Open current directroy' },
    },

    -- Optional dependencies
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },

  { 'christoomey/vim-tmux-navigator', lazy = false },

  {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {
      shell = '/bin/zsh',
    },
  },
  {
    'folke/trouble.nvim',
    cmd = { 'Trouble' },
    opts = {
      modes = {
        lsp = {
          win = { position = 'right' },
        },
      },
    },
    keys = {
      { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>',              desc = 'Diagnostics (Trouble)' },
      { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer Diagnostics (Trouble)' },
      { '<leader>cs', '<cmd>Trouble symbols toggle<cr>',                  desc = 'Symbols (Trouble)' },
      { '<leader>cS', '<cmd>Trouble lsp toggle<cr>',                      desc = 'LSP references/definitions/... (Trouble)' },
      { '<leader>xL', '<cmd>Trouble loclist toggle<cr>',                  desc = 'Location List (Trouble)' },
      { '<leader>xQ', '<cmd>Trouble qflist toggle<cr>',                   desc = 'Quickfix List (Trouble)' },
      {
        '[q',
        function()
          if require('trouble').is_open() then
            require('trouble').prev { skip_groups = true, jump = true }
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = 'Previous Trouble/Quickfix Item',
      },
      {
        ']q',
        function()
          if require('trouble').is_open() then
            require('trouble').next { skip_groups = true, jump = true }
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = 'Next Trouble/Quickfix Item',
      },
    },
  },
  {
    'HiPhish/rainbow-delimiters.nvim',
    enable = false,
  },
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    --@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  },

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim',       event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      -- require('mini.surround').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    event = 'VeryLazy',
    enabled = true,
    config = function()
      -- When in diff mode, we want to use the default
      -- vim text objects c & C instead of the treesitter ones.
      local move = require 'nvim-treesitter.textobjects.move' ---@type table<string,fun(...)>
      local configs = require 'nvim-treesitter.configs'
      for name, fn in pairs(move) do
        if name:find 'goto' == 1 then
          move[name] = function(q, ...)
            if vim.wo.diff then
              local config = configs.get_module('textobjects.move')[name] ---@type table<string,string>
              for key, query in pairs(config or {}) do
                if q == query and key:find '[%]%[][cC]' then
                  vim.cmd('normal! ' .. key)
                  return
                end
              end
            end
            return fn(q, ...)
          end
        end
      end
    end,
  },
  {
    'akinsho/bufferline.nvim',
    opts = {
      options = {
        mode = 'tabs',
        always_show_bufferline = true,
        show_buffer_close_icons = false,
        show_close_icon = false,
        color_icons = true,
        left_trunc_marker = ' ',
        right_trunc_marker = '',
        max_name_length = 14,
        max_prefix_length = 13,
        tab_size = 15,
        show_buffer_icons = true,
        show_tab_indicators = true,
        separator_style = 'thick',
        --diagnostics = "coc",
        diagnostics = 'nvim_lsp',
        offsets = {
          {
            filetype = 'neo-tree',
            text = 'Neo-tree',
            highlight = 'Directory',
            text_align = 'left',
          },
        },
      },
    },
  },

  -- The following comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  require 'kickstart.plugins.debug',
  require 'kickstart.plugins.indent_line',
  require 'kickstart.plugins.lint',
  require 'kickstart.plugins.autopairs',
  require 'kickstart.plugins.neo-tree',
  require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  -- { import = 'custom.plugins' },
  --
  -- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
  -- Or use telescope!
  -- In normal mode type `<space>sh` then write `lazy.nvim-plugin`
  -- you can continue same window with `<space>sr` which resumes last telescope search
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = {},
    --       vim.g.have_nerd_font and {} or {
    --     cmd = '⌘',
    --     config = '🛠',
    --     event = '📅',
    --     ft = '📂',
    --     init = '⚙',
    --     keys = '🗝',
    --     plugin = '🔌',
    --     runtime = '💻',
    --     require = '🌙',
    --     source = '📄',
    --     start = '🚀',
    --     task = '📌',
    --     lazy = '💤 ',
    --   },
    -- },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
