#!/bin/bash

# 🌐 Living Room Display Configuration
# Customize the URLs, durations, and enable/disable windows for your display

# ===== WINDOW CONFIGURATION =====
# Set ENABLED=true to show the window, false to skip it

# Window 1: Grafana Dashboard (Local monitoring)
WINDOW_1_ENABLED=true
WINDOW_1_URL="http://localhost:3000/dashboards"
WINDOW_1_TITLE="Grafana"
WINDOW_1_DURATION=60

# Window 2: Nethermind UI (Execution client)
WINDOW_2_ENABLED=true
WINDOW_2_URL="http://100.67.5.3:8545"
WINDOW_2_FALLBACK="http://localhost:9091/"
WINDOW_2_TITLE="Nethermind"
WINDOW_2_DURATION=60

# Window 3: Ethereum Explorer (Beaconcha.in)
WINDOW_3_ENABLED=true
WINDOW_3_URL="https://beaconcha.in/"
WINDOW_3_TITLE="Beaconcha.in"
WINDOW_3_DURATION=60

# Window 4: Charon-Etherfi-BR Dashboard
WINDOW_4_ENABLED=true
WINDOW_4_URL="http://100.72.3.103:3001/d/d6qujIJVk/charon-overview?var-interval=\$__auto&orgId=1&from=now-24h&to=now&timezone=browser&var-cluster_network=\$__all&var-cluster_name=etherfi-obol-mainnet-latam-9&var-cluster_hash=b5c39ea&var-cluster_peer=agreeable-fact&var-job=charon&var-peer=\$__all&var-duty=\$__all&refresh=1m"
WINDOW_4_TITLE="Charon-Etherfi-BR"
WINDOW_4_DURATION=60

# Window 5: Beaconcha in Nodeset
WINDOW_5_ENABLED=true
WINDOW_5_URL="https://beaconcha.in/dashboard/v-d0e5902b-d62b-4da1-b677-a85b77979491"
WINDOW_5_TITLE="Beaconcha in Nodeset"
WINDOW_5_DURATION=60

# Window 6: Rocketpool Minipool Dashboard
WINDOW_6_ENABLED=true
WINDOW_6_URL="http://100.72.3.103:3101/d/f1e28493-0757-4051-be71-65ef20079d26/rocket-pool-dashboard-v1-3-2-provisioned?orgId=1&refresh=30s"
WINDOW_6_TITLE="Rocketpool Minipool"
WINDOW_6_DURATION=60

# Window 7: Ceph Cluster Dashboard
WINDOW_7_ENABLED=true
WINDOW_7_URL="http://localhost:3000/d/ceph-cluster-living-room/ceph-storage-cluster-living-room?orgId=1&refresh=30s&from=now-1h&to=now&kiosk=tv"
WINDOW_7_TITLE="🗄️ Ceph Storage Cluster"
WINDOW_7_DURATION=60  # 1.5 minutes - longer for storage metrics

# Window 8: Beaconcha in Lido
WINDOW_8_ENABLED=true
WINDOW_8_URL="https://beaconcha.in/dashboard/v-b8a9d009-23ef-4527-89c1-15de538f94ff"
WINDOW_8_TITLE="Lido Beaconha.in"
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
