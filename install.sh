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
    printf "\r\e[32mProgress: [%-s%s] %d%%\e[0m" "$bar" "$space" "$p"
}

clear
echo -e "\e[1;34m=== Installing MenuPy ===\e[0m"

# [1/4] Install Dependencies
echo -e "\n[1/4] Memasang dependencies..."
(pkg update -y && pkg install python git curl -y && pip install -q rich) > /dev/null 2>&1 &
pid=$!
while kill -0 $pid 2>/dev/null; do
    for i in {1..40}; do draw_progress $i; sleep 0.1; done
done
draw_progress 40

# [2/4] Download main.py
echo -e "\n\n[2/4] Mengunduh main.py..."
curl -fsSL "$REPO_URL" -o "$TARGET" > /dev/null 2>&1
chmod +x "$TARGET"
for i in {41..70}; do draw_progress $i; sleep 0.02; done

# [3/4] Setup auto-run
echo -e "\n\n[3/4] Konfigurasi .bashrc..."
if grep -q "$MARKER" "$BASHRC" 2>/dev/null; then
  sed -i "/$MARKER/,+3d" "$BASHRC"
fi

cat >> "$BASHRC" <<EOF

$MARKER
# auto start menu on Termux launch
python \$HOME/main.py
EOF
for i in {71..100}; do draw_progress $i; sleep 0.02; done

# [4/4] Done
echo -e "\n\n\e[1;32m✅ Instalasi Selesai!\e[0m"
echo "-------------------------------------------------------"
cols=$(tput cols)
text="K I H E O"
echo "➡️  Tutup & buka kembali Termux untuk melihat menu."
echo "ℹ️  Uninstall: bash ~/menupy/uninstall.sh"
printf "%*s\n" $(((${#text}+$cols)/2)) "$text"

scho "-------------------------------------------------------"
