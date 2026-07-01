# VSCode to Neovim Migration Guide

Migration reference from VSCode (49 extensions) to this LazyVim configuration.

---

## 2-Week Migration Roadmap

The strategy: **keep VSCode open**. Use Neovim for one thing at a time until it feels natural, then add the next. Don't try to switch cold.

### Week 1 — Survive and Navigate

**Day 1–2: Modal editing basics**

Goal: open a file, edit it, save it, quit. Nothing else.

| Task | How |
|---|---|
| Open Neovim | `nvim filename` |
| Enter insert mode | `i` (before cursor), `a` (after), `o` (new line below) |
| Return to normal mode | `Esc` or `Ctrl+[` |
| Save | `:w` or just switch windows (autowriteall saves on FocusLost) |
| Quit | `:q` — or `:qa` to quit all |
| Undo / Redo | `u` / `Ctrl+r` |

Practice: open a real file you're working on and make a small change. Do this for every edit on day 1–2.

---

**Day 3–4: Movement — stop using arrow keys**

| Motion | What it does |
|---|---|
| `w` / `b` | next / previous word |
| `0` / `$` | start / end of line |
| `gg` / `G` | top / bottom of file |
| `f<char>` | jump to next `<char>` on line |
| `/{pattern}` | search forward, `n`/`N` to cycle |
| `Ctrl+d` / `Ctrl+u` | scroll half page down/up |
| `<leader>ff` | fuzzy find file (replaces `Cmd+P`) |
| `<leader>sg` | live grep (replaces `Cmd+Shift+F`) |

Practice: navigate a real codebase without touching the arrow keys or mouse.

---

**Day 5–7: Buffers and the file explorer**

VSCode tabs → Neovim buffers. This is the biggest mental shift.

| Task | How |
|---|---|
| Open file explorer | `<leader>e` |
| Cycle buffers | `H` (prev) / `L` (next) |
| Pick a buffer | `<leader>bb` |
| Close buffer | `<leader>bd` |
| Split vertical | `<leader>\|` |
| Split horizontal | `<leader>-` |
| Move between splits | `Ctrl+h/j/k/l` |

Practice: open your project in neo-tree, navigate between 3–4 files using only buffers and splits.

---

### Week 2 — Replace VSCode Features One by One

**Day 8–9: LSP — code intelligence**

This already works out of the box for all your languages.

