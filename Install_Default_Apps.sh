#!/bin/sh

temp=$TMPDIR$(uuidgen)
mkdir -p $temp/mount

# wget
curl -s https://raw.githubusercontent.com/rudix-mac/rpm/2015.10.20/rudix.py | sudo python - install rudix
sudo rudix install wget

	install_app ()	{
	echo Installing $1
	yes | hdiutil attach -noverify -nobrowse -mountpoint $temp/mount $temp/$1
	cp -r $temp/mount/*.app /Applications
	hdiutil detach $temp/mount
		}

# Chrome
	curl -m 30 https://dl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg > $temp/Chrome.dmg
	install_app Chrome.dmg

# VLC
	wget -O  $temp/VLC.dmg https://get.videolan.org/vlc/2.2.4/macosx/VLC-webplugin-2.2.4.dmg
	install_app VLC.dmg

# Firefox	
	wget -O $temp/Firefox.dmg "http://download.mozilla.org/?product=firefox-latest&os=osx&lang=en-US"
	install_app Firefox.dmg

# Malware Bytes
	wget --no-check-certificate -O $temp/MBAM.dmg https://store.malwarebytes.com/342/purl-mbamm-dl
	install_app MBAM.dmg

#Silverlight
	wget -O $temp/Silverlight.dmg "http://go.microsoft.com/fwlink/?LinkID=229322"
	yes | hdiutil attach -noverify -nobrowse -mountpoint $temp/mount $temp/Silverlight.dmg
	sudo installer -pkg $temp/mount/silverlight.pkg -target /
	hdiutil detach $temp/mount

# Link from http://macadmins.software/
	wget --tries=0 --read-timeout=20 --no-check-certificate -O $temp/Office.pkg http://go.microsoft.com/fwlink/?linkid=525133
	sudo installer -pkg $temp/Office.pkg -target /

# XQuartz 
	wget --no-check-certificate -O $temp/XQuartz.dmg https://dl.bintray.com/xquartz/downloads/XQuartz-2.7.9.dmg
	yes | hdiutil attach -noverify -nobrowse -mountpoint $temp/mount $temp/XQuartz.dmg
	sudo installer -pkg $temp/mount/XQuartz.pkg -target /
	hdiutil detach $temp/mount

# Flash 
	curl https://fpdownload.macromedia.com/get/flashplayer/current/licensing/mac/install_flash_player_22_osx_pkg.dmg > $temp/Flash.dmg
	yes | hdiutil attach -noverify -nobrowse -mountpoint $temp/mount $temp/Flash.dmg
	sudo installer -pkg $temp/mount/Install\ Adobe\ Flash\ Player.pkg -target /
	hdiutil detach $temp/mount

# HP Printer Drivers
	wget --no-check-certificate -O $temp/HPDrivers.dmg http://support.apple.com/downloads/DL907/en_US/hpprinterdriver3.1.dmg
	yes | hdiutil attach -noverify -nobrowse -mountpoint $temp/mount $temp/HPDrivers.dmg
	sudo installer -pkg $temp/mount/HewlettPackardPrinterDrivers.pkg -target /
	hdiutil detach $temp/mount


# Ricoh Printer Drivers http://support.apple.com/downloads/DL1867/en_US/ricohprinterdrivers3.0.dmg

rm -r $temp

#diskutil verifyVolume /

exit 0
