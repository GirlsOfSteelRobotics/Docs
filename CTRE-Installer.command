#!/bin/bash                                                                                                                         

# Quick and dirty installer for the CTRE Java extensions for FRC                                                                    
# Double-clicking this file in Finder will execute the script in a Terminal window                                                  
# Put the CTRE zip file in the same folder as this file, perhaps in the Downloads folder                                            

# Joseph Jackson                                                                                                                    
# 6-Jan-2018                                                                                                                        
# FRC Team 3504, Girls of Steel, Pittsburgh, PA                                                                                     

# The working directory is set to the user's home directory, so change to the location of this file                                 
scriptdir=`dirname "${BASH_SOURCE[0]}"`
cd "$scriptdir"

# Create the destination directories, if they don't already exist                                                                   
mkdir -p "$HOME"/wpilib/user/java/docs
mkdir -p "$HOME"/wpilib/user/java/lib

# Remove old or really old versions, if they exist                                                                                  
# Use verbose to show what was removed (not for docs since it has many, many files)                                                 
echo ""
echo "Removing any old versions of the CTRE libraries:"
rm -fv "$HOME"/wpilib/user/java/lib/TalonSRXLibJava.jar
rm -fv "$HOME"/wpilib/user/java/lib/libTalonSRXLib.so
rm -fr "$HOME"/wpilib/user/java/docs/CTRLib
rm -fv "$HOME"/wpilib/user/java/lib/CTRLib.jar
rm -fv "$HOME"/wpilib/user/java/lib/libCTRLibDriver.so
rm -fv "$HOME"/wpilib/user/java/lib/libCTRLibDriver.so.debug

# Find the CTRE zip file by looking in the same directory as this script and the ~/Downloads folder                                 
# Choose the newest one by sorting the output of "ls" by time, in reverse order, and taking the last                                
# Redirect stderr to avoid an error message when one of the locations doesn't contain a zip file                                    
zipfile=`ls -1tr {.,~/Downloads}/CTRE_Phoenix_FRCLibs_*.zip 2> /dev/null | tail -1`
if [ -z "$zipfile" ]
then
  echo "Failed to locate latest CTRE_Phoenix_FRCLibs in ~/Downloads and $scriptdir"
  echo "Did you download them to one of these locations yet?"
  exit 1
fi

# Extract the Java libraries and docs from the CTRE zip file, overwriting any that already exist                                    
echo ""
echo "Installing the CTRE libraries and documentation:"
unzip -o "$zipfile" 'java/docs/*' -d "$HOME"/wpilib/user/
unzip -o "$zipfile" 'java/lib/*'  -d "$HOME"/wpilib/user/
chmod 755 $HOME/wpilib/user/java/lib/*

echo ""
echo "Successfully installed CTRE libraries for FRC Java"
