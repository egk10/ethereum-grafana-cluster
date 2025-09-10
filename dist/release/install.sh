#!/bin/bash
# Living Room Display - Installation Script

echo "🚀 Installing Living Room Display System..."

# Create installation directory
INSTALL_DIR="$HOME/ethereum-grafana-cluster"
mkdir -p "$INSTALL_DIR"

# Copy files
cp * "$INSTALL_DIR/" 2>/dev/null || true

# Make scripts executable
chmod +x "$INSTALL_DIR"/*.sh

echo "✅ Installation complete!"
echo ""
echo "📋 Quick Start:"
echo "  cd $INSTALL_DIR"
echo "  ./start-persistent.sh"
echo ""
echo "📖 For more options, see README.md"
