#!/bin/bash

# Quick and dirty installer for the WPI Libraries for FRC
# Double-clicking this file in Finder will execute the script in a Terminal window
# Put the WPILib*.tar.gz file in the same folder as this file or in the Downloads folder

# Joseph Jackson
# 20-Jan-2019
# FRC Team 3504, Girls of Steel, Pittsburgh, PA

# The working directory is set to the user's home directory, so change to the location of this file
scriptdir=`dirname "${BASH_SOURCE[0]}"`
cd "$scriptdir"

# If a previous run of this script has left behind an ~/frc2019.old/ directory, get rid of it
if [ -d "$HOME"/frc2019.old ]
then
    echo ""
    echo "Removing ~/frc2019.old left from a previous installation"
    rm -rf "$HOME"/frc2019.old
fi

# Set aside the current frc2019 directory if it exists
if [ -d "$HOME"/frc2019 ]
then
    echo ""
    echo "Saving current ~/frc2019 folder to ~/frc2019.old"
    mv "$HOME"/frc2019 "$HOME"/frc2019.old
fi

# Find the WPILib tar file by looking in the same directory as this script and the ~/Downloads folder
# Choose the newest one by sorting the output of "ls" by time, in reverse order, and taking the last
# Redirect stderr to avoid an error message when one of the locations doesn't contain a zip file
tarball=`ls -1tr {.,~/Downloads}/WPILib_Mac-*.tar.gz 2> /dev/null | tail -1`
if [ -z "$tarball" ]
then
  echo ""
  echo "Failed to locate WPILib_Mac-*.tar.gz in ~/Downloads and $scriptdir"
  echo "Did you download it to one of these locations yet?"
  echo ""
  exit 1
fi

# Extract the WPILib tar file
echo ""
echo "Extracting the WPILib files to ~/frc2019"
mkdir -p "$HOME"/frc2019
tar xzf "$tarball" -C "$HOME"/frc2019/
ls -ld "$HOME"/frc2019*

echo ""
echo "Successfully installed WPILib*.tar.gz to ~/frc2019"
echo ""
