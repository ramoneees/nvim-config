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
        http = {
          litellm = function()
            return require("codecompanion.adapters.http").extend("openai_compatible", {
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
    },
    keys = {
      { "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", desc = "CodeCompanion Chat" },
      { "<leader>ca", "<cmd>CodeCompanionActions<cr>", desc = "CodeCompanion Actions" },
      { "<leader>ci", "<cmd>CodeCompanion<cr>", desc = "CodeCompanion Inline", mode = { "n", "v" } },
    },
  },
}
