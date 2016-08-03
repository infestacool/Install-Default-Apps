#!/bin/sh

temp=$TMPDIR$(uuidgen)

# wget
	curl -s https://raw.githubusercontent.com/rudix-mac/rpm/2015.10.20/rudix.py | sudo python - install rudix
	sudo rudix install wget
	
cd $temp
wget $temp/IdentityFinder.pkg http://winlndskappprd/Distribute/IdentityFinder/HBS-IDFinder_9.1_[prod]_MACv2/IdentityFinder.pkg
wget $temp/Info.plist http://winlndskappprd/Distribute/IdentityFinder/HBS-IDFinder_9.1_[prod]_MACv2/Info.plist

sudo installer -pkg $temp/IdentityFinder.pkg -target /
rm -r $temp

exit 0
