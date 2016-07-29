#!/bin/sh

temp=$TMPDIR$(uuidgen)
mkdir -p $temp/mount

curl -s https://raw.githubusercontent.com/rudix-mac/rpm/2015.10.20/rudix.py | sudo python - install rudix
sudo rudix install wget


install_dmg_pkg_curl () {
		echo $1
		curl -m 60 $2 > $1
		yes | hdiutil attach -noverify -nobrowse -mountpoint ~Desktop/mount $temp/$1
		sudo installer -pkg ~Desktop/mount/$3 -target /
		hdiutil detach ~Desktop/mount
		}

# Flash 
	install_dmg_pkg_curl Flash.dmg "https://fpdownload.macromedia.com/get/flashplayer/current/licensing/mac/install_flash_player_22_osx_pkg.dmg" "Install Adobe Flash Player.pkg"

rm -r $temp

#diskutil verifyVolume /

exit 0