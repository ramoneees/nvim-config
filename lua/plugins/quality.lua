return {
  -- CSV/TSV viewer with aligned columns (replaces vscode-edit-csv)
  {
    "hat0uma/csvview.nvim",
    ft = { "csv", "tsv" },
    opts = {
      view = {
        display_mode = "border",
      },
    },
  },

  -- Multi-cursor editing (replaces VSCode Cmd+D / Ctrl+D)
  {
    "mg979/vim-visual-multi",
    event = "VeryLazy",
    init = function()
      vim.g.VM_maps = {
        ["Find Under"] = "<C-d>",
        ["Find Subword Under"] = "<C-d>",
      }
    end,
  },

  -- Fun: cellular automaton (spiritual successor to Power Mode)
  {
    "eandrju/cellular-automaton.nvim",
    cmd = "CellularAutomaton",
    keys = {
      { "<leader>fml", "<cmd>CellularAutomaton make_it_rain<cr>", desc = "Make It Rain" },
    },
  },
}
