#!/bin/sh

temp=$TMPDIR$(uuidgen)
mkdir -p $temp/mount

# wget
	curl -s https://raw.githubusercontent.com/rudix-mac/rpm/2015.10.20/rudix.py | sudo python - install rudix
	sudo rudix install wget

# Define Install Functions
	install_app ()	{
		echo Installing $1
		yes | hdiutil attach -noverify -nobrowse -mountpoint $temp/mount $temp/$1
		cp -r $temp/mount/*.app /Applications
		hdiutil detach $temp/mount
		}
	install_dmg_pkg () {
		wget --tries=0 --read-timeout=20 --no-check-certificate -O $temp/$1 $2
		yes | hdiutil attach -noverify -nobrowse -mountpoint $temp/mount $temp/$1
		sudo installer -pkg $temp/mount/$3 -target /
		hdiutil detach $temp/mount
		}
	
	install_dmg_pkg_curl () {
		curl $2 > $1
		yes | hdiutil attach -noverify -nobrowse -mountpoint $temp/mount $temp/$1
		sudo installer -pkg $temp/mount/$3 -target /
		hdiutil detach $temp/mount
		}

# Chrome
	curl -m 30 https://dl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg > $temp/Chrome.dmg
	install_app Chrome.dmg

# VLC
	wget --no-check-certificate -O  $temp/VLC.dmg https://get.videolan.org/vlc/2.2.4/macosx/VLC-webplugin-2.2.4.dmg
	install_app VLC.dmg

# Firefox	
	wget -O $temp/Firefox.dmg "http://download.mozilla.org/?product=firefox-latest&os=osx&lang=en-US"
	install_app Firefox.dmg

# Malware Bytes
	wget --no-check-certificate -O $temp/MBAM.dmg https://store.malwarebytes.com/342/purl-mbamm-dl
	install_app MBAM.dmg

# Office 2016 for O365 Activation. Link from http://macadmins.software/
	wget --tries=0 --read-timeout=20 --no-check-certificate -O $temp/Office.pkg http://go.microsoft.com/fwlink/?linkid=525133
	sudo installer -pkg $temp/Office.pkg -target /

#Silverlight
	install_dmg_pkg Silverlight.dmg "http://go.microsoft.com/fwlink/?LinkID=229322" silverlight.pkg

# XQuartz 
	install_dmg_pkg XQuartz.dmg "https://dl.bintray.com/xquartz/downloads/XQuartz-2.7.9.dmg" XQuartz.pkg 

# HP Printer Drivers
	install_dmg_pkg HPDrivers.dmg "http://support.apple.com/downloads/DL907/en_US/hpprinterdriver3.1.dmg" HewlettPackardPrinterDrivers.pkg

# Ricoh Printer Drivers 
	install_dmg_pkg RicohDrivers.dmg "http://support.apple.com/downloads/DL1867/en_US/ricohprinterdrivers3.0.dmg" RicohPrinterDrivers.pkg

# Flash 
	install_dmg_pkg_curl Flash.dmg "https://fpdownload.macromedia.com/get/flashplayer/current/licensing/mac/install_flash_player_22_osx_pkg.dmg" "Install Adobe Flash Player.pkg"
rm -r $temp

#diskutil verifyVolume /

exit 0
