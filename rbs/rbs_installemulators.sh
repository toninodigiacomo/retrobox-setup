#!/bin/bash

#============================================================================================================================
#	RetroBox-Setup - Shell script for initializing Raspberry Pi and configure different emulators.
#
#	(c) Copyright 2014 Tonino Di Giacomo (tonino.digiacomo@gmail.com)
#----------------------------------------------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------------------------------------------
#	Permission to use, copy, modify and distribute RetroPie-Setup in both binary and source form, for non-commercial.
#	purposes, is hereby granted without fee, providing that this license information and copyright notice appear with 
#	all copies and any derived work.
#	This script is provided 'as-is', without any express or implied warranty. In no event shall the authors be held
#	liable for any damages arising from the use of this software.
#----------------------------------------------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------------------------------------------
#	This script is free for PERSONAL USE only. Commercial users should seek permission of the copyright holders first. 
#	Commercial use includes charging money for this script or software derived from this script. 
#	The copyright holders request that bug fixes and improvements to the code should be forwarded to them so everyone can 
#	benefit from the modifications in future versions. 
#----------------------------------------------------------------------------------------------------------------------------
#	Dependencies:
#	-------------
#		files.sh
#		logs.sh
#----------------------------------------------------------------------------------------------------------------------------
#	Raspberry Pi is a trademark of the Raspberry Pi Foundation. 
#============================================================================================================================

#============================================================================================================================
# Emulator: HATARI
#============================================================================================================================
function _HATARI()
{
	clear
	__home="/home/pi"
	__dev="$__home/Development"
	__hatari="$__dev/hatari-1.8.0"
	__src="$__hatari/src"
	log -infos "__home\t\t= $__home"
	log -infos "__dev\t\t= $__dev"
	log -infos "__hatari\t\t= $__hatari"
	log -infos "__src\t\t= $__src"
	cd $__dev
	wget http://download.tuxfamily.org/hatari/1.8.0/hatari-1.8.0.tar.bz2
	tar xjf hatari-1.8.0.tar.bz2
	file -delete hatari-1.8.0.tar.bz2
	"$__hatari/configure"
	make
	file -copy "$__src/hatari" "$__home/Emulators/Hatari/hatari"
	cd "$__home/Roms/Computers/AtariST"
	log -infos "Copying ROMs"
	wget https://googledrive.com/host/0B1nXGwpgUL_-ZnFqUG9KNTh3LUE
	file -rename 0B1nXGwpgUL_-ZnFqUG9KNTh3LUE AtariST.zip
	unzip AtariST.zip
	file -delete AtariST.zip
	cd $__home
} # _HATARI

#============================================================================================================================
#	START MAIN
#============================================================================================================================

function rbs_installemulators()
{
	log -infos "Entering in Install Emulators Menu ..."
	__cmd=(dialog \
		--backtitle "Raspberry Pi - RetroBox configuration." \
		--menu "Select the operation to perform" \
		12 48 7\
	)
	__options=(\
		"1" "Install Hatari "
	)
	__choices=$("${__cmd[@]}" "${__options[@]}" 2>&1 >/dev/tty)
	if [ "$__choices" != "" ]; then
		log -infos "__choices\t\t= $__choices"
		case $__choices in
			1)
				_HATARI;;
		esac
	else
		clear
		break
	fi
}

#============================================================================================================================
#	END MAIN
#============================================================================================================================
