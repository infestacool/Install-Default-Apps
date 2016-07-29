#!/bin/sh

temp=$TMPDIR$(uuidgen)
mkdir -p $temp/mount

install_dmg_pkg_curl () {
		echo $1
		curl -m 60 $2 > $1
		yes | hdiutil attach -noverify -nobrowse -mountpoint $temp/mount $temp/$1
		sudo installer -pkg $temp/mount/Install\ Adobe\ Flash\ Player.pkg -target /
		hdiutil detach $temp/mount
		}

# Flash 
	install_dmg_pkg_curl Flash.dmg "https://fpdownload.macromedia.com/get/flashplayer/current/licensing/mac/install_flash_player_22_osx_pkg.dmg"


exit 0
