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
#		logs.sh
#----------------------------------------------------------------------------------------------------------------------------
#	Raspberry Pi is a trademark of the Raspberry Pi Foundation.
#============================================================================================================================

#============================================================================================================================
#	START MAIN
#============================================================================================================================

#============================================================================================================================
#	START MAIN
#============================================================================================================================

function rbs_openlogs()
{
	log -infos "Listing files in log folder ..."
	__list=""
	i=0
	j=1
	for __logpath in "$LOGDIR"/*;	do
		__logfile=${__logpath##*/}
		__arr[i]=$__logpath
		log -infos "Array[$i]\t\t= ${__arr[i]}"
		__list="$__list $j $__logfile"
		i=$((i+1))
		j=$((j+1))
	done
	echo ${__arr[i]}
	__cmd=(dialog \
		--backtitle "Raspberry Pi - RetroBox configuration." \
		--clear \
		--menu "Select log file to open" \
		12 48 7)
	__options=($__list)
	__choices=$("${__cmd[@]}" "${__options[@]}" 2>&1 >/dev/tty)
	if [ $__choices != "" ]; then
		log -infos "Select\t\t= $__choices"
		__choices=$((__choices-1))
		log -infos "Array\t\t= $__choices"
		log -infos "Opening ${__arr[$__choices]}"
		nano ${__arr[$__choices]}
	else
		clear
	fi
}

#============================================================================================================================
#	END MAIN
#============================================================================================================================
