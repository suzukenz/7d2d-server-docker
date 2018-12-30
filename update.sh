#!/bin/sh
cd "$STEAMCMD_ROOT" || exit
./steamcmd.sh +runscript "$HOME/install.txt"
