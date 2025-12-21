#!/bin/bash

#!/bin/bash

REPO_URL="https://raw.githubusercontent.com/Kiel-p/menupy/main/main.py"
TARGET="$HOME/main.py"
BASHRC="$HOME/.bashrc"
MARKER="# MENUPY-AUTO-MENU"

# Fungsi Loading Bar Animasi Manual
# Argumen: $1 = pesan, $2 = kecepatan (detik)
fake_progress() {
    local message=$1
    local speed=$2
    local width=30
    for i in {1..100}; do
        local num=$(( i * width / 100 ))
        local bar=$(printf "%${num}s" | tr ' ' '#')
        local space=$(printf "%$((width - num))s" | tr ' ' '-')
        printf "\r\33[92m$message \33[96m[%-s%s] %d%%\e[0m" "$bar" "$space" "$i"
        sleep "$speed"
    done
    echo "" # Pindah baris setelah 100%
}

clear
echo -e "\033[1;95m===   •••••• Installing MENU ••••••   ===\e[0m"

# [1/3] Install Dependencies
echo -e "\n\033[92m[1/3] \033[93mMemasang Paket..."
# Jalankan proses asli di background
(pkg update -y && pkg install python git curl -y && pip install -q rich) > /dev/null 2>&1 &
# Tampilkan animasi loading sementara menunggu (simulasi 5 detik agar terlihat keren)
fake_progress "Processing:" 0.05

# [2/3] Download main.py
echo -e "\n\033[92m[2/3] \033[93mMengunduh MENU..."
curl -fsSL "$REPO_URL" -o "$TARGET" > /dev/null 2>&1
chmod +x "$TARGET"
fake_progress "Downloading:" 0.02

# [3/3] Setup auto-run
echo -e "\n\033[92m[3/3] \033[93mKonfigurasi Auto run..."
if grep -q "$MARKER" "$BASHRC" 2>/dev/null; then
  sed -i "/$MARKER/,+3d" "$BASHRC"
fi

cat >> "$BASHRC" <<EOF
$MARKER
# auto start menu on Termux launch
python \$HOME/main.py
EOF
fake_progress "Configuring:" 0.01

# SELESAI


# [4/4] Done
echo -e "\n\n\e[1;32m✅ Instalasi Selesai!\e[0m"
echo "-------------------------------------------------------"

echo "➡️  Tutup & buka kembali Termux untuk melihat menu."
echo "ℹ️  Uninstall: bash ~/menupy/uninstall.sh"
echo
echo -e "-------------------------\033[92m"By.KIHEO"\e[0m----------------------"
#echo "-------------------------------------------------------"
