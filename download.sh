#!/bin/bash

# Atur URL file dan nama output di sini
url="https://onboardcloud.dl.sourceforge.net/project/xiaomi-eu-multilang-miui-roms/xiaomi.eu/HyperOS-STABLE-RELEASES/HyperOS2.0/xiaomi.eu_ONYX_OS2.0.214.0.VOLCNXM_15.zip?viasf=1"
output="download/xiaomi.eu_ONYX_OS2.0.214.0.VOLCNXM_15.zip"

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
