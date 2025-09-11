#!/bin/bash

# 🔄 Advanced Multi-Window Switcher with Custom Durations
# Supports up to 8 windows with individual durations and enable/disable controls

echo "🔄 Starting advanced multi-window switcher..."

# Load configuration
if [ -f "./display-config.sh" ]; then
    source ./display-config.sh
    echo "✅ Configuration loaded from display-config.sh"
else
    echo "❌ Configuration file 'display-config.sh' not found!"
    exit 1
fi

# Function to log messages
log_message() {
    local level=$1
    local message=$2
    if [ "$DEBUG_MODE" = true ] || [ "$level" != "DEBUG" ]; then
        echo "$(date): $message"
        if [ -n "$LOG_DIR" ]; then
            echo "$(date): $message" >> "$LOG_DIR/switcher.log"
        fi
    fi
}

# Function to check if switching is paused
is_paused() {
    if [ -f "/tmp/living-room-display-pause" ]; then
        return 0  # true - paused
    else
        return 1  # false - not paused
    fi
}

# Function to switch to a specific window
switch_to_window() {
    local window_num=$1
    local title_var="WINDOW_${window_num}_TITLE"
    local title="${!title_var}"

    # Check if switching is paused
    if is_paused; then
        log_message "INFO" "⏸️  Switching paused - skipping switch to Window $window_num: $title"
        return 0
    fi

    log_message "INFO" "🔄 Switching to Window $window_num: $title..."

    # Get the actual window list and find matching windows
    local window_list=$(DISPLAY=$DISPLAY wmctrl -l)
    local found_window=""

    # Try different matching strategies based on window number
    case $window_num in
        1)
            # Window 1: Grafana - look for "Grafana" in title
            found_window=$(echo "$window_list" | grep -i "grafana" | head -1 | awk '{print $1}')
            ;;
        2)
            # Window 2: Nethermind - look for "Nethermind" in title
            found_window=$(echo "$window_list" | grep -i "nethermind" | head -1 | awk '{print $1}')
            ;;
        3)
            # Window 3: Beaconcha.in - look for "beaconcha.in" in title
            found_window=$(echo "$window_list" | grep -i "beaconcha.in" | head -1 | awk '{print $1}')
            ;;
        4)
            # Window 4: Charon-Etherfi-BR - look for "Charon" in title
            found_window=$(echo "$window_list" | grep -i "charon" | head -1 | awk '{print $1}')
            ;;
        5)
            # Window 5: Rocketpool-stats - look for "Rocket Pool" and "Provisioned Copy" (not Copy Copy)
            found_window=$(echo "$window_list" | grep -i "rocket.pool" | grep -i "provisioned.copy" | grep -v "copy.copy" | head -1 | awk '{print $1}')
            ;;
        6)
            # Window 6: Rocketpool Minipool - look for "Rocket Pool" and "Copy Copy"
            found_window=$(echo "$window_list" | grep -i "rocket.pool" | grep -i "copy.copy" | head -1 | awk '{print $1}')
            ;;
        *)
            # Fallback: try the original title matching
            found_window=$(echo "$window_list" | grep -i "$title" | head -1 | awk '{print $1}')
            ;;
    esac

    if [ -n "$found_window" ]; then
        log_message "DEBUG" "Found window ID: $found_window for $title"
        DISPLAY=$DISPLAY wmctrl -i -a "$found_window"
    else
        log_message "WARN" "⚠️  Could not find window for: $title"
        log_message "DEBUG" "Available windows:"
        log_message "DEBUG" "$window_list"
    fi
}

# Function to get enabled windows list
get_enabled_windows() {
    local enabled_windows=""
    for i in {1..8}; do
        local enabled_var="WINDOW_${i}_ENABLED"
        if [ "${!enabled_var}" = true ]; then
            enabled_windows="${enabled_windows} $i"
        fi
    done
    echo "$enabled_windows"
}

# Function to calculate total cycle time
calculate_cycle_time() {
    local total_time=0
    for i in {1..8}; do
        local enabled_var="WINDOW_${i}_ENABLED"
        if [ "${!enabled_var}" = true ]; then
            local duration_var="WINDOW_${i}_DURATION"
            total_time=$((total_time + ${!duration_var}))
        fi
    done
    echo "$total_time"
}

# Get enabled windows
ENABLED_WINDOWS=$(get_enabled_windows)
TOTAL_CYCLE_TIME=$(calculate_cycle_time)

if [ -z "$ENABLED_WINDOWS" ]; then
    log_message "ERROR" "❌ No windows are enabled! Please enable at least one window in display-config.sh"
    exit 1
fi

log_message "INFO" "📋 Enabled Windows:$ENABLED_WINDOWS"
log_message "INFO" "⏱️  Total Cycle Time: $(($TOTAL_CYCLE_TIME/60)) minutes"

# Display cycle information
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎯 DISPLAY CYCLE CONFIGURATION:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
for i in $ENABLED_WINDOWS; do
    title_var="WINDOW_${i}_TITLE"
    duration_var="WINDOW_${i}_DURATION"
    url_var="WINDOW_${i}_URL"
    printf "🖥️  Window %d: %-15s | ⏱️ %-2d min | 🌐 %s\n" \
           "$i" "${!title_var}" "$((${!duration_var}/60))" "${!url_var}"
done
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Start with first enabled window
FIRST_WINDOW=$(echo "$ENABLED_WINDOWS" | awk '{print $1}')
switch_to_window "$FIRST_WINDOW"
sleep $TRANSITION_DELAY

# Main switching loop
while true; do
    for window_num in $ENABLED_WINDOWS; do
        # Switch to this window first
        switch_to_window "$window_num"
        sleep $TRANSITION_DELAY

        duration_var="WINDOW_${window_num}_DURATION"
        duration=${!duration_var}
        title_var="WINDOW_${window_num}_TITLE"
        title=${!title_var}

        log_message "INFO" "🕐 $title phase ($(($duration/60)) minutes)..."

        # Wait for the specified duration
        sleep "$duration"
    done

    log_message "INFO" "🔄 Cycle completed - starting over..."
done
