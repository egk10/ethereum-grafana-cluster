#!/bin/bash

# 🚀 Persistent Living Room Display Starter
# Uses nohup to keep processes running after terminal closes

echo "🚀 Starting Persistent Living Room Display..."

# Kill any existing processes
pkill firefox
pkill -f super-simple-switcher

# Wait a moment
sleep 2

# Start Grafana in Firefox kiosk mode
echo "📊 Starting Grafana dashboard..."
DISPLAY=:0 nohup firefox --kiosk http://localhost:3000/dashboards > grafana.log 2>&1 &

# Wait for first window to load
sleep 5

# Start Nethermind in new window
echo "🔥 Starting Nethermind UI..."
# Try the remote URL first, fallback to local Prometheus if not available
if curl -s --max-time 5 http://100.67.5.3:8545 > /dev/null; then
    DISPLAY=:0 nohup firefox --new-window --kiosk http://100.67.5.3:8545 > nethermind.log 2>&1 &
else
    echo "⚠️  Nethermind URL not accessible, using local Prometheus instead"
    DISPLAY=:0 nohup firefox --new-window --kiosk http://localhost:9091 > prometheus.log 2>&1 &
fi

# Wait for second window to load
sleep 5

# Wait for Firefox windows to be fully ready
echo "⏳ Waiting for Firefox windows to be ready..."
sleep 10

# Start auto-switching (persistent)
echo "🔄 Starting persistent auto-switcher..."
cd /home/egk/ethereum-grafana-cluster
nohup ./super-simple-switcher.sh > switcher.log 2>&1 &

echo "✅ Persistent living room display started!"
echo "📋 Switching every 5 minutes between Grafana and Nethermind"
echo "💡 Processes will continue running even after closing terminal"
echo ""
echo "To check status:"
echo "  ps aux | grep -E '(firefox|super-simple-switcher)'"
echo ""
echo "To stop:"
echo "  pkill firefox && pkill -f super-simple-switcher"
