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
# Try the remote URL first, fallback to local Prometheus if not available
if curl -s --max-time 5 http://minipcamd4.velociraptor-scylla.ts.net:26060/ > /dev/null; then
    DISPLAY=:0 firefox --new-window --kiosk http://minipcamd4.velociraptor-scylla.ts.net:26060/ &
else
    echo "⚠️  Nethermind URL not accessible, using local Prometheus instead"
    DISPLAY=:0 firefox --new-window --kiosk http://localhost:9091/ &
fi

# Wait for second window to load
sleep 5

# Start auto-switching
echo "🔄 Starting auto-switcher..."
./super-simple-switcher.sh

echo "✅ Living room display started!"
echo "📋 Switching every 5 minutes between Grafana and Nethermind"
