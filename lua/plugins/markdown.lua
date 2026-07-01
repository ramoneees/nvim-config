-- Markdown-specific lint config.
-- markdownlint-cli2 only walks up from the file's directory looking for a config;
-- it never reads from `~`. We pass `--config` explicitly so `~/.markdownlint.jsonc`
-- applies to every markdown buffer regardless of project location.
return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters = {
        ["markdownlint-cli2"] = {
          args = { "--config", vim.fn.expand("~/.markdownlint.jsonc"), "--" },
        },
      },
    },
  },
}
