# Quick Cheatsheet

Leader = `Space`. Press `Space` and wait for which-key to show groups. `<leader>sk` fuzzy-searches every keymap live.

Verified against the running config (`MIGRATION.md` had a couple of stale bindings — fixed here).

---

## Search

| Key | Action |
|---|---|
| `<leader>ff` | Find files (root dir) |
| `<leader>fr` | Recent files |
| `<leader>fg` | Find files (git-tracked) |
| `<leader>sg` | Grep (root dir) — live grep across project |
| `<leader>sw` | Grep word/selection under cursor |
| `<leader>sr` | Search and replace |
| `<leader>sb` | Search current buffer lines |
| `/pattern` | Search forward in file, `n`/`N` next/prev match |
| `<leader>sk` | Search keymaps |
| `<leader>sh` | Search help pages |
| `<leader>sd` | Search diagnostics |

## Copy / Paste

System clipboard is used by default (LazyVim sets `clipboard=unnamedplus`) — `y`/`d`/`p` already sync with macOS `Cmd+C`/`Cmd+V`, no `"+` prefix needed.

| Key | Action |
|---|---|
| `yy` | Yank (copy) current line |
| `y` + motion (e.g. `yw`, `y$`) | Yank to end of motion |
| `v` / `V` / `Ctrl+v` | Visual char / line / block select, then `y` to copy |
| `dd` | Cut (delete) line |
| `p` / `P` | Paste after / before cursor |
| `x` | Delete char under cursor (like backspace-forward) |
| `u` / `Ctrl+r` | Undo / redo |
| `.` | Repeat last change — often beats copy-paste entirely |
| `Ctrl+v` (block) then `I`/`A` | Multi-line insert/append (poor-man's multi-cursor) |
| `Ctrl+d` on word (vim-visual-multi) | True multi-cursor, repeat to add more |

## Navigate

| Key | Action |
|---|---|
| `w` / `b` | Next / previous word |
| `0` / `$` | Start / end of line |
| `gg` / `G` | Top / bottom of file |
| `f<char>` / `t<char>` | Jump to / before next `<char>` on line |
| `Ctrl+d` / `Ctrl+u` | Scroll half page down / up |
| `gd` | Go to definition |
| `gr` | Find references |
| `K` | Hover docs |
| `<leader>e` | File explorer (root dir) |
| `,` or `<leader>fb` | Switch buffers |
| `H` / `L` | Prev / next buffer |
| `Ctrl+h/j/k/l` | Move between window splits |
| `<leader>\|` / `<leader>-` | Vertical / horizontal split |

## Git

Primary interface is LazyGit (full TUI):

| Key | Action |
|---|---|
| `<leader>gg` | Open LazyGit |
| `a` (in LazyGit) | Stage file/hunk |
| `c` → message → `Enter` | Commit |
| `P` / `p` | Push / pull |

Inline, without leaving the buffer (gitsigns):

| Key | Action |
|---|---|
| `]h` / `[h` | Next / previous hunk |
| `<leader>ghs` | Stage hunk |
| `<leader>ghr` | Reset hunk |
| `<leader>ghp` | Preview hunk inline |
| `<leader>ghb` | Blame current line |
| `<leader>gd` | Diff view (hunks) |
| `<leader>gs` | Git status |
| `<leader>gh` | Current file history |

**Quick commit & push:** `<leader>gg` → `a` (stage) → `c` (commit) → `P` (push)

## Clojure Structural Editing

Two layers, both scoped to `clojure`/`edn` (and other lisps) buffers:

- **nvim-parinfer** — runs automatically, no keys needed. Balances parens/brackets as you type based on indentation ("smart" mode). Just write code; it keeps things closed.
- **nvim-paredit** — explicit structural commands below. `<localleader>` is `\` (backslash) by default.

Verified against the running config — `MIGRATION.md` had backward-slurp/barf swapped; the table below is correct.

| Key | Action |
|---|---|
| `>)` | Slurp forwards — pull next form into current one |
| `<)` | Barf forwards — push last element out |
| `<(` | Slurp backwards — pull previous form in |
| `>(` | Barf backwards — push first element out |
| `>e` / `<e` | Drag element right / left |
| `>f` / `<f` | Drag whole form right / left |
| `<localleader>o` | Raise form (replace parent with form under cursor) |
| `<localleader>O` | Raise element |
| `<localleader>@` | Splice / unwrap form under cursor |
| `<localleader>(` / `[` / `{` / `"` | Wrap element under cursor in `()` / `[]` / `{}` / `""` (added — not bound by default) |
| `(` / `)` | Jump to parent form's head / tail |
| `af` / `if` | Around / inside form (text object — use with `d`, `y`, `c`, `v`) |
| `aF` / `iF` | Around / inside top-level form |
| `ae` / `ie` | Around / inside element |

## Conjure (REPL / Eval)

Tested live against a real `lein repl` in `arc-exam/` — `lein repl :headless` in a project dir writes `.nrepl-port`, and opening any `.clj` file in that project auto-connects Conjure. No manual connect step needed in the normal case.

**Getting connected:**

1. In a terminal, `cd` into the project and run `lein repl` (or `clj -M:nrepl` / `bb` for babashka) — this starts the server and writes `.nrepl-port`.
2. Open any file in that project in nvim. Conjure watches for `.nrepl-port` and connects automatically — you'll see a `(connected)` banner in the log.
3. If it doesn't auto-connect (e.g. REPL started after nvim was already open), run `\cf` to connect using the port file, or `:ConjureConnect` manually.

**Evaluating code** (`<localleader>` = `\`):

| Key | Action |
|---|---|
| `\ee` | Evaluate current form (innermost, under cursor) |
| `\er` | Evaluate root/top-level form — use this for `(defn ...)` |
| `\ef` | Evaluate whole file |
| `\eb` | Evaluate buffer |
| `\ew` | Evaluate word |
| `\E` (visual mode) | Evaluate the visual selection |
| `\e!` | Evaluate form and replace it in-place with the result |
| `\ece` / `\ecr` / `\ecw` | Evaluate current/root form/word and insert result as a `;; =>` comment |
| `\ep` | Re-run the previous evaluation |
| `\ei` | Interrupt a hung evaluation |

**Reading output / errors:**

| Key | Action |
|---|---|
| `K` | LSP hover doc |
| `\K` | Conjure doc lookup (REPL-based, e.g. for macros LSP doesn't resolve) |
| `\lg` | Toggle the log window (shows eval results/output) |
| `\ls` / `\lv` | Open log in horizontal / vertical split |
| `\ll` | Jump to latest entry in the log |
| `\ve` | Show the last exception with stacktrace |

**Practical loop:** write a `defn`, `\er` to define it, move cursor into a call expression and `\ee` (or just type `(my-fn args)` on a scratch line and `\ee`) to try it, `\ve` if it blows up. Everything shows up live in the log (`\lg` to bring it back if you closed it).

**Session management** (rarely needed day-to-day): `\ss` prompt to pick among multiple REPL sessions, `\sf` fresh session, `\cd` disconnect.
