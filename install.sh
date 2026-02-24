#!/usr/bin/env bash
set -euo pipefail

INSTALL_DIR="$HOME/.markflow"
REPO_BASE="https://raw.githubusercontent.com/darmie/markflow/main"

echo "Installing markflow to ${INSTALL_DIR}..."

mkdir -p "$INSTALL_DIR"

echo "  Downloading markflow..."
curl -sL "${REPO_BASE}/markflow" -o "${INSTALL_DIR}/markflow"
chmod +x "${INSTALL_DIR}/markflow"

echo "  Downloading template.html..."
curl -sL "${REPO_BASE}/template.html" -o "${INSTALL_DIR}/template.html"

# Add to PATH if not already there
if [[ ":$PATH:" != *":${INSTALL_DIR}:"* ]]; then
  SHELL_RC=""
  if [[ -f "$HOME/.zshrc" ]]; then
    SHELL_RC="$HOME/.zshrc"
  elif [[ -f "$HOME/.bashrc" ]]; then
    SHELL_RC="$HOME/.bashrc"
  elif [[ -f "$HOME/.bash_profile" ]]; then
    SHELL_RC="$HOME/.bash_profile"
  fi

  if [[ -n "$SHELL_RC" ]]; then
    if ! grep -q "\.markflow" "$SHELL_RC" 2>/dev/null; then
      echo "" >> "$SHELL_RC"
      echo "# Markflow" >> "$SHELL_RC"
      echo "export PATH=\"\$HOME/.markflow:\$PATH\"" >> "$SHELL_RC"
      echo "  Added ${INSTALL_DIR} to PATH in ${SHELL_RC}"
    fi
  else
    echo "  Add this to your shell profile:"
    echo "    export PATH=\"\$HOME/.markflow:\$PATH\""
  fi
fi

echo ""
echo "Done! Restart your shell or run:"
echo "  export PATH=\"\$HOME/.markflow:\$PATH\""
echo ""
echo "Then: markflow init"
