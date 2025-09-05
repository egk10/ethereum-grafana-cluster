#!/bin/bash

# 🚀 Living Room Display Auto-Start
# Starts Firefox windows and auto-switching

echo "🚀 Starting Living Room Display..."

# Kill any existing processes
pkill firefox
pkill -f super-simple-switcher

# Wait a moment
sleep 2

# Start Grafana in Firefox kiosk mode
echo "📊 Starting Grafana dashboard..."
DISPLAY=:0 firefox --kiosk http://localhost:3000/dashboards &

# Wait for first window to load
sleep 5

# Start Nethermind in new window
echo "🔥 Starting Nethermind UI..."
DISPLAY=:0 firefox --new-window --kiosk http://minipcamd4.velociraptor-scylla.ts.net:26060/ &

# Wait for second window to load
sleep 5

# Start auto-switching
echo "🔄 Starting auto-switcher..."
./super-simple-switcher.sh

echo "✅ Living room display started!"
echo "📋 Switching every 5 minutes between Grafana and Nethermind"
