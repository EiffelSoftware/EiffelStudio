#!/bin/sh

sudo apt install yubico-piv-tool \
	opensc \
	opensc-pkcs11 \
	p7zip-full \
	curl

if [ ! -f jsign_4.1_all.deb ]; then
	wget https://github.com/ebourg/jsign/releases/download/4.1/jsign_4.1_all.deb
fi
sudo dpkg -i jsign_4.1_all.deb

echo "name = OpenSC-PKCS11" > eToken.cfg
echo "description = SunPKCS11 via OpenSC" >> eToken.cfg
echo "library = /usr/lib/x86_64-linux-gnu/opensc-pkcs11.so" >> eToken.cfg
echo "slotListIndex = 0" >> eToken.cfg

