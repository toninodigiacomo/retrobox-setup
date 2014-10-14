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
# Function used to add the excutable bits
#============================================================================================================================
function _addExecBits()
{
	chmod a+x "$1"
	if [ $? == 0 ]; then
		log -infos "Executable bits added to '$1'"
		log -infos "error\t\t= $?"
	else
		log -warning "The executable bits have not been added to '$1'"
		log -error "error\t\t= $?"
		clear
		exit 1
	fi
} # _addExecBits $sourceFilePath

#============================================================================================================================
#	Function used to copy a file from a folder to another folder
#============================================================================================================================
function _copy()
{
	cp "$1" "$2"
	if [ $? == 0 ]; then
		log -infos "Copied '$1' to '$2'"
		log -infos "error\t\t= $?"
	else
		log -warning "Failed to copy '$1' to '$2'"
		log -error "error\t\t= $?"
		clear
		exit 1
	fi
} # _copy $sourceFilePath $destinationFilePath

#============================================================================================================================
#	Function used to delete a file
#============================================================================================================================
function _delete()
{
	rm "$1"
	if [ $? == 0 ]; then
		log -infos "The file '$1' has been deleted correctly"
		log -infos "error\t\t= $?"
	else
		log -warning "Failed to delete the file '$1'"
		log -error "error\t\t= $?"
		clear
		exit 1
	fi
} # _delete $file

#============================================================================================================================
#	Function used to rename a file
#============================================================================================================================
function _rename()
{
	mv "$1" "$2"
	if [ $? == 0 ]; then
		log -infos "file renamed to '$2'"
		log -infos "error\t\t= $?"
	else
		log -warning "Failed to renamed '$1' to '$2'"
		log -error "error\t\t= $?"
		clear
		exit 1
	fi
} # _copy $source $destination

#============================================================================================================================
# Function used to add the excutable as a service
#============================================================================================================================
function _startupService()
{
	if [ -f $1 ]; then
		insserv "$1"
		if [ $? == 0 ]; then
			log -infos "'$1' has been added as a service"
			log -infos "error\t\t= $?"
		else
			log -warning "The file '$1' has not been added as a service"
			log -error "error\t\t= $?"
			clear
			exit 1
		fi
	else
		log -warning "The file '$1' does not exist"
		log -error "error\t\t= $?"
		clear
		exit 1
	fi
} # _startupService $sourceFilePath

#============================================================================================================================
#	START MAIN
#============================================================================================================================
function file() 
{
	log -infos "file\t\t---> $1"
	case $1 in
		-addExecBits)
			_addExecBits "$2";;
		-copy)
			_copy "$2" "$3";;
		-delete)
			_delete "$2";;
		-rename)
			_rename "$2" "$3";;
		-startupService)
			_startupService "$2";;
		*)
			clear
			echo $"Usage: file {-addExecBits|-copy|-delete|-rename|-startupService}"
			exit 1
			;;	
	esac
	log -infos "file\t\t<---"
}

#============================================================================================================================
#	END MAIN
#============================================================================================================================
