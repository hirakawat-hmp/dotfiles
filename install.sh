#!/bin/bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

info() { printf "\033[1;34m[info]\033[0m %s\n" "$1"; }
ok()   { printf "\033[1;32m[ok]\033[0m   %s\n" "$1"; }
warn() { printf "\033[1;33m[warn]\033[0m %s\n" "$1"; }

# --- Phase 1: mise ---
if ! command -v mise &>/dev/null; then
  info "Installing mise..."
  curl https://mise.run | sh
  export PATH="$HOME/.local/bin:$PATH"
  ok "mise installed"
else
  ok "mise already installed"
fi

# --- Phase 2: mise config ---
mkdir -p ~/.config/mise
ln -sf "$DOTFILES/mise/config.toml" ~/.config/mise/config.toml
ok "mise config linked"

# --- Phase 3: Claude Code ---
mkdir -p ~/.claude/rules ~/.claude/agents ~/.claude/commands

for f in "$DOTFILES"/claude/rules/*.md; do
  [ -f "$f" ] && ln -sf "$f" ~/.claude/rules/"$(basename "$f")"
done
ok "Claude Code rules linked"

for f in "$DOTFILES"/claude/agents/*.md; do
  [ -f "$f" ] && ln -sf "$f" ~/.claude/agents/"$(basename "$f")"
done
ok "Claude Code agents linked"

for f in "$DOTFILES"/claude/commands/*.md; do
  [ -f "$f" ] && ln -sf "$f" ~/.claude/commands/"$(basename "$f")"
done
ok "Claude Code commands linked"

ln -sf "$DOTFILES/claude/settings.json" ~/.claude/settings.json
ok "Claude Code settings linked"

# --- Phase 4: life submodule ---
info "Initializing life submodule..."
cd "$DOTFILES"
git submodule update --init --recursive
ok "life submodule initialized"

# --- Phase 5: Claude Code plugins ---
if command -v claude &>/dev/null; then
  info "Registering plugin marketplaces..."

  # GitHub marketplaces
  MARKETPLACES=(
    "anthropics/claude-plugins-official"
    "anthropics/claude-code"
    "wshobson/agents"
    "affaan-m/everything-claude-code"
    "yamadashy/repomix"
    "ComposioHQ/awesome-claude-skills"
    "ChromeDevTools/chrome-devtools-mcp"
    "muratcankoylan/Agent-Skills-for-Context-Engineering"
    "K-Dense-AI/claude-scientific-skills"
  )
  for repo in "${MARKETPLACES[@]}"; do
    claude plugin marketplace add "$repo" 2>/dev/null && ok "marketplace: $repo" || warn "marketplace already registered or failed: $repo"
  done

  # Local marketplace (life submodule)
  claude plugin marketplace add "$DOTFILES/life" 2>/dev/null && ok "marketplace: life (local)" || warn "marketplace already registered or failed: life"

  info "Installing enabled plugins..."

  # Plugins enabled in settings.json
  PLUGINS=(
    "frontend-design@claude-code-plugins"
    "cloud-infrastructure@claude-code-workflows"
    "ui-design@claude-code-workflows"
    "life-manager@life-marketplace"
  )
  for plugin in "${PLUGINS[@]}"; do
    claude plugin install "$plugin" 2>/dev/null && ok "plugin: $plugin" || warn "plugin already installed or failed: $plugin"
  done

  echo ""
  info "life-manager requires: gh auth login + gh auth refresh -s project -h github.com"
else
  warn "Claude Code not found. Install it first, then run this script again to register plugins."
fi

# --- Done ---
echo ""
ok "dotfiles installation complete!"
echo ""
echo "Next steps:"
echo "  1. mise install          # Install all tools"
echo "  2. exec zsh -l           # Reload shell"
