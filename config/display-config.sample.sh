#!/bin/bash

# 🌐 Living Room Display Configuration (Sample)
# Customize the URLs, durations, and enable/disable windows for your display
# Copy this file to ../display-config.sh and adjust the settings for your deployment.
# Replace the example hostnames below with your own Tailscale MagicDNS names or local endpoints.

# ===== WINDOW CONFIGURATION =====
# Set ENABLED=true to show the window, false to skip it

# Window 1: Grafana Dashboard (Local monitoring)
WINDOW_1_ENABLED=true
WINDOW_1_URL="http://localhost:3000/dashboards"
WINDOW_1_TITLE="Grafana"
WINDOW_1_DURATION=60

# Window 2: Nethermind UI (Execution client)
WINDOW_2_ENABLED=true
WINDOW_2_URL="http://nethermind.example.tailnet:8545"
WINDOW_2_FALLBACK="http://localhost:9091/"
WINDOW_2_TITLE="Nethermind"
WINDOW_2_DURATION=60

# Window 3: Beaconcha.in (public explorer)
WINDOW_3_ENABLED=true
WINDOW_3_URL="https://beaconcha.in/"
WINDOW_3_TITLE="Beaconcha.in"
WINDOW_3_DURATION=60

# Window 4: Charon / DVT dashboard
WINDOW_4_ENABLED=true
WINDOW_4_URL="http://charon-grafana.example.tailnet:3001/d/charon-overview?orgId=1&refresh=1m"
WINDOW_4_TITLE="Charon Cluster"
WINDOW_4_DURATION=60

# Window 5: Beaconcha.in (secondary view)
WINDOW_5_ENABLED=true
WINDOW_5_URL="https://beaconcha.in/"
WINDOW_5_TITLE="Beaconcha.in Alt"
WINDOW_5_DURATION=60

# Window 6: Rocketpool dashboard
WINDOW_6_ENABLED=true
WINDOW_6_URL="http://rocketpool-grafana.example.tailnet:3101/d/rocketpool-dashboard?orgId=1&refresh=30s"
WINDOW_6_TITLE="Rocketpool"
WINDOW_6_DURATION=60

# Window 7: Ceph Cluster Dashboard
WINDOW_7_ENABLED=true
WINDOW_7_URL="https://ceph-dashboard.example.tailnet:8443/#/dashboard"
WINDOW_7_TITLE="🗄️ Ceph Storage Cluster"
WINDOW_7_DURATION=60  # 1.5 minutes - longer for storage metrics

# Window 8: Beaconcha.in (additional validator set)
WINDOW_8_ENABLED=true
WINDOW_8_URL="https://beaconcha.in/"
WINDOW_8_TITLE="Beaconcha.in Extra"
WINDOW_8_DURATION=60  # 5 minutes

# ===== DISPLAY SETTINGS =====
DISPLAY=:0
LOG_DIR="./logs"
mkdir -p "$LOG_DIR"

# ===== ADVANCED SETTINGS =====
# Transition delay between windows (seconds)
TRANSITION_DELAY=3

# Enable/disable debug logging
DEBUG_MODE=false

# Auto-restart on window switch failure
AUTO_RECOVERY=true

# ===== FIREFOX PROFILE SETTINGS =====
# Uses main Firefox profile to preserve passwords, bookmarks, and sync
FIREFOX_PROFILE_PATH="/home/egk/.mozilla/firefox/widltds1.default-release"

# Clean profile on startup (set to true if having issues with corrupted profile)
CLEAN_FIREFOX_PROFILE=false
