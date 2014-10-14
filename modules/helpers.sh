#!/bin/bash

#============================================================================================================================
# RetroBox-Setup - Shell script for initializing Raspberry Pi and configure different emulators.
#
# (c) Copyright 2014 Tonino Di Giacomo (tonino.digiacomo@gmail.com)
#----------------------------------------------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------------------------------------------
# Permission to use, copy, modify and distribute RetroPie-Setup in both binary and source form, for non-commercial.
# purposes, is hereby granted without fee, providing that this license information and copyright notice appear with
# all copies and any derived work.
# This script is provided 'as-is', without any express or implied warranty. In no event shall the authors be held
# liable for any damages arising from the use of this software.
#----------------------------------------------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------------------------------------------
# This script is free for PERSONAL USE only. Commercial users should seek permission of the copyright holders first.
# Commercial use includes charging money for this script or software derived from this script.
# The copyright holders request that bug fixes and improvements to the code should be forwarded to them so everyone can
# benefit from the modifications in future versions.
#----------------------------------------------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------------------------------------------
# Raspberry Pi is a trademark of the Raspberry Pi Foundation.
#============================================================================================================================

#============================================================================================================================
# Function permetting to generate questions
#============================================================================================================================
function ask()
{
	echo -e -n "$@" '[y/n] '; read ans
	case "$ans" in
		y*|Y*)
		return 0;;
	*)
		return 1;;
	esac
}

#============================================================================================================================
# Function permetting to display a dialog box for debuging
#============================================================================================================================
function dialogbox()
{
	dialog	--title "Debugging Message" \
					--clear \
					--yesno "$1\n Continue?" 10 30
	case $? in
		1)
			clear
			exit 0
			;;
	esac
}
