#!/bin/bash

# Quick and dirty installer for the CTRE Java extensions for FRC
# Double-clicking this file in Finder will execute the script in a Terminal window
# Put the CTRE zip file in the same folder as this file or in the Downloads folder

# Joseph Jackson
# 4-Jan-2020
# FRC Team 3504, Girls of Steel, Pittsburgh, PA

# The working directory is set to the user's home directory, so change to the location of this file
scriptdir=`dirname "${BASH_SOURCE[0]}"`
cd "$scriptdir"
wpidir="$HOME"/wpilib/2020

# Confirm the WPILib directory exists before continuing with this installation
if [ ! -d "$wpidir" ]
then
    echo ""
    echo ""
    echo ""
    echo "FAILED to install CTRE Phoenix Library!"
    echo "Install the WPILib package to $wpidir before installing the CTRE Phoenix Library"
    echo ""
    echo ""
    echo ""
    exit 1
fi

# Create the destination directories if they don't already exist
mkdir -p "$wpidir"/vendordeps
mkdir -p "$wpidir"/maven/com/ctre

# Remove old versions, if they exist
# Use verbose to show what was removed
echo ""
echo "Removing any old versions of the CTRE libraries:"
rm -fv "$wpidir"/vendordeps/Phoenix.json
rm -rfv "$wpidir"/maven/com/ctre/*

# Find the CTRE zip file by looking in the same directory as this script and the ~/Downloads folder
# Choose the newest one by sorting the output of "ls" by time, in reverse order, and taking the last
# Redirect stderr to avoid an error message when one of the locations doesn't contain a zip file
zipfile=`ls -1tr {.,~/Downloads}/CTRE_Phoenix_FRC_nonWindows_*.zip 2> /dev/null | tail -1`
if [ -z "$zipfile" ]
then
  echo ""
  echo "Failed to locate CTRE_Phoenix_FRC_nonWindows*.zip in ~/Downloads and $scriptdir"
  echo "Did you download them to one of these locations yet?"
  echo ""
  exit 1
fi

# Extract the Java libraries and docs from the CTRE zip file, overwriting any that already exist
echo ""
echo "Installing the CTRE vendor dependency file and libraries:"
unzip -o "$zipfile" 'vendordeps/*' -d "$wpidir"/
unzip -o "$zipfile" 'maven/com/ctre/*'  -d "$wpidir"/

echo ""
echo "Successfully installed CTRE Phoenix libraries for FRC Java"
echo ""
