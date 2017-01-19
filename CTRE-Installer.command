#!/bin/sh -x
# Quick and dirty installer for the CTRE Java extensions for FRC
# Joseph Jackson
# 19-Jan-2017
mkdir -p "$HOME"/wpilib/user/java/lib
mkdir -p "$HOME"/wpilib/user/java/docs
rm -f "$HOME"/wpilib/user/java/lib/libTalonSRXLib.so
rm -f "$HOME"/wpilib/user/java/lib/TalonSRXLibJava.jar
zipfile=`ls -1tr ~/Downloads/CTRE_FRCLibs_*.zip | tail -1`
if [ -z "$zipfile" ]
then
  echo "Failed to locate latest CTRE FRCLibs. Did you download them to your ~/Downloads directory yet?"
  exit 1
fi
unzip "$zipfile" 'java/docs/*' -d "$HOME"/wpilib/user/
unzip "$zipfile" 'java/lib/*'  -d "$HOME"/wpilib/user/
chmod 755 $HOME/wpilib/user/java/lib/*
echo "Successfully installed CTRE libraries for FRC Java"
