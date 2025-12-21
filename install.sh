#!/bin/bash

REPO_URL="https://raw.githubusercontent.com/Kiel-p/menupy/main/main.py"
TARGET="$HOME/main.py"
BASHRC="$HOME/.bashrc"
MARKER="# MENUPY-AUTO-MENU"

# Fungsi Loading Bar
draw_progress() {
    local width=30
    local p=$1
    local num=$(( p * width / 100 ))
    local bar=$(printf "%${num}s" | tr ' ' '#')
    local space=$(printf "%$((width - num))s" | tr ' ' '-')
    printf "\r\33[96mProgress: [%-s%s] %d%%\e[0m" "$bar" "$space" "$p"
}

clear
echo -e "\033[1;95m===   •••••• Installing MenuPy ••••••   ===\e[0m"

# [1/4] Install Dependencies
echo -e "\n\033[92m[1/4] \033[93mMemasang dependencies..."
(pkg update -y && pkg install python git curl -y && pip install -q rich) > /dev/null 2>&1 &
pid=$!
while kill -0 $pid 2>/dev/null; do
    for i in {1..100}; do draw_progress $i; sleep 0.1; done
done
#draw_progress 40

# [2/4] \033[93mDownload main.py
echo -e "\n\n\033[92m[2/4] \033[93mMengunduh main.py..."
curl -fsSL "$REPO_URL" -o "$TARGET" > /dev/null 2>&1
chmod +x "$TARGET"
for i in {1..100}; do draw_progress $i; sleep 0.02; done

# [3/4] \033[93mSetup auto-run
echo -e "\n\n\033[92m[3/4] \033[93mKonfigurasi .bashrc..."
if grep -q "$MARKER" "$BASHRC" 2>/dev/null; then
  sed -i "/$MARKER/,+3d" "$BASHRC"
fi

cat >> "$BASHRC" <<EOF

$MARKER
# auto start menu on Termux launch
python \$HOME/main.py
EOF
for i in {1..100}; do draw_progress $i; sleep 0.02; done

# [4/4] Done
echo -e "\n\n\e[1;32m✅ Instalasi Selesai!\e[0m"
echo "-------------------------------------------------------"

echo "➡️  Tutup & buka kembali Termux untuk melihat menu."
echo "ℹ️  Uninstall: bash ~/menupy/uninstall.sh"
echo
echo "-------------------------\033[92m"By.KIHEO"----------------------"
#echo "-------------------------------------------------------"
