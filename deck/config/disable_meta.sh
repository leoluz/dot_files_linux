#! /bin/env bash

# Meta key with Mac keyboard layout is used a lot.
# This script disables the meta key to open the application launcher
# when pressed by mistake

kwriteconfig5 --file kwinrc --group ModifierOnlyShortcuts --key Meta ""
qdbus org.kde.KWin /KWin reconfigure 
