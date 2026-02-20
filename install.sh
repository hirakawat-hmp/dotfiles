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

# --- Phase 4: life repo (optional) ---
if [ ! -d ~/life ]; then
  echo ""
  read -p "Clone hirakawat-hmp/life repo? [y/N] " yn
  if [[ "$yn" =~ ^[Yy]$ ]]; then
    if ! command -v gh &>/dev/null; then
      warn "gh CLI not found. Run 'mise install' first, then re-run this script."
    elif ! gh auth status &>/dev/null 2>&1; then
      info "gh auth login required"
      gh auth login
      gh repo clone hirakawat-hmp/life ~/life
      ok "life repo cloned"
    else
      gh repo clone hirakawat-hmp/life ~/life
      ok "life repo cloned"
    fi
  fi
fi

# --- Done ---
echo ""
ok "dotfiles installation complete!"
echo ""
echo "Next steps:"
echo "  1. mise install          # Install all tools"
echo "  2. exec zsh -l           # Reload shell"
