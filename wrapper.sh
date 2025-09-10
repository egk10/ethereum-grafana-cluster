#!/bin/bash

# Wrapper script to set up proper environment for systemd user service
# This ensures X11 and other environment variables are properly set

# Set basic environment variables
export DISPLAY=:0
export XAUTHORITY=/home/egk/.Xauthority
export HOME=/home/egk
export USER=egk
export LOGNAME=egk
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus

# Source the user's bashrc if it exists to get additional environment
if [ -f /home/egk/.bashrc ]; then
    source /home/egk/.bashrc
fi

# Source the user's profile if it exists
if [ -f /home/egk/.profile ]; then
    source /home/egk/.profile
fi

# Change to the correct working directory
cd /home/egk/ethereum-grafana-cluster

# Execute the main script with the proper environment
exec ./start-persistent.sh
