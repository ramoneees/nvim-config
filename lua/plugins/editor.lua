-- Editor power pack: terminal, sticky context, code folding.
return {
  -- Floating/scoped terminal for k9s, lazydocker, lazygit, pnpm watch, etc.
  -- Keys: <leader>tt toggle, <leader>tf float, <leader>th horizontal, <C-/> inside is terminal's own toggle
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = { "ToggleTerm", "TermExec", "ToggleTermToggleAll" },
    keys = {
      { "<leader>tt", "<cmd>ToggleTerm direction=float<cr>", desc = "Terminal (float)" },
      { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Terminal (horizontal)" },
      { "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Terminal (vertical)" },
    },
    opts = {
      open_mapping = false, -- we use <leader>t* instead of a single key
      shade_terminals = false, -- catppuccin handles this better
      persist_size = true,
      direction = "float",
      float_opts = { border = "rounded" },
    },
  },

  -- Sticky header: shows current fn/class/section at top of window.
  -- Massive for long YAML manifests, Java classes, Go files.
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    opts = {
      enable = true,
      max_lines = 3,
      trim_scope = "inner",
      mode = "cursor",
      separator = nil,
    },
  },

  -- NOTE: nvim-ufo removed 2026-06-25 — promise-async had a breaking API
  -- refactor (async is now a table, not a callable) that ufo hasn't caught
  -- up to. Native folding (zR/zM/za) still works; revisit when ufo ships a fix.

  -- oil.nvim: edit filesystem like a buffer. Replaces netrw.
  -- :e . opens current dir; - goes up; <CR> enters; y/gy copy path.
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "Oil" },
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Open parent directory (oil)" },
    },
    opts = {
      default_file_explorer = true,
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      view_options = { show_hidden = true },
      keymaps = {
        ["<C-h>"] = false, -- don't shadow LazyVim's window nav
        ["<C-l>"] = false,
      },
    },
  },
}
