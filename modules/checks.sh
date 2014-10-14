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
#	Function controlling the disk space
#============================================================================================================================
function _diskspace() 
{
	__required=$1
	log -infos "__required\t= $__required"
	__available=$(df -P $ROOTDIR | tail -n1 | awk '{print $4}')
	log -infos "__available\t= $__available"
	__req=$(expr $__required / 1024)
	log -infos "__req\t\t= $__req"
	__avail=$(expr $__available / 1024)
	log -infos "__avail\t\t= $__avail"
	log -infos "Minimum recommended disk space necessary $__req MB"
	log -infos "$__avail MB available at $ROOTDIR"
	clear
	if [ "$__required" -le "$__available" ] || ask "Minimum recommended disk space ($__req MB) not available.\nTry 'sudo raspi-config' to resize partition to full size. Only $__avail MB available at $ROOTDIR continue anyway?"; then
		echo 0;
	else
		exit 1;
	fi
} # _diskspace $minDiskSpace

#============================================================================================================================
#	Function controlling if a package is installed
#============================================================================================================================
function _installpackage()
{
	__package=$1
	log -infos "__package\t\t= $__package"
	local __status=$(dpkg-query -W --showformat='${status}\n' $__package|grep "install ok installed")
	log -infos "$__package $__status"
	if [ "" == "$__status" ]; then
		log -infos "The package '$1' is not instaled"
		log -infos "Installation in progress ..."
		sudo apt-get --force-yes --yes install $__package
		if [ $? == 0 ]; then
			log -infos "The command ran succesfuly"
		else
			echo $?
		fi
	fi
} # _installpackage $package

#============================================================================================================================
#	Function controlling if sudo is used to run the script
#============================================================================================================================
function _sudo()
{
	if [ $(id -u) -ne 0 ]; then
		log -warning "Script must be run as root. Try 'sudo $0'\n"
		log -error "Exiting ..."
		exit 1
	fi
} # _sudo

#============================================================================================================================
#	START MAIN
#============================================================================================================================
function check() 
{
	log -infos "check\t\t---> $1"
	case $1 in
		-sudo)
			_sudo;;
		-installpackage)
			_installpackage $2;;
		-diskspace)
			_diskspace $2;;
		*)
			clear
			echo $"Usage: check {-diskspace|-installpackage|-sudo}"
			exit 1
			;;	
		esac
	log -infos "check\t\t<---"
}

#============================================================================================================================
#	END MAIN
#============================================================================================================================
