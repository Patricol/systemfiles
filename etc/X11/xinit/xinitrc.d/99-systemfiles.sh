#!/bin/sh

# https://wiki.archlinux.org/index.php/GNOME/Keyring#xinitrc_method
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# autostart vncconfig so that the clipboard works (vncconfig exits immediately in non-VNC sessions).
vncconfig -nowin &
