-- Git diff visualization and merge conflict resolution.
--
--   diffview.nvim      side-by-side diffs, file history, 3-way merge tool
--   git-conflict.nvim  inline conflict markers with pick-a-side mappings
return {
  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory', 'DiffviewClose', 'DiffviewToggleFiles' },
    keys = {
      { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'Git [d]iff view (working tree)' },
      { '<leader>gD', '<cmd>DiffviewOpen HEAD~1<cr>', desc = 'Git [D]iff against last commit' },
      { '<leader>gh', '<cmd>DiffviewFileHistory %<cr>', desc = 'Git file [h]istory (current file)' },
      { '<leader>gH', '<cmd>DiffviewFileHistory<cr>', desc = 'Git [H]istory (whole repo)' },
      { '<leader>gm', '<cmd>DiffviewOpen<cr>', desc = 'Git [m]erge tool (3-way, during conflicts)' },
      { '<leader>gq', '<cmd>DiffviewClose<cr>', desc = 'Git diff view [q]uit' },
    },
    opts = {
      enhanced_diff_hl = true,
      view = {
        -- 3-way layout for merge conflicts: base on top, ours | theirs, result below
        merge_tool = {
          layout = 'diff3_mixed',
          disable_diagnostics = true,
        },
      },
    },
  },
  {
    'akinsho/git-conflict.nvim',
    version = '*',
    event = 'BufReadPre',
    opts = {
      default_mappings = true, -- co / ct / cb / c0 to choose, ]x / [x to jump
      default_commands = true, -- :GitConflictChooseOurs etc.
      disable_diagnostics = true,
      list_opener = 'copen',
    },
  },
}
