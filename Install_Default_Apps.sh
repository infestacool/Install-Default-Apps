#!/bin/sh

temp=$TMPDIR$(uuidgen)
mkdir -p $temp/mount

curl -s https://raw.githubusercontent.com/rudix-mac/rpm/2015.10.20/rudix.py | sudo python - install rudix

install_app ()	{
	yes | hdiutil attach -noverify -nobrowse -mountpoint $temp/mount $temp/$1
	cp -r $temp/mount/*.app /Applications
	hdiutil detach $temp/mount
	}

curl https://dl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg > $temp/Chrome.dmg
	install_app Chrome.dmg
	
#curl http://mirror.lstn.net/videolan/vlc/2.2.4/macosx/vlc-2.2.4.dmg > $temp/VLC.dmg
#	install_app VLC.dmg

wget -O $temp/Firefox.dmg "http://download.mozilla.org/?product=firefox-latest&os=osx&lang=en-US"
	install_app Firefox.dmg

rm -r $temp

#diskutil verifyVolume /

exit 0
