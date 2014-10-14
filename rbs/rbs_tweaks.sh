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
#		checks.sh
#		files.sh
#		folders.sh
#		logs.sh
#----------------------------------------------------------------------------------------------------------------------------
#	Raspberry Pi is a trademark of the Raspberry Pi Foundation.
#============================================================================================================================

#============================================================================================================================
#	START MAIN
#============================================================================================================================

function rbs_tweaks()
{
	log -infos "Entering in Tweak Menu ..."
	__cmd=(dialog \
		--backtitle "Raspberry Pi - RetroBox configuration." \
		--menu "Select the configuration to perform" \
		12 48 7\
	)
	__options=(\
		"1" "Install splashscreen" \
		"2" "Define the aspect ratio" \
		"3" "Delete python games"
	)
	__choices=$("${__cmd[@]}" "${__options[@]}" 2>&1 >/dev/tty)
	if [ "$__choices" != "" ]; then
		case $__choices in
			1) 
				check -installpackage fbi
				file -copy $ROOTDIR/img/splash.png /etc/splash.png
				file -copy $ROOTDIR/bin/splashscreen /etc/init.d/splashscreen
				file -addExecBits /etc/init.d/splashscreen
				file -startupService /etc/init.d/splashscreen
				;;
			2)
				rbs_aspectRatio;;
			3)
				folder -remove "/home/pi/python_games";;
		esac
	else
		clear
		break
	fi
}

#============================================================================================================================
#	END MAIN
#============================================================================================================================
