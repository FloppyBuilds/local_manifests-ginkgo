#!/bin/bash
set -e

DEVICES=(
  "ginkgo"
  "sm6125-common"
)
XML="$(pwd)/.repo/local_manifests/ginkgo.xml"
URL="https://github.com/FloppyBuilds"
[ -z "$BRANCH" ] && BRANCH="lineage-22.2"

if [ ! -f "$XML" ]; then
  echo "ginkgo.xml not found. Please execute from root dir."
  exit 1
fi

for m in "${DEVICES[@]}"; do
  sed -i "/$m/d" "$XML"
  [ -d "$(pwd)/device/xiaomi/$m" ] && rm -rf "$(pwd)/device/xiaomi/$m"
  git clone -j"$(nproc --all)" "$URL/android_device_xiaomi_$m" "$(pwd)/device/xiaomi/$m"
  [ -d "$(pwd)/vendor/xiaomi/$m" ] && rm -rf "$(pwd)/vendor/xiaomi/$m"
  git clone -j"$(nproc --all)" "$URL/proprietary_vendor_xiaomi_$m" "$(pwd)/vendor/xiaomi/$m"
done
