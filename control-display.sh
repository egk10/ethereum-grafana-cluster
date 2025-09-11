#!/bin/bash

# 🎮 Living Room Display Control Panel
# Commands: pause, resume, status, stop

COMMAND=$1

# Control file for pause/resume state
PAUSE_FILE="/tmp/living-room-display-pause"

case $COMMAND in
    "pause")
        echo "⏸️  PAUSING window switching..."
        touch "$PAUSE_FILE"
        echo "✅ Switching paused. You can now safely edit Grafana dashboards."
        echo "💡 Run '$0 resume' when you're done editing."
        ;;
    "resume")
        echo "▶️  RESUMING window switching..."
        rm -f "$PAUSE_FILE"
        echo "✅ Switching resumed. Windows will switch automatically again."
        ;;
    "status")
        # Check if processes are actually running
        RUNNING_PROCESSES=$(ps aux | grep -E "(firefox|start-persistent|advanced-switcher)" | grep -v grep | wc -l)
        SERVICE_ACTIVE=$(systemctl --user is-active living-room-switcher.service 2>/dev/null || echo "inactive")

        if [ "$SERVICE_ACTIVE" = "active" ] && [ "$RUNNING_PROCESSES" -gt 0 ]; then
            if [ -f "$PAUSE_FILE" ]; then
                echo "⏸️  STATUS: Switching is PAUSED (processes running)"
                echo "📝 You can safely edit Grafana dashboards"
                echo "💡 Run '$0 resume' to restart switching"
            else
                echo "▶️  STATUS: Switching is ACTIVE"
                echo "🔄 Windows are switching automatically"
                echo "💡 Run '$0 pause' to pause for editing"
            fi
            echo "🖥️  Running processes: $RUNNING_PROCESSES"
        elif [ "$SERVICE_ACTIVE" = "active" ] && [ "$RUNNING_PROCESSES" -eq 0 ]; then
            echo "⚠️  STATUS: Service active but no processes running"
            echo "🔄 Service is running but display windows may have crashed"
            echo "💡 Try restarting: systemctl --user restart living-room-switcher.service"
        else
            echo "❌ STATUS: Display system is STOPPED"
            echo "🛑 No processes running, service inactive"
            echo "💡 Start with: ./display.sh start"
        fi
        ;;
    "stop")
        echo "🛑 STOPPING living room display..."
        pkill firefox
        pkill -f advanced-switcher
        rm -f "$PAUSE_FILE"
        echo "✅ All processes stopped."
        ;;
    *)
        echo "🎮 Living Room Display Control Panel"
        echo ""
        echo "Usage: $0 <command>"
        echo ""
        echo "Commands:"
        echo "  pause   - Pause automatic window switching"
        echo "  resume  - Resume automatic window switching"
        echo "  status  - Show current switching status (with process info)"
        echo "  stop    - Stop all display processes"
        echo ""
        echo "Examples:"
        echo "  $0 pause   # Pause switching to edit Grafana"
        echo "  $0 resume  # Resume switching after editing"
        echo "  $0 status  # Check if switching is active (shows process count)"
        ;;
esac
