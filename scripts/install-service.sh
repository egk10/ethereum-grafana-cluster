#!/bin/bash

# 🚀 Install Living Room Display Systemd Service
# This will make the display start automatically on boot

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
SERVICE_FILE="${REPO_ROOT}/systemd/living-room-switcher.service"

echo "🚀 Installing Living Room Display Systemd Service..."

if [ ! -f "$SERVICE_FILE" ]; then
	echo "❌ Could not find systemd unit at $SERVICE_FILE"
	exit 1
fi

# Copy service file to systemd user directory
mkdir -p ~/.config/systemd/user/
cp "$SERVICE_FILE" ~/.config/systemd/user/

# Reload systemd daemon
systemctl --user daemon-reload

# Enable the service
systemctl --user enable living-room-switcher.service

echo "✅ Service installed!"
echo ""
echo "📋 Service Commands:"
echo "  Start:  systemctl --user start living-room-switcher.service"
echo "  Stop:   systemctl --user stop living-room-switcher.service"
echo "  Status: systemctl --user status living-room-switcher.service"
echo "  Logs:   journalctl --user -u living-room-switcher.service -f"
echo ""
echo "🔄 The switcher will now start automatically on boot!"
echo "💡 You can still use ./scripts/start-persistent.sh for manual control"
