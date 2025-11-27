#!/data/data/com.termux/files/usr/bin/bash
set -e

BASHRC="$HOME/.bashrc"
MARKER="# MENUPY-AUTO-MENU"

echo "Remove auto-run from .bashrc..."
if grep -q "$MARKER" "$BASHRC" 2>/dev/null; then
  sed -i "/$MARKER/,+3d" "$BASHRC"
fi

echo "Remove main.py..."
rm -f "$HOME/main.py"

echo "✅ Uninstall selesai. Menu tidak auto-run lagi."
