#!/usr/bin/env bash

export LANG=en_US.UTF8
set -e
set -u
set -o pipefail


SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)

if [[ ! -d ${SCRIPT_DIR}/lib ]]; then
    mkdir ${SCRIPT_DIR}/lib
fi

if [[ ! -d ${SCRIPT_DIR}/tmp ]]; then
    mkdir ${SCRIPT_DIR}/tmp
fi
cd ${SCRIPT_DIR}/tmp

filename=icedtea-netx_1.8-0ubuntu8~18.04_amd64.deb

echo
echo "Downloading 'icedtea-netx_1.8' in Ubuntu 18.04 LTS ..."
curl -o ${filename} "http://security.ubuntu.com/ubuntu/pool/universe/i/icedtea-web/${filename}" 2> /dev/null

if [[ $? -ne 0 ]]; then
    >&2 echo
    >&2 echo Download Fail!
    >&2 echo
    exit 1
fi

echo Unpacking...
ar -x ${filename}
tar xfz data.tar.xz
cp ./usr/share/icedtea-web/netx.jar ${SCRIPT_DIR}/lib

rm -rf ${SCRIPT_DIR}/tmp

echo
echo Finished!
echo
echo Please run ./bin/javaws
echo
