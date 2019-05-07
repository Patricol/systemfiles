#!/bin/sh
# autostart vncconfig so that the clipboard works (vncconfig exits immediately in non-VNC sessions).
vncconfig -nowin &
