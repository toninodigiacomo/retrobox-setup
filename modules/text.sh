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
#----------------------------------------------------------------------------------------------------------------------------
#	Raspberry Pi is a trademark of the Raspberry Pi Foundation.
#============================================================================================================================

#============================================================================================================================
#	Function to append a new line in a text file
#============================================================================================================================
function _lineAppendEnd()
{
	sed -i '$a '$1 $2
} # lineAppend $text $file

#============================================================================================================================
#	Function to retrieve the line number
#============================================================================================================================
function _lineNumber()
{
	if [ grep $1 $2 ]; then
		__linenumb=$(grep -n $1 $2 | cut -d: -f1)
		echo $__linenumb
	else
		echo -1
	fi
} # lineNumber $text $file

#============================================================================================================================
#	Function to replace a line with another line in a textfile
#============================================================================================================================
function _lineReplaceWith()
{
	__lineOri="$1"
	__lineNew="$2"
	__file="$3"
	grep -Fx "$__lineOri" "$__file"
	if [ $? == 0 ]; then
		sed -i 's|'$__lineOri'|'$__lineNew'|g' $__file
	else
		echo $?
	fi
} # lineReplaceWith $ori $new $file

#============================================================================================================================
#	START MAIN
#============================================================================================================================
function text()
{
	log -infos "text\t\t---> $1"
	case $1 in
		-lineAppendStart)
			# To Do
			;;
		-lineAppendNumber)
			# To Do
			;;
		-lineAppendEnd)
			if [ -n $2 ] && [ -n $3 ]; then
				_lineAppendEnd $2 $3
			else
				echo -1
			fi
			;;
		-lineNumber)
			if [ -n $2 ] && [ -n $3 ]; then
				echo $(_lineNumber $2 $3)
			else
				echo -1
			fi
			;;
		-lineReplaceWith)
			if [ -n $2 ] && [ -n $3 ] && [ -n $4 ]; then
				_lineReplaceWith $2 $3 $4
			else
				echo -1
			fi
			;;
		*)
			clear
			echo $"Usage: $0 {-lineAppendStart|-lineAppendNumber|-lineAppendEnd|-lineNumber|-lineReplaceWith}"
			exit 1
			;;	
		esac
	log -infos "text\t\t<---"
}

#============================================================================================================================
#	END MAIN
#============================================================================================================================
