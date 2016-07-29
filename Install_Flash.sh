#!/bin/sh

temp=$TMPDIR$(uuidgen)
mkdir -p $temp/mount

#curl -s https://raw.githubusercontent.com/rudix-mac/rpm/2015.10.20/rudix.py | sudo python - install rudix
#sudo rudix install wget


install_dmg_pkg_curl () {
		echo $1
		curl -m 60 $2 > $1
		yes | hdiutil attach -noverify -nobrowse -mountpoint $temp/mount $temp/$1
		sudo installer -pkg /Volumes/mount/$3 -target /
		hdiutil detach /Volumes/mount
		}

# Flash 
	install_dmg_pkg_curl Flash.dmg "https://fpdownload.macromedia.com/get/flashplayer/current/licensing/mac/install_flash_player_22_osx_pkg.dmg" "Install\ Adobe\ Flash\ Player.pkg"


exit 0
