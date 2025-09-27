#!/bin/bash

# Minta input URL
read -p "Masukkan URL file: " url
read -p "Masukkan nama output file (dengan path): " output

# Buat folder output jika belum ada
outdir=$(dirname "$output")
mkdir -p "$outdir"

# Panjang progress bar
BAR_WIDTH=50

# Jalankan wget, ambil hanya persentase
wget --progress=dot "$url" -O "$output" 2>&1 | grep --line-buffered "%" | \
while read -r line; do
    # Ambil angka persen terakhir di baris
    percent=$(echo "$line" | grep -o "[0-9]*%" | tail -1 | tr -d '%')

    # Hitung jumlah '#' dan '-'
    filled=$(( percent * BAR_WIDTH / 100 ))
    empty=$(( BAR_WIDTH - filled ))

    # Buat progress bar
    bar=$(printf "%${filled}s" | tr ' ' '#')
    space=$(printf "%${empty}s" | tr ' ' '-')

    # Tampilkan progress bar
    printf "\r[%s%s] %d%%" "$bar" "$space" "$percent"
done

echo -e "\nDownload selesai! -> $output"
