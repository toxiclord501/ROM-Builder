#!/bin/bash
MANIFEST=
BRANCH=

mkdir -p /tmp/rom
cd /tmp/rom

# Repo init command, that -device,-mips,-darwin,-notdefault part will save you more time and storage to sync, add more according to your rom and choice.Optimization is welcomed! Let's make it quit, and with depth=1 so that no unnecessary things.
repo init --no-repo-verify --depth=1 -u "$MANIFEST" -b "$BRANCH" -g default,-device,-mips,-darwin,-notdefault
git config --global user.name "toxiclord501"
git config --global user.email "wahyuamri501@gmail.com"

# Sync source with -q, no need unnecessary messages, you can remove -q if want! try with -j30 first, if fails, it will try again with -j8
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all) || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

pwd
ls

git clone --depth=1 https://github.com/toxiclord501/lava -b aicp device/xiaomi/lava
git clone --depth=1 https://github.com/toxiclord501/vendor_xiaomi_lava -b 11 vendor/xiaomi/lava
git clone --depth=1 https://github.com/ZyCromerZ/android_kernel_xiaomi_mt6768 -b eleven-upstream-mod2 kernel/xiaomi/mt6768
