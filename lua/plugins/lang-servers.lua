-- Language servers for OLYMPUS homelab + MCP server work.
return {
  -- Mason: ensure these are installed.
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "terraformls",
        "tflint",
        "helm-ls",
        "sqls",
      })
    end,
  },

  -- LSP config
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Terraform (covers .tf and .hcl partially)
        terraformls = {},
        -- Helm charts (Chart.yaml, templates/*.yaml)
        helm_ls = {
          filetypes = { "helm" },
          settings = {
            ["helm-ls"] = {
              yamlls = {
                path = "yaml-language-server",
              },
            },
          },
        },
        -- SQL: completion + goto for .sql files. Pairs with vim-dadbod for queries.
        sqls = {},
      },
    },
  },

  -- Ensure treesitter parsers cover these filetypes too.
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "hcl",
        "terraform",
      },
    },
  },

  -- Add nvim-lint config for terraform (tflint)
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        terraform = { "tflint" },
        ["terraform-vars"] = { "tflint" },
      },
    },
  },

  -- Conform formatter config for terraform (terraform_fmt)
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        terraform = { "terraform_fmt" },
        ["terraform-vars"] = { "terraform_fmt" },
        hcl = { "terraform_fmt" },
      },
    },
  },
}
