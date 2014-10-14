#!/bin/bash

#============================================================================================================================
#	RetroBox-Setup - Shell script for initializing Raspberry Pi and configure different emulators.
#
#	(c) Copyright 2014  Tonino Di Giacomo (tonino.digiacomo@gmail.com)
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
#		helpers.sh
#		logs.sh
#		text.sh
#		
#	Script:
#	-------
#		rbs_aspectratio.sh
#		rbs_foldertree.sh
#		rbs_openlogs.sh
#		rbs_tweaks.sh
#		rbs_updatepackages.sh
#----------------------------------------------------------------------------------------------------------------------------
#	Raspberry Pi is a trademark of the Raspberry Pi Foundation.
#============================================================================================================================

#============================================================================================================================
#	START MAIN
#============================================================================================================================

LOGFILE=""

SCRIPTDIR=$(dirname $0)
SCRIPTDIR=$(cd $SCRIPTDIR && pwd)

ROOTDIR="/opt/retrobox-setup"
LOGDIR="$ROOTDIR/log"

source $SCRIPTDIR/modules/checks.sh
source $SCRIPTDIR/modules/files.sh
source $SCRIPTDIR/modules/folders.sh
source $SCRIPTDIR/modules/helpers.sh
source $SCRIPTDIR/modules/logs.sh
source $SCRIPTDIR/modules/text.sh

source $SCRIPTDIR/rbs/sub/rbs_aspectratio.sh
source $SCRIPTDIR/rbs/rbs_foldertree.sh
source $SCRIPTDIR/rbs/rbs_installemulators.sh
source $SCRIPTDIR/rbs/rbs_openlogs.sh
source $SCRIPTDIR/rbs/rbs_tweaks.sh
source $SCRIPTDIR/rbs/rbs_updatepackages.sh

folder -createfolder $LOGDIR
log -createfile $LOGDIR

if [ ! "$SCRIPTDIR" == "$ROOTDIR" ]; then
	folder -move "$SCRIPTDIR" "$ROOTDIR"
	clear
	echo "Sources have been moved to $ROOTDIR."
	echo "Change directory to $ROOTDIR with 'cd $ROOTDIR' and run the command './retrobox-setup.sh'"
	exit 1
fi
check -diskspace 8000000
check -installpackage dialog

while true; 
do
	__cmd=(dialog \
		--backtitle "Raspberry Pi - RetroBox configuration." \
		--clear \
		--menu "Select the configuration to perform" \
		12 48 7)
	__options=(\
		"1"	"Tweak the system" \
		"2"	"Create folder tree" \
		"3" "Update linux packages" \
		"4" "Install emulators" \
		"L" "Open logs file"
		)
	__choices=$("${__cmd[@]}" "${__options[@]}" 2>&1 >/dev/tty)
	if [ "$__choices" != "" ]; then
		case $__choices in
			1) rbs_tweaks;;
			2) rbs_foldertree;;
			3) rbs_updatepackages;;
			4) rbs_installemulators;;
			L) rbs_openlogs;;
		esac
	else
		clear
		break
	fi
done

#============================================================================================================================
#	END MAIN
#============================================================================================================================
