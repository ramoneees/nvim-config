return {
  -- Automatic paren/indent balancing as you type. nvim-paredit (from the
  -- clojure extra) only gives explicit slurp/barf/wrap/raise commands; this
  -- adds the "just works while typing" half of structural editing.
  {
    "gpanders/nvim-parinfer",
    ft = { "clojure", "edn", "fennel", "scheme", "lisp", "racket" },
  },

  -- nvim-paredit ships a wrap API (api/wrap.lua) but binds no default keys
  -- for it. Add the wrap-in-delimiter keymaps MIGRATION.md described.
  {
    "julienvincent/nvim-paredit",
    optional = true,
    opts = function(_, opts)
      opts.keys = vim.tbl_deep_extend("force", opts.keys or {}, {
        ["<localleader>("] = {
          function()
            require("nvim-paredit.api.wrap").wrap_element_under_cursor("(", ")")
          end,
          "Wrap in ()",
          repeatable = false,
        },
        ["<localleader>["] = {
          function()
            require("nvim-paredit.api.wrap").wrap_element_under_cursor("[", "]")
          end,
          "Wrap in []",
          repeatable = false,
        },
        ["<localleader>{"] = {
          function()
            require("nvim-paredit.api.wrap").wrap_element_under_cursor("{", "}")
          end,
          "Wrap in {}",
          repeatable = false,
        },
        ['<localleader>"'] = {
          function()
            require("nvim-paredit.api.wrap").wrap_element_under_cursor('"', '"')
          end,
          'Wrap in ""',
          repeatable = false,
        },
      })
      return opts
    end,
  },
}
