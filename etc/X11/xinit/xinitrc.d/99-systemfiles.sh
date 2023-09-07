#!/bin/sh

source /usr/local/bin/start-ssh-agent

# autostart vncconfig so that the clipboard works (vncconfig exits immediately in non-VNC sessions).
vncconfig -nowin &
