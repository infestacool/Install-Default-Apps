#!/bin/sh

temp=$TMPDIR$(uuidgen)

cd $temp
curl http://winlndskappprd/Distribute/IdentityFinder/HBS-IDFinder_9.1_[prod]_MACv2/IdentityFinder.pkg > $temp/IdentityFinder.pkg
curl http://winlndskappprd/Distribute/IdentityFinder/HBS-IDFinder_9.1_[prod]_MACv2/Info.plist > $temp/Info.plist

sudo installer -pkg $temp/IdentityFinder.pkg -target /
rm -r $temp

exit 0
