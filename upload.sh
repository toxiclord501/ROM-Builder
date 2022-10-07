#!/bin/bash

cd /tmp

date=`date +%Y%m%d`

# Compress function with pigz for faster compression
com () 
{ 
    tar --use-compress-program="pigz -k -$2 " -cf $1.tar.gz ccache
}

time com ccache-example 1 # Compression level 1, its enough

up(){
	curl bashupload.com -T $1
}

up ccache-example.tar.gz
