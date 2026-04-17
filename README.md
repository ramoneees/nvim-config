# Neovim Configuration

Personal Neovim configuration built on [LazyVim](https://www.lazyvim.org/).

## Requirements

- Neovim >= 0.10
- Git
- [Nerd Font](https://www.nerdfonts.com/) (Fira Code Nerd Font recommended)
- [ripgrep](https://github.com/BurntSushi/ripgrep) (for live grep)
- [lazygit](https://github.com/jesseduffield/lazygit) (for git UI)
- [fd](https://github.com/sharkdp/fd) (for file finder)

## Installation

```bash
# Back up existing config
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.local/cache/nvim ~/.local/cache/nvim.bak

# Clone
git clone https://github.com/ramoneees/nvim-config.git ~/.config/nvim

# Launch (plugins install automatically on first run)
nvim
```

First launch takes 2-5 minutes to install all plugins and language servers.

## Structure

```
lua/
├── config/
│   ├── autocmds.lua      # Per-language indentation, auto-save on focus lost
│   ├── keymaps.lua        # Custom keymaps (LazyVim defaults are comprehensive)
│   ├── lazy.lua           # Plugin manager bootstrap + LazyVim extras
│   └── options.lua        # Editor options (scrolloff, autowriteall)
└── plugins/
    ├── ai.lua             # CodeCompanion (LiteLLM/Anthropic adapter)
    ├── custom.lua         # Catppuccin theme, gitsigns inline blame
    ├── devops.lua         # vim-dadbod database client
    ├── git.lua            # diffview.nvim (file history, diffs)
    ├── quality.lua        # CSV viewer, vim-visual-multi, cellular-automaton
    └── treesitter.lua     # Language parsers
```

## Language Support

All languages are enabled via LazyVim extras in `lua/config/lazy.lua`:

| Language | LSP | Formatter | Debugger |
|----------|-----|-----------|----------|
| Go | gopls | gofumpt, goimports | delve |
| Python | pyright | ruff | debugpy |
| TypeScript/JS | vtsls | prettier | -- |
| Java | jdtls | jdtls | java-debug-adapter |
| Kotlin | kotlin-language-server | ktlint | -- |
| Clojure | clojure-lsp | cljfmt | -- |
| Dart/Flutter | dart LSP | dart format | flutter |
| Docker | dockerfile-ls, compose-ls | -- | -- |
| Markdown | markdownlint | -- | -- |

Clojure includes [Conjure](https://github.com/Olical/conjure) for REPL-driven development.

## AI Integration

- **Claude Code** (`lazyvim.plugins.extras.ai.claudecode`) — connects to Claude Code CLI, no API key needed
- **CodeCompanion** (`lua/plugins/ai.lua`) — multi-provider AI chat routed through LiteLLM

CodeCompanion is configured to use a self-hosted [LiteLLM](https://github.com/BerriAI/litellm) proxy. Set `LITELLM_API_KEY` in your environment.

## Keybindings

LazyVim includes [which-key.nvim](https://github.com/folke/which-key.nvim) — press `<leader>` (Space) and wait to see all available bindings.

### Most Used

| Keys | Action |
|------|--------|
| `<leader>ff` | Find files |
| `<leader>sg` | Live grep (search in files) |
| `<leader>e` | File explorer (neo-tree) |
| `<C-/>` | Toggle terminal |
| `<leader>gg` | Lazygit |
| `gd` | Go to definition |
| `gr` | Go to references |
| `K` | Hover documentation |
| `<leader>cr` | Rename symbol |
| `<leader>ca` | Code actions |
| `<leader>cf` | Format |
| `<leader>bd` | Close buffer |
| `<leader>-` | Horizontal split |
| `<leader>\|` | Vertical split |

### Git

| Keys | Action |
|------|--------|
| `<leader>gg` | Lazygit |
| `<leader>gd` | Diffview (full diff) |
| `<leader>gh` | File history |
| `<leader>gH` | Branch history |

### AI

| Keys | Action |
|------|--------|
| `<leader>ac` | CodeCompanion Chat |
| `<leader>aa` | CodeCompanion Actions |
| `<leader>ai` | CodeCompanion Inline (normal/visual) |

### DevOps

| Keys | Action |
|------|--------|
| `<leader>D` | Database UI (vim-dadbod) |
| `<C-d>` | Multi-cursor select (like VSCode Cmd+D) |

### Diagnostics

| Keys | Action |
|------|--------|
| `<leader>xx` | Trouble (diagnostics panel) |
| `]d` / `[d` | Next/prev diagnostic |
| `]e` / `[e` | Next/prev error |

## Customization

- **Theme**: Change in `lua/plugins/custom.lua` (`colorscheme` field)
- **Language servers**: Managed by Mason (`:Mason` to see/install)
- **Add extras**: Browse available at `:LazyExtras`
- **Plugin updates**: `:Lazy update`
