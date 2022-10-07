#!/bin/bash
cd /tmp/rom
source build/envsetup.sh
lunch rom_lava-userdebug
export SKIP_API_CHECKS=true
export SKIP_ABI_CHECKS=true
cd /tmp/rom
export CCACHE_DIR=/tmp/ccache  ##use additional flags if you need(optional)
export CCACHE_EXEC=$(which ccache)
export USE_CCACHE=1

ccache -M 30G
ccache -o compression=true
ccache -z
ccache -c

up(){
	curl --upload-file $1 https://transfer.sh/
}

make_metalava(){
	mka api-stubs-docs
	mka system-api-stubs-docs
	mka test-api-stubs-docs
}

make_rom(){
	brunch
	zip=$(up out/target/product/lava/*zip)
	echo " "
	echo "$zip"
	curl -sL https://git.io/file-transfer | sh
	./transfer wet out/target/product/lava/*zip
}

make_metalava
make_rom
