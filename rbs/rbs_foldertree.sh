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
#		folder.sh
#		logs.sh
#		text.sh
#----------------------------------------------------------------------------------------------------------------------------
#	Raspberry Pi is a trademark of the Raspberry Pi Foundation.
#============================================================================================================================

#============================================================================================================================
#============================================================================================================================
#	START MAIN
#============================================================================================================================

#============================================================================================================================
#	START MAIN
#============================================================================================================================

function rbs_foldertree()
{
	clear
	log -infos "Entering in Folder Tree configuration ..."
	__file="$ROOTDIR/bin/foldertree.txt"
	while IFS=, read __state __directory || [[ -n $line ]]; do
		if [ "$__state" == "0" ]; then
			log -infos "__state\t\t= $__state"
			log -infos "__directory\t= $__directory"
			__folder="/home/pi/$__directory"
			log -infos "__folder\t\t= $__folder"
			log -infos "Create folder: $__folder" 
			folder -createfolder $__folder
			log -infos "error\t\t= $?"
			log -infos "Replace line: '$__state,$__directory' '1,$__directory' '$__file'"
			text -lineReplaceWith "$__state,$__directory" "1,$__directory" "$__file"
			log -infos "error\t\t= $?"
		elif [ "$__state" == "1" ]; then
			log -warning "__state\t\t= $__state"
			log -warning "The folder '$__directory' exists already !"
		fi
	done < $__file
}

#============================================================================================================================
#	END MAIN
#============================================================================================================================
