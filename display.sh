#!/bin/bash

# 🎮 Quick Display Control Aliases
# Easy shortcuts for common display control commands

cd /home/egk/ethereum-grafana-cluster

case $1 in
    "p")
        ./control-display.sh pause
        ;;
    "r")
        ./control-display.sh resume
        ;;
    "s")
        ./control-display.sh status
        ;;
    "start")
        echo "🚀 Starting systemd service..."
        systemctl --user start living-room-switcher.service
        echo "✅ Service started."
        ;;
    "stop")
        echo "🛑 Stopping systemd service..."
        systemctl --user stop living-room-switcher.service
        ./control-display.sh stop
        echo "✅ Service and processes stopped."
        ;;
    "help"|*)
        echo "🎮 Quick Display Control Aliases"
        echo ""
        echo "Usage: $0 <command>"
        echo ""
        echo "Commands:"
        echo "  p     - Pause switching (for editing Grafana)"
        echo "  r     - Resume switching"
        echo "  s     - Show status"
        echo "  start - Start the display system"
        echo "  stop  - Stop all processes"
        echo ""
        echo "Examples:"
        echo "  $0 p     # Pause for editing"
        echo "  $0 r     # Resume switching"
        echo "  $0 s     # Check status"
        echo "  $0 start # Start display system"
        echo "  $0 stop  # Stop everything"
        ;;
esac
