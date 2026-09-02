return {
  -- codecompanion.nvim: Multi-provider AI chat + agents
  -- Requires ANTHROPIC_API_KEY env var (or route through LiteLLM)
  -- Commands: :CodeCompanionChat, :CodeCompanionActions, :CodeCompanion <prompt>
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      strategies = {
        chat = {
          adapter = "litellm",
        },
        inline = {
          adapter = "litellm",
        },
        agent = {
          adapter = "litellm",
        },
      },
      adapters = {
        litellm = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            env = {
              url = "https://litellm.ramoneees.com",
              api_key = "LITELLM_API_KEY",
            },
            schema = {
              model = {
                default = "glm-5.1",
              },
            },
          })
        end,
      },
    },
    -- Prefix is <leader>C (not <leader>a) to avoid clashing with claudecode.nvim,
    -- which owns <leader>a* (Toggle/Focus/Resume/Accept-diff Claude). Both plugins
    -- declaring the same <leader>a* keys resolved non-deterministically depending
    -- on lazy.nvim's plugin-table iteration order across restarts.
    keys = {
      { "<leader>Cc", "<cmd>CodeCompanionChat Toggle<cr>", desc = "CodeCompanion Chat" },
      { "<leader>Ca", "<cmd>CodeCompanionActions<cr>", desc = "CodeCompanion Actions" },
      { "<leader>Ci", "<cmd>CodeCompanion<cr>", desc = "CodeCompanion Inline", mode = { "n", "v" } },
    },
  },
}
