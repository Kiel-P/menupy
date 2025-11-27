#!/data/data/com.termux/files/usr/bin/bash
set -e

REPO_URL="https://github.com/Kiel-P/menupy/blob/main/main.py"
TARGET="$HOME/main.py"
BASHRC="$HOME/.bashrc"
MARKER="# MENUPY-AUTO-MENU"

echo "[1/4] Install dependencies..."
pkg update -y >/dev/null
pkg install python git -y >/dev/null
pip install -q rich

echo "[2/4] Download main.py..."
curl -fsSL "$REPO_URL" -o "$TARGET"
chmod +x "$TARGET"

echo "[3/4] Setup auto-run in .bashrc..."
# hapus block lama kalau ada
if grep -q "$MARKER" "$BASHRC" 2>/dev/null; then
  # hapus dari marker sampai baris kosong berikutnya
  sed -i "/$MARKER/,+3d" "$BASHRC"
fi

cat >> "$BASHRC" <<EOF

$MARKER
# auto start menu on Termux launch
python \$HOME/main.py
EOF

echo "[4/4] Done!"
echo
echo "✅ Menu terpasang."
echo "➡️ Tutup Termux lalu buka lagi untuk melihat menu otomatis."
echo "ℹ️ Untuk uninstall: bash ~/menutrmx/uninstall.sh"
