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

---

## Clojure: Calva (VSCode) to Conjure (Neovim)

The LazyVim `extras.lang.clojure` extra replaces Calva with Conjure + clojure-lsp + paredit.

### REPL Workflow

| Calva (VSCode) | Conjure (Neovim) |
|---|---|
| `Ctrl+Alt+C Ctrl+Alt+J` (Jack-in) | Start `nREPL` externally (`lein repl`, `clj -M:nrepl`), Conjure auto-connects |
| `Ctrl+Alt+C Enter` (eval current form) | `<localleader>ee` (eval inner form) |
| `Ctrl+Alt+C Space` (eval top-level form) | `<localleader>er` (eval root/outer form) |
| `Ctrl+Alt+C Ctrl+Alt+E` (eval selection) | Visual select + `<localleader>E` (eval selection) |
| `Ctrl+Alt+C Ctrl+Alt+N` (eval ns form) | `<localleader>ef` (eval file/buffer) |
| REPL output panel | `<localleader>ls` (log split) / `<localleader>lv` (log vsplit) |
| Hover doc | `K` (LSP hover) or `<localleader>K` (Conjure doc) |
| Inline eval results | Conjure shows results inline as virtual text |

> **Note:** `<localleader>` is `,` by default in LazyVim. So `<localleader>ee` = `,ee`.

### Structural Editing (Paredit)

| Calva Paredit (VSCode) | nvim-paredit (Neovim) |
|---|---|
| `Ctrl+Right` (slurp forward) | `>)` (slurp forward) |
| `Ctrl+Left` (barf forward) | `<)` (barf forward) |
| `Ctrl+Shift+Right` (barf backward) | `>(` (slurp backward) |
| `Ctrl+Shift+Left` (slurp backward) | `<(` (barf backward) |
| `Ctrl+Alt+Up` (raise sexp) | `<localleader>o` (raise form) |
| `Ctrl+W` (expand selection) | `vaf` (select around form) / `vif` (select inner form) |
| Kill sexp | `daf` (delete around form) |

### Clojure LSP

| Calva Feature | clojure-lsp (Neovim) |
|---|---|
| Go to definition | `gd` |
| Find references | `gr` |
| Rename symbol | `<leader>cr` |
| Code actions (add require, etc.) | `<leader>ca` |
| Namespace cleanup | `<leader>ca` → "Clean ns" |
| Drag forward/backward | `<leader>ca` → "Drag forward/backward" |

---

## Git Operations

### LazyGit (Primary Git Interface)

LazyGit replaces the VSCode Source Control panel with a full TUI.

| Operation | Keybinding |
|---|---|
| Open LazyGit | `<leader>gg` |
| Stage file | `a` (in LazyGit files panel) |
| Stage hunk | Select hunk → `a` |
| Commit | `c` → type message → `Enter` |
| Push | `P` (shift+p) |
| Pull | `p` |
| Create branch | `n` (in branches panel) |
| Switch branch | `Space` on branch |
| Interactive rebase | `r` on commit → `i` |
| Cherry-pick | `C` (copy) on commit, `V` (paste) on target branch |
| Stash | `s` (stash), `g` (pop stash) |
| Abort merge/rebase | `M` (in merge panel) |

### Gitsigns (Inline Git)

| Operation | Keybinding |
|---|---|
| Inline blame (current line) | Always visible (configured in `lua/plugins/custom.lua`) |
| Next hunk | `]h` |
| Previous hunk | `[h` |
| Stage hunk | `<leader>ghs` |
| Reset hunk | `<leader>ghr` |
| Preview hunk | `<leader>ghp` |
| Blame line (full) | `<leader>ghb` |

### Diffview

| Operation | Keybinding |
|---|---|
| Open diff view | `<leader>gd` |
| Current file history | `<leader>gh` |
| Branch history | `<leader>gH` |
| Close diffview | `<leader>q` or `:DiffviewClose` |

### Common Git Workflows

**Quick commit & push:**
1. `<leader>gg` → stage files (`a`) → commit (`c`) → push (`P`)

**Review changes before commit:**
1. `<leader>gd` to see all changes in diffview
2. `<leader>gg` to open LazyGit and commit

**Resolve merge conflicts:**
1. `<leader>gd` opens diffview merge tool
2. Pick changes from left (ours) or right (theirs)
3. Save and close → continue in LazyGit

**View file history / git blame:**
1. `<leader>gh` for current file history
2. Inline blame always visible on current line

---

### Tips for VSCode Users

1. **Leader key is Space** — press it and wait to see all available groups
2. **Buffers replace tabs** — `<leader>bb` to pick a buffer, `H`/`L` to cycle
3. **Motions are your friend** — `f`, `t`, `/`, `w`, `b` replace mouse navigation
4. **Visual mode replaces selection** — `v` (char), `V` (line), `<C-v>` (block)
5. **`.` repeats last change** — more powerful than any multi-cursor
6. **Macros (`q`)** — record and replay complex edits, better than find-and-replace
7. **`:Mason`** — manage language servers, formatters, linters (like Extensions panel)
8. **`:LazyExtras`** — browse and enable additional language/tool support
