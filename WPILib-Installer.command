#!/bin/bash

# Quick and dirty installer for the WPI Libraries for FRC
# Double-clicking this file in Finder will execute the script in a Terminal window
# Put the WPILib*.tar.gz file in the same folder as this file or in the Downloads folder

# Joseph Jackson
# 4-Jan-2020
# FRC Team 3504, Girls of Steel, Pittsburgh, PA

# The working directory is set to the user's home directory, so change to the location of this file
scriptdir=`dirname "${BASH_SOURCE[0]}"`
cd "$scriptdir"
wpidir="$HOME"/wpilib/2020

# Remove last year's WPI directory or its backup, if either exists
if [ -d "$HOME"/frc2019 ] || [ -d "$HOME"/frc2019.old ]
then
    echo ""
    echo "Removing ~/frc2019 and ~/frc2019.old left from a previous installation"
    rm -rf "$HOME"/frc2019 "$HOME"/frc2019.old
fi

# Clean up stuff from 2017 or earlier since they were in the top level of ~/wpilib/
if [ -d "$HOME"/wpilib/[a-zA-Z]* ]
then
    echo ""
    echo "Removing 2017 and older WPI files from ~/wpilib/*"
    rm -rf "$HOME"/wpilib/[a-zA-Z]*
fi

# If a previous run of this script has left behind a backup directory, get rid of it
if [ -d "$wpidir".old ]
then
    echo ""
    echo "Removing $wpidir.old left from a previous installation"
    rm -rf "$wpidir".old
fi

# Set aside the current WPI directory if it exists
if [ -d "$wpidir" ]
then
    echo ""
    echo "Saving current $wpidir folder to $wpidir.old"
    mv "$wpidir" "$wpidir".old
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
echo "Extracting the WPILib files to $wpidir"
mkdir -p "$wpidir"
tar xzf "$tarball" -C "$wpidir"/
ls -ld "$wpidir"*

# Run the Tools Installer script
if [ -r "$wpidir"/tools/ToolsUpdater.py ]
then
    echo ""
    echo "Running tools installer: python $wpidir/tools/ToolsUpdater.py"
    python "$wpidir"/tools/ToolsUpdater.py
else
    echo ""
    echo "FAILED to locate $wpidir/tools/ToolsUpdater.py! Tools not installed!"
    exit 1
fi

# Install "git", included with Apple's Developer Command Line Tools
echo ""
echo "Installing Developer Command Line Tools from Apple"
xcode-select --install

# Install VS Code extensions
echo ""
echo "Installing Visual Studio Code extensions required for FRC"
code="/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"
"$code" --install-extension "$wpidir"/vsCodeExtensions/Cpp.vsix       2>&1 | grep -v DEP0005
"$code" --install-extension "$wpidir"/vsCodeExtensions/JavaLang.vsix  2>&1 | grep -v DEP0005
"$code" --install-extension "$wpidir"/vsCodeExtensions/JavaDeps.vsix  2>&1 | grep -v DEP0005
"$code" --install-extension "$wpidir"/vsCodeExtensions/JavaDebug.vsix 2>&1 | grep -v DEP0005
"$code" --install-extension "$wpidir"/vsCodeExtensions/WPILib.vsix    2>&1 | grep -v DEP0005

echo ""
echo "Don't forget to:"
echo "Shift-Command-P WPILIB: Set VS Code Java Home"
echo "Shift-Command-P WPILIB: Set Team Number"

echo ""
echo "Successfully installed WPILib*.tar.gz to $wpidir"
echo ""
