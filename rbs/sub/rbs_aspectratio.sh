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
#		logs.sh
#		text.sh
#----------------------------------------------------------------------------------------------------------------------------
#	Raspberry Pi is a trademark of the Raspberry Pi Foundation.
#============================================================================================================================

#============================================================================================================================
#	Function used to write the aspect ratio configuration
#============================================================================================================================
function aspectRatio()
{
	__choice=$1
	log -infos "__choice\t\t= $__choice"
	__file=/boot/config.txt
	log -infos "__file\t\t= $__file"
	if grep -q 'sdtv_aspect' $__file; then
		log -infos "Found $(grep sdtv_aspect $__file)"
		sed -i '/sdtv_aspect/c\'$__choice $__file
		if [ $? != 0 ]; then
			exitOnError "$__choice" $__file $?
		else
			log -infos "error\t\t= $?"
		fi
	else
	log -infos "__file\t\t= $__file"
		sed -i '$a '$__choice $__file
		if [ $? != 0 ]; then
			exitOnError "$1" $__file $?
		fi
	fi
} # aspectRatio $string

#============================================================================================================================
#	Function used in case of breaking error
#============================================================================================================================
function exitOnError
{
	log -warning "Failed to write '$1' in '$2'"
	log -error "error\t\t= $3"
	clear
	echo "exit $3"
} # exitOnError $message $file $exitCode

#============================================================================================================================
#	START MAIN
#============================================================================================================================
function rbs_aspectRatio()
{
	log -infos "Entering in Aspect Ratio menu ..."
	__cmd=(dialog\
		--backtitle "Raspberry Pi - RetroBox configuration." \
		--radiolist "Select the configuration to perform" \
		12 48 7\
	)
	__options=(\
		"1" "sdtv_aspect=1  4:3" off\
		"2" "sdtv_aspect=2  14:9" off\
		"3" "sdtv_aspect=3  16:9" on\
	)
	__choices=$("${__cmd[@]}" "${__options[@]}" 2>&1 >/dev/tty)
	if [ "$__choices" != "" ]; then
		case $__choices in
			1)
				aspectRatio "sdtv_aspect=1";;
			2)
				aspectRatio "sdtv_aspect=2";;
			3)
				aspectRatio "sdtv_aspect=3";;
			esac
		else
			clear
		break
	fi
}

#============================================================================================================================
#	END MAIN
#============================================================================================================================
