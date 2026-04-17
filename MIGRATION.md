# VSCode to Neovim Migration Guide

Migration reference from VSCode (49 extensions) to this LazyVim configuration.

---

## VSCode Extension Replacements

### Languages (LazyVim extras in `lua/config/lazy.lua`)

| VSCode Extension | Neovim Replacement |
|---|---|
| `golang.go` | `extras.lang.go` (gopls, gofumpt, delve) |
| `ms-python.python` + `vscode-pylance` | `extras.lang.python` (pyright, ruff, debugpy) |
| `betterthantomorrow.calva` | `extras.lang.clojure` (clojure-lsp, Conjure REPL, paredit) |
| `redhat.java` + `vscjava.*` | `extras.lang.java` (jdtls, java-debug-adapter) |
| `dart-code.dart-code` + `flutter` | `extras.lang.dart` (dart LSP, flutter tools) |
| `redhat.vscode-yaml` | Built-in (yaml-language-server via Mason) |
| `docker` | `extras.lang.docker` (dockerfile-ls, compose-ls) |

### Git

| VSCode Extension | Neovim Replacement |
|---|---|
| `eamodio.gitlens` (inline blame) | `gitsigns.nvim` with `current_line_blame = true` (`lua/plugins/custom.lua`) |
| `eamodio.gitlens` (file history) | `diffview.nvim` — `<leader>gh` (`lua/plugins/git.lua`) |
| `eamodio.gitlens` (compare) | `diffview.nvim` — `<leader>gd` |
| Source Control panel | `lazygit` — `<leader>gg` (built into LazyVim) |

### AI

| VSCode Extension | Neovim Replacement |
|---|---|
| `github.copilot` | `claudecode.nvim` (LazyVim extra, connects to Claude Code CLI) |
| `openai.chatgpt` | `codecompanion.nvim` — `<leader>ac` (`lua/plugins/ai.lua`) |
| `mattflower.aider` | CodeCompanion agent mode — `<leader>aa` |

### DevOps

| VSCode Extension | Neovim Replacement |
|---|---|
| `cweijan.vscode-database-client2` | `vim-dadbod` + `vim-dadbod-ui` — `<leader>D` (`lua/plugins/devops.lua`) |
| `ms-kubernetes-tools` | `kubectl` CLI in terminal (`<C-/>`) |
| `ms-vscode-remote.remote-ssh` | Native `nvim` over SSH: `ssh host nvim file` |
| `ms-vscode-remote.remote-containers` | `devcontainer` CLI + SSH into container |
| `github.vscode-github-actions` | `gh run list` / `gh run watch` in terminal |

### Editor Features

| VSCode Feature | Neovim Replacement |
|---|---|
| Auto-save on focus change | `autowriteall` + `FocusLost` autocmd (`lua/config/autocmds.lua`) |
| Multi-cursor (`Cmd+D`) | `vim-visual-multi` — `<C-d>` (`lua/plugins/quality.lua`) |
| File explorer sidebar | `neo-tree` — `<leader>e` (built into LazyVim) |
| Integrated terminal | `<C-/>` or `<leader>ft` (built into LazyVim) |
| Command palette | `<leader>:` (command history) or `:` |
| Fuzzy file finder | `<leader>ff` or `<leader><leader>` |
| Search in files | `<leader>sg` (live grep) |
| CSV/TSV editing | `csvview.nvim` (`lua/plugins/quality.lua`) |
| Icon theme | `nvim-web-devicons` (built into LazyVim) |

### Not Migrated (use external tools)

| VSCode Extension | Alternative |
|---|---|
| `tomoki1207.pdf` (PDF viewer) | `open file.pdf` or `zathura` |
| `jock.svg` (SVG preview) | `open file.svg` (browser) |
| `hoovercj.vscode-power-mode` | `:CellularAutomaton make_it_rain` or `<leader>fml` |

---

## Keybinding Cheat Sheet

### VSCode to Neovim

| VSCode | Neovim (LazyVim) |
|---|---|
| `Cmd+P` | `<leader>ff` (find files) |
| `Cmd+Shift+P` | `<leader>:` (commands) |
| `Cmd+Shift+F` | `<leader>sg` (live grep) |
| `Cmd+B` | `<leader>e` (file explorer) |
| `Cmd+\` | `<leader>\|` (vsplit) / `<leader>-` (hsplit) |
| `Cmd+W` | `<leader>bd` (close buffer) |
| `Cmd+,` | Edit `lua/config/options.lua` |
| `` Ctrl+` `` | `<C-/>` (terminal) |
| `F12` | `gd` (go to definition) |
| `Shift+F12` | `gr` (references) |
| `F2` | `<leader>cr` (rename) |
| `Ctrl+.` | `<leader>ca` (code actions) |
| `Cmd+Shift+E` | `<leader>e` (explorer) |
| `Cmd+Shift+G` | `<leader>gg` (lazygit) |
| `Cmd+Shift+X` | `:Lazy` (plugin manager) |
| `Cmd+K Cmd+S` | `:map` or press `<leader>` and wait (which-key) |

### Tips for VSCode Users

1. **Leader key is Space** — press it and wait to see all available groups
2. **Buffers replace tabs** — `<leader>bb` to pick a buffer, `H`/`L` to cycle
3. **Motions are your friend** — `f`, `t`, `/`, `w`, `b` replace mouse navigation
4. **Visual mode replaces selection** — `v` (char), `V` (line), `<C-v>` (block)
5. **`.` repeats last change** — more powerful than any multi-cursor
6. **Macros (`q`)** — record and replay complex edits, better than find-and-replace
7. **`:Mason`** — manage language servers, formatters, linters (like Extensions panel)
8. **`:LazyExtras`** — browse and enable additional language/tool support
