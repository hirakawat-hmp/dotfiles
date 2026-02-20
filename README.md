# dotfiles

Claude Code settings + mise config. Minimal dotfiles focused on reproducibility.

## Setup

```bash
git clone https://github.com/hirakawat-hmp/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
mise install
```

## What's Included

### Claude Code (`~/.claude/`)

| Directory | Contents |
|-----------|----------|
| `rules/` | Coding style, development workflow, security, CLI tools |
| `agents/` | planner, code-reviewer, security-reviewer, tdd-guide, refactor-cleaner |
| `commands/` | /plan, /code-review, /verify, /tdd, /refactor-clean |
| `settings.json` | Plugin and MCP preferences |

### mise (`~/.config/mise/`)

`config.toml` defines 40+ tools. `mise install` sets up the entire CLI environment:

- **Languages**: node (lts), python, rust, julia
- **Editor**: helix
- **VCS**: jj, jjui, github-cli
- **Shell**: starship, sheldon, zoxide, direnv, fzf
- **Terminal**: zellij, yazi
- **CLI**: eza, fd, ripgrep, bat, delta, dust, duf, jq, xh, hyperfine, tokei
- **Dev**: uv, ruff, task, terraform, typst, marp-cli
- **Cloud**: gcloud, firebase, cloudflared, cloud-sql-proxy

## install.sh

The script is idempotent (safe to re-run):

1. Install mise (if not present)
2. Symlink `mise/config.toml` to `~/.config/mise/`
3. Symlink Claude Code config (rules, agents, commands, settings) to `~/.claude/`
4. Optionally clone `hirakawat-hmp/life` repo

## Adding Config

```bash
# Add a new rule
vim ~/dotfiles/claude/rules/new-rule.md
./install.sh  # re-link

# Add a new agent
vim ~/dotfiles/claude/agents/new-agent.md
./install.sh  # re-link
```
