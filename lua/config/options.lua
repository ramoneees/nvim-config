-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

local opt = vim.opt

opt.scrolloff = 8
opt.autowriteall = true

-- Clojure/Lisp: Conjure keybindings under <localleader>
vim.g["conjure#mapping#prefix"] = "<localleader>"
