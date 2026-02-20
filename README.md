# dotfiles

Claude Code settings + mise config. Minimal dotfiles focused on reproducibility.

## Setup

```bash
git clone --recursive https://github.com/hirakawat-hmp/dotfiles.git ~/dotfiles
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

**Plugins** (auto-installed by `install.sh`):

| Plugin | Marketplace |
|--------|------------|
| `frontend-design` | anthropics/claude-code |
| `cloud-infrastructure` | wshobson/agents |
| `ui-design` | wshobson/agents |
| `life-manager` | life/ (local submodule) |

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

### life (git submodule)

`life/` is a git submodule pointing to [hirakawat-hmp/life](https://github.com/hirakawat-hmp/life).
Claude Code plugin for life management via GitHub Issues + Projects.

| Command | Purpose |
|---------|---------|
| `/daily-review` | Daily task review and planning |
| `/new-issue` | Create life issue with auto-labels |
| `/update-issue` | Update existing issue |
| `/organize` | Reorganize issues |
| `/weekly-review` | Weekly retrospective |

Requires: `gh auth login` + `gh auth refresh -s project -h github.com`

## install.sh

The script is idempotent (safe to re-run):

1. Install mise (if not present)
2. Symlink `mise/config.toml` to `~/.config/mise/`
3. Symlink Claude Code config (rules, agents, commands, settings) to `~/.claude/`
4. Initialize life submodule
5. Register plugin marketplaces and install enabled plugins

## Adding Config

```bash
# Add a new rule
vim ~/dotfiles/claude/rules/new-rule.md
./install.sh  # re-link

# Add a new agent
vim ~/dotfiles/claude/agents/new-agent.md
./install.sh  # re-link
```
