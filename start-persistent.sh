#!/bin/bash

# 🚀 Persistent Living Room Display Starter
# Uses nohup to keep processes running after terminal closes

echo "🚀 Starting Persistent Living Room Display..."

# Load configuration
if [ -f "./display-config.sh" ]; then
    source ./display-config.sh
    echo "✅ Configuration loaded from display-config.sh"
else
    echo "❌ Configuration file 'display-config.sh' not found!"
    exit 1
fi

# Kill any existing processes
pkill firefox
pkill -f super-simple-switcher
pkill -f advanced-switcher

# Wait a moment
sleep 2

# Count enabled windows
ENABLED_COUNT=0
ENABLED_WINDOWS=""
for i in {1..8}; do
    enabled_var="WINDOW_${i}_ENABLED"
    if [ "${!enabled_var}" = true ]; then
        ENABLED_COUNT=$((ENABLED_COUNT + 1))
        ENABLED_WINDOWS="${ENABLED_WINDOWS} $i"
    fi
done

if [ $ENABLED_COUNT -eq 0 ]; then
    echo "❌ No windows are enabled! Please enable at least one window in display-config.sh"
    exit 1
fi

echo "� Starting $ENABLED_COUNT Firefox windows..."

# Launch enabled windows
for i in $ENABLED_WINDOWS; do
    url_var="WINDOW_${i}_URL"
    title_var="WINDOW_${i}_TITLE"
    url="${!url_var}"
    title="${!title_var}"

    echo "🌐 Starting Window $i: $title ($url)"

    if [ "$i" -eq 1 ]; then
        # First window in kiosk mode
        DISPLAY=$DISPLAY nohup firefox --kiosk "$url" > "$LOG_DIR/${title,,}.log" 2>&1 &
    else
        # Subsequent windows in new window kiosk mode
        DISPLAY=$DISPLAY nohup firefox --new-window --kiosk "$url" > "$LOG_DIR/${title,,}.log" 2>&1 &
    fi

    # Wait between launches
    sleep 3
done

# Wait for Firefox windows to be fully ready
echo "⏳ Waiting for Firefox windows to be ready..."
sleep 10

# Start auto-switching (persistent)
echo "🔄 Starting persistent advanced switcher..."
cd /home/egk/ethereum-grafana-cluster
nohup ./advanced-switcher.sh > "$LOG_DIR/switcher.log" 2>&1 &

echo "✅ Persistent living room display started!"
echo "📋 Configuration:"
echo "   🖥️  Windows: $ENABLED_COUNT enabled"
echo "   🔄 Cycle: $ENABLED_WINDOWS"
echo "   📁 Logs: $LOG_DIR/"
echo "💡 Processes will continue running even after closing terminal"
echo ""
echo "🎮 Control Commands:"
echo "  ./display.sh p     - Pause switching (for editing Grafana)"
echo "  ./display.sh r     - Resume switching"
echo "  ./display.sh s     - Check status"
echo "  ./control-display.sh help  - Full command reference"
echo ""
echo "To check status:"
echo "  ps aux | grep -E '(firefox|advanced-switcher)'"
echo ""
echo "To view logs:"
echo "  tail -f $LOG_DIR/*.log"
echo ""
echo "To stop:"
echo "  pkill firefox && pkill -f advanced-switcher"
