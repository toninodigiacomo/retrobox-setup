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
#----------------------------------------------------------------------------------------------------------------------------
# Raspberry Pi is a trademark of the Raspberry Pi Foundation.
#============================================================================================================================

#============================================================================================================================
#	Function used to create the log file
#============================================================================================================================
function _createfile()
{
	LOGFILE="$1/output_`date +%y%m%d`_`date +%H%M%S`.log"																	# Nice time display for log file
	#trap "rm -f $LOGFILE" 0 1 2 5 15
} # _create $folderPath

#============================================================================================================================
#	START MAIN
#============================================================================================================================
function log()
{
	LOGFILE=$LOGFILE
	__date=`date +%y-%m-%d`
	__time=`date +%H:%M:%S`
	case $1 in
		-createfile)
			_createfile $2
			__logType="--  INFOS  --"
			__log="$__date $__time $__logType $LOGFILE"
			log -infos "$LOGFILE"
			;;
		-infos)
			__logType="--  INFOS  --";;
		-warning)
			__logType="-- WARNING --";; 		
		-error)
			__logType="--  ERROR  --";;
		*)
			__logType="--         --";;
	esac
	if [ "$2" != "" ]; then
		__log="$__date $__time $__logType $2"
		echo -e $__log >> $LOGFILE
	else
		echo $__date $__time $__logType "EMPTY LINE" >> $LOGFILE
	fi
}

#============================================================================================================================
#	END MAIN
#============================================================================================================================
