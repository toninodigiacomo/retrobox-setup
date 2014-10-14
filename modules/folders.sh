#!/bin/bash

#============================================================================================================================
# RetroBox-Setup - Shell script for initializing Raspberry Pi and configure different emulators.
#
# (c) Copyright 2014 Tonino Di Giacomo (tonino.digiacomo@gmail.com)
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
#	Function to create a directory
#============================================================================================================================
function _createfolder()
{
	if [ $(_exist "$1") != 0 ]; then
		mkdir -p "$1"
		echo "folder "$1" created"
		chown $user:$user "$1"
		if [ $(_exist "$1") != 0 ]; then
			echo "The Directory '$1' cannot be created !"
			checks -sudo
			exit 1
		fi
	fi
} # createfolder $dirPath

#============================================================================================================================
#	Function controlling if a directory exists
#============================================================================================================================
function _exist()
{
	if [ -d "$1" ]; then
		echo 0
	else
		echo 1
	fi
} # _exist $dirPath

#============================================================================================================================
#	Function used to move a folder to another folder
#============================================================================================================================
function _move() 
{
	if [ ! "$1" == "$2" ]; then
		log -infos "Moving '$1' to '$2'"
		mv -v -f $1/* $2
		rm -rf "$1"
	else
		log -warning "Source folder '$1' equals '$2'"
	fi
} # _move $src $dest

#============================================================================================================================
#	Function used to delete a folder
#============================================================================================================================
function _remove() 
{
	if [ $(_exist "$1") == 0 ]; then
		rm -rf "$1"
		if [ $? == 0 ]; then
			log -infos "Folder '$1' deleted"
		else
			log -warning "Failed to delete '$1' to '$2'"
			log -error "Error\t\t= $?"
			clear
			exit 1
		fi
	else
		log -warning "The folder '$1' doesn't exist !"
	fi
} # _remove $dirPath

#============================================================================================================================
#	START MAIN
#============================================================================================================================
function folder() 
{
	log -infos "folder\t\t---> $1"
	case $1 in
		-createfolder)
			_createfolder $2;;
		-exist)
			_exist $2;;
		-move)
			_move $2 $3;;
		-remove)
			_remove;;
		*)
			clear
			echo $"Usage: folder {-createfolder|-exist|-move|-remove}"
			exit 1
			;;	
	esac
	log -infos "folder\t\t<---"
}

#============================================================================================================================
#	END MAIN
#============================================================================================================================