| Task | How |
|---|---|
| Go to definition | `gd` (replaces `F12`) |
| Find references | `gr` (replaces `Shift+F12`) |
| Hover docs | `K` |
| Rename symbol | `<leader>cr` — live preview across buffers via inc-rename (replaces `F2`) |
| Code actions | `<leader>ca` (replaces `Ctrl+.`) |
| Diagnostics list | `<leader>xx` |
| Next / prev diagnostic | `]d` / `[d` |
| Symbol outline | `<leader>cs` — outline.nvim (replaces VSCode's Outline panel) |
| Extract function/method | `<leader>rf` — refactoring.nvim (replaces VSCode's "Extract" actions) |
| Highlight references of word | Automatic — illuminate (replaces VSCode's word highlight) |

Practice: do a real refactor (rename a function, find all usages) entirely in Neovim.

---

**Day 10: Git — replace the Source Control panel**

| Task | How |
|---|---|
| Open LazyGit | `<leader>gg` (full Git TUI) |
| Stage file | `a` inside LazyGit |
| Commit | `c` → type message → `Enter` |
| Push | `P` |
| View inline blame | always on (configured) |
| Stage/reset hunk | `<leader>ghs` / `<leader>ghr` |
| View file history | `<leader>gh` |
| Open diff view | `<leader>gd` |

Practice: do a complete commit+push cycle from Neovim. Don't open VSCode's Source Control.

---

**Day 11: AI tools**

| Task | How |
|---|---|
| Open AI chat | `<leader>ac` (CodeCompanion, routes via LiteLLM) |
| AI actions menu | `<leader>aa` |
| Inline AI edit | `<leader>ai` (visual select first, then ask) |
| Claude Code sidebar | Built-in via LazyVim `claudecode.nvim` extra |

Practice: ask CodeCompanion to explain a function, then use inline mode to refactor something.

---

**Day 12: Language-specific features**

*Clojure (if applicable):*
- Start your REPL externally (`lein repl`), Conjure auto-connects
- `\ee` eval form under cursor, `\er` eval top-level, `\ls` open log

*Debugging (any language):*
- `<leader>db` set breakpoint, `<leader>dc` continue, `<leader>du` open DAP UI

*Testing:*
- `<leader>tr` run nearest test, `<leader>ts` run test suite, `<leader>to` open output

---

**Day 13–14: Power moves**

Once the basics are muscle memory, add these:

| Feature | How |
|---|---|
| Multi-cursor (`Cmd+D`) | `Ctrl+d` on word, repeat to select more |
| Repeat last change | `.` — more powerful than multi-cursor for most edits |
| Record a macro | `qq` start, edit, `q` stop, `@q` replay |
| Floating terminal (k9s, lazygit, pnpm) | `<leader>tt` (toggleterm) |
| Edit filesystem as text | `-` to open parent dir in oil.nvim |
| Symbol outline | `<leader>cs` (outline.nvim) |
| Task runner (Maven/Gradle/pnpm/turbo) | `<leader>of` run task, `<leader>or` rerun (overseer) |
| Database UI | `<leader>D` (vim-dadbod-ui) |
| Format file | `<leader>cf` |
| Toggle terminal | `Ctrl+/` |
| Plugin manager | `:Lazy` |
| Install LSP/tools | `:Mason` |

---

### Migration Checklist

- [ ] Day 1–2: Can edit and save without thinking about modes
- [ ] Day 3–4: Navigate a file without arrow keys
- [ ] Day 5–7: Open project, switch buffers, use splits
- [ ] Day 8–9: LSP (go to def, rename, code actions) feel natural
- [ ] Day 10: Full git workflow in LazyGit
- [ ] Day 11: Using AI tools in Neovim
- [ ] Day 12: Language REPL / debug / test workflow
- [ ] Day 13–14: Macros, multi-cursor, power tools
- [ ] **End of week 2: Close VSCode**

---

## VSCode Extension Replacements

### Languages (LazyVim extras in `lua/config/lazy.lua`)

| VSCode Extension | Neovim Replacement |
|---|---|
| `golang.go` | `extras.lang.go` (gopls, gofumpt, delve) |
| `ms-python.python` + `vscode-pylance` | `extras.lang.python` (pyright, ruff, debugpy) |
| `ms-vscode.vscode-typescript-next` + `dbaeumer.vscode-eslint` | `extras.lang.typescript` (tsserver, ESLint via `extras.linting.eslint`) |
| `esbenp.prettier-vscode` | `extras.formatting.prettier` (via conform.nvim) |
| `betterthantomorrow.calva` | `extras.lang.clojure` (clojure-lsp, Conjure REPL, paredit) |
| `redhat.java` + `vscjava.*` | `extras.lang.java` (jdtls, java-debug-adapter) |
| `fwcd.kotlin` | `extras.lang.kotlin` (kotlin-language-server) |
| `dart-code.dart-code` + `flutter` | `extras.lang.dart` (dart LSP, flutter tools) |
| `redhat.vscode-yaml` | Built-in (yaml-language-server via Mason) |
| `HashiCorp.terraform` | `terraform-ls` + `tflint` + `terraform_fmt` (`lua/plugins/lang-servers.lua`) |
| `technosophos/vscode-helm` | `helm-ls` (`lua/plugins/lang-servers.lua`) |
| `mtxr.sqltools` | `sqls` LSP — pairs with vim-dadbod (`lua/plugins/lang-servers.lua`) |
| `docker` | `extras.lang.docker` (dockerfile-ls, compose-ls) |
| `yzhang.markdown-all-in-one` | `extras.lang.markdown` (marksman LSP, render-markdown) |
| `ms-vscode.js-debug` + `ms-python.debugpy` | `extras.dap.core` (nvim-dap + UI) |
| `hbenl.vscode-test-explorer` | `extras.test.core` (neotest) |

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
| `openai.chatgpt` | `codecompanion.nvim` — `<leader>ac` chat, `<leader>aa` actions, `<leader>ai` inline (`lua/plugins/ai.lua`) |

### DevOps

| VSCode Extension | Neovim Replacement |
|---|---|
| `cweijan.vscode-database-client2` | `vim-dadbod` + `vim-dadbod-ui` — `<leader>D` (`lua/plugins/devops.lua`) |
| `ms-kubernetes-tools` | `kubectl` CLI in terminal (`<leader>tt` floating terminal); K8s YAML schema via yaml-language-server |
| `HashiCorp.terraform` / Helm | `terraform-ls`, `helm-ls`, `tflint` LSPs in-editor (`lua/plugins/lang-servers.lua`) |
| `ms-vscode-remote.remote-ssh` | Native `nvim` over SSH: `ssh host nvim file` |
| `ms-vscode-remote.remote-containers` | `devcontainer` CLI + SSH into container |
| `github.vscode-github-actions` | `gh run list` / `gh run watch` in terminal |

### Editor Features

| VSCode Feature | Neovim Replacement |
|---|---|
| Auto-save on focus change | `autowriteall` + `FocusLost` autocmd (`lua/config/autocmds.lua`) |
| Multi-cursor (`Cmd+D`) | `vim-visual-multi` — `<C-d>` (`lua/plugins/quality.lua`) |
| File explorer sidebar | `neo-tree` — `<leader>e` (built into LazyVim) |
| Edit filesystem like a buffer | `oil.nvim` — press `-` to open parent dir (`lua/plugins/editor.lua`) |
| Sticky current function/class | `nvim-treesitter-context` — automatic at top of window (`lua/plugins/editor.lua`) |
| Code folding | `nvim-ufo` — `zR` open all, `zM` close all (`lua/plugins/editor.lua`) |
| Floating/scoped terminal | `toggleterm.nvim` — `<leader>tt` float, `<leader>th` horiz, `<leader>tv` vert (`lua/plugins/editor.lua`) |
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
| Outline panel | `<leader>cs` |
| Run build/task | `<leader>of` (overseer) |
| Toggle terminal | `<leader>tt` (floating) |

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

> **Note:** `<localleader>` is `\` (backslash) by default in LazyVim. So `<localleader>ee` = `\ee`.

### Structural Editing (Paredit)

LazyVim's clojure extra ships two tools that work together:
- **nvim-paredit** — explicit structural operations (slurp, barf, raise, wrap, splice)
- **nvim-parinfer** — automatic paren/indent balancing as you type (runs passively)

You do not need to think about parinfer — it just keeps parens balanced. You only use paredit bindings for intentional restructuring.

#### Slurp & Barf

Slurp = pull a neighbouring form *into* the current list. Barf = push the last/first element *out*.

| Operation | Key | Example |
|---|---|---|
| Slurp forward (pull right neighbour in) | `>)` | `(a b) c` → `(a b c)` |
| Barf forward (push last element out) | `<)` | `(a b c)` → `(a b) c` |
| Slurp backward (pull left neighbour in) | `>(` | `a (b c)` → `(a b c)` |
| Barf backward (push first element out) | `<(` | `(a b c)` → `a (b c)` |

> Tip: prefix with a count — `3>)` slurps 3 times in one shot.

#### Raise, Splice & Move

| Operation | Key | What it does |
|---|---|---|
| Raise form | `<localleader>o` | Replace parent with form under cursor |
| Splice (unwrap) | `<localleader>O` | Remove surrounding delimiters, keep contents |
| Move element right | `>e` | Swap element with its right sibling |
| Move element left | `<e` | Swap element with its left sibling |

Raise example: `(foo (bar baz))` with cursor on `(bar baz)` → `(bar baz)`

#### Wrap

Place cursor on a form, then wrap it in new delimiters:

| Key | Wraps with |
|---|---|
| `<localleader>(` | `( )` |
| `<localleader>[` | `[ ]` |
| `<localleader>{` | `{ }` |
| `<localleader>"` | `" "` |

#### Navigation

| Key | Moves to |
|---|---|
| `(` | Start of previous form at current depth |
| `)` | End of next form at current depth |
| `[[` | Start of top-level form above |
| `]]` | Start of next top-level form |

#### Text Objects

Use with any operator (`d`, `y`, `c`, `v`):

| Text object | Selects |
|---|---|
| `af` | Around form (including delimiters) |
| `if` | Inside form (excluding delimiters) |
| `ae` | Around element (symbol, keyword, string) |
| `ie` | Inside element (string content only) |

Examples:
- `daf` — delete the entire form under cursor
- `yif` — yank contents of a list (without the parens)
- `cae` — change a symbol/keyword in place
- `vaf` then `>)` — select a form then slurp into it

#### Practical Workflow: Thread a function

Before: `(d (c (b (a x))))`

1. Position cursor on `(a x)`, press `<localleader>o` (raise) → `(a x)`
2. Use `<leader>ca` → "Thread first" (clojure-lsp refactor) → `(-> x a b c d)`

Or manually thread with slurp/barf — but LSP code actions (`<leader>ca`) handle `->/->>/as->` threading automatically.

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
