-- Deconflict <leader> keys that two different LazyVim extras/plugins both
-- claim. When two plugin specs bind the same lhs, which one wins depends on
-- lazy.nvim's internal plugin-table iteration order — this was observed to
-- flip between nvim restarts (confirmed by running the same headless check
-- repeatedly). Fix: keep the intended owner, relocate the other explicitly.
return {
  -- <leader>tt: toggleterm (custom, editor.lua) vs neotest "Run File" (test.core
  -- extra). Keep toggleterm since it's the documented terminal toggle; move
  -- neotest's run-file to <leader>tf.
  {
    "nvim-neotest/neotest",
    optional = true,
    keys = {
      { "<leader>tt", false },
      {
        "<leader>tf",
        function()
          require("neotest").run.run(vim.fn.expand("%"))
        end,
        desc = "Run File (Neotest)",
      },
    },
  },

  -- <leader>gd: diffview.nvim "Diffview Open" (custom, git.lua) vs snacks.nvim's
  -- git-diff-hunks picker. Keep diffview (documented in CHEATSHEET.md); move
  -- the snacks picker to <leader>gv.
  {
    "folke/snacks.nvim",
    optional = true,
    keys = {
      { "<leader>gd", false },
      {
        "<leader>gv",
        function()
          Snacks.picker.git_diff()
        end,
        desc = "Git Diff (hunks, Snacks picker)",
      },
    },
  },
}
