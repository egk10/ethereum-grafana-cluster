#!/bin/bash

# 🔄 Super Simple Window Switcher
# Uses exact window IDs for reliable switching

echo "🔄 Starting super simple window switcher..."
echo "📋 Schedule: 5min Grafana → 5min Nethermind → repeat"

# Function to switch to Grafana
switch_to_grafana() {
    echo "$(date): 📊 Switching to Grafana..."
    DISPLAY=:0 wmctrl -a "Grafana"
}

# Function to switch to Nethermind
switch_to_nethermind() {
    echo "$(date): 🔥 Switching to Nethermind..."
    DISPLAY=:0 wmctrl -a "Nethermind"
}

# Start with Grafana
switch_to_grafana
sleep 5

while true; do
    echo "$(date): 🕐 Grafana phase (5 minutes)..."
    sleep 300  # 5 minutes

    switch_to_nethermind

    echo "$(date): 🕑 Nethermind phase (5 minutes)..."
    sleep 300  # 5 minutes

    switch_to_grafana
done
