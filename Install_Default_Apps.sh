#!/bin/sh

temp=$TMPDIR$(uuidgen)
mkdir -p $temp/mount

# wget
	printf "\033[1;31mInstalling Rudix & wget \033[0m\n"
	curl -s https://raw.githubusercontent.com/rudix-mac/rpm/2015.10.20/rudix.py | sudo python - install rudix
	sudo rudix install wget

# Function install .app inside DMG Input: Filename.dmg "URL"
	install_app ()	{
		printf "\033[1;31mInstalling $1 \033[0m\n"
		wget --tries=0 --read-timeout=20 --no-check-certificate -O $temp/$1 $2
		yes | hdiutil attach -noverify -nobrowse -mountpoint $temp/mount $temp/$1
		cp -r $temp/mount/*.app /Applications
		hdiutil detach $temp/mount
		}

# Function install_app but using curl
	install_app_curl ()	{
		printf "\033[1;31mInstalling $1 \033[0m\n"
		curl -m 60 $2 > $temp/$1
		yes | hdiutil attach -noverify -nobrowse -mountpoint $temp/mount $temp/$1
		cp -r $temp/mount/*.app /Applications
		hdiutil detach $temp/mount
		}

# Function install .pkg inside DMG Input: Filename.dmg "URL" Package.pkg
	install_dmg_pkg () {
		printf "\033[1;31mInstalling $1 \033[0m\n"
		wget --tries=0 --read-timeout=20 --no-check-certificate -O $temp/$1 $2
		yes | hdiutil attach -noverify -nobrowse -mountpoint $temp/mount $temp/$1
		sudo installer -pkg $temp/mount/$3 -target /
		hdiutil detach $temp/mount
		}

# Chrome
	install_app_curl Chrome.dmg "https://dl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg"

# VLC
	install_app VLC.dmg "https://get.videolan.org/vlc/2.2.4/macosx/vlc-2.2.4.dmg"

# Firefox	
	install_app Firefox.dmg "http://download.mozilla.org/?product=firefox-latest&os=osx&lang=en-US"

# Malware Bytes
	install_app MalwareBytes.dmg "https://store.malwarebytes.com/342/purl-mbamm-dl"

# Silverlight
	install_dmg_pkg Silverlight.dmg "http://go.microsoft.com/fwlink/?LinkID=229322" silverlight.pkg

# XQuartz 
	install_dmg_pkg XQuartz.dmg "https://dl.bintray.com/xquartz/downloads/XQuartz-2.7.9.dmg" XQuartz.pkg 

# HP Printer Drivers
	install_dmg_pkg HPDrivers.dmg "http://support.apple.com/downloads/DL907/en_US/hpprinterdriver3.1.dmg" HewlettPackardPrinterDrivers.pkg

# Ricoh Printer Drivers 
	install_dmg_pkg RicohDrivers.dmg "http://support.apple.com/downloads/DL1867/en_US/ricohprinterdrivers3.0.dmg" RicohPrinterDrivers.pkg

# Flash Latest version using rtrouton script
	printf "\033[1;31mInstalling Adobe Flash \033[0m\n"
	curl https://raw.githubusercontent.com/rtrouton/rtrouton_scripts/master/rtrouton_scripts/install_latest_adobe_flash_player/install_latest_adobe_flash_player.sh | sudo bash
	
# Java 8 Latest version using rtrouton script
	printf "\033[1;31mInstalling Java 8  \033[0m\n"
	curl https://raw.githubusercontent.com/rtrouton/rtrouton_scripts/master/rtrouton_scripts/install_latest_oracle_java_8_jdk/install_latest_oracle_java_jdk_8.sh | sudo bash

# Office 2016 for O365 Activation. Link from http://macadmins.software/
	printf "\033[1;31mInstalling Office 2016 for O365 \033[0m\n"
	wget --tries=0 --read-timeout=20 --no-check-certificate -O $temp/Office.pkg http://go.microsoft.com/fwlink/?linkid=525133
	sudo installer -pkg $temp/Office.pkg -target /
	
rm -r $temp

# Run First Aid to confirm no permissions problems
diskutil verifyVolume /

exit 0
