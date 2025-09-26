#!/bin/bash
# Build script for creating release packages

set -e

VERSION=${1:-"v1.0.0"}
OUTPUT_DIR="dist"

echo "🚀 Building Living Room Display System ${VERSION}"

# Clean previous build
rm -rf "$OUTPUT_DIR"
mkdir -p "$OUTPUT_DIR"

# Create release directory
RELEASE_DIR="$OUTPUT_DIR/release"
mkdir -p "$RELEASE_DIR"

echo "📋 Copying files..."

# Root-level entry points and docs
cp display.sh "$RELEASE_DIR/"
cp README.md "$RELEASE_DIR/"
cp INSTALL.md "$RELEASE_DIR/"
cp LICENSE "$RELEASE_DIR/"

# Scripts, configs, and systemd units
rsync -a --exclude "display-config.sh" scripts "$RELEASE_DIR/"
rsync -a config "$RELEASE_DIR/"
rsync -a systemd "$RELEASE_DIR/"

# Make scripts executable
echo "🔧 Making scripts executable..."
chmod +x "$RELEASE_DIR"/display.sh
chmod +x "$RELEASE_DIR"/scripts/*.sh

# Create installation script
echo "📦 Creating installation script..."
cat > "$RELEASE_DIR/install.sh" << 'EOF'
#!/bin/bash
# Living Room Display - Installation Script

echo "🚀 Installing Living Room Display System..."

# Create installation directory
INSTALL_DIR="$HOME/ethereum-grafana-cluster"
mkdir -p "$INSTALL_DIR"

# Copy files
rsync -a --exclude install.sh ./ "$INSTALL_DIR/"

# Make scripts executable
chmod +x "$INSTALL_DIR"/display.sh
chmod +x "$INSTALL_DIR"/scripts/*.sh

echo "✅ Installation complete!"
echo ""
echo "📋 Quick Start:"
echo "  cd $INSTALL_DIR"
echo "  ./scripts/start-persistent.sh"
echo ""
echo "📖 For more options, see README.md"
EOF

chmod +x "$RELEASE_DIR/install.sh"

# Create archives
echo "📦 Creating release archives..."
cd "$OUTPUT_DIR"
tar -czf "living-room-display-${VERSION}.tar.gz" release/
zip -r "living-room-display-${VERSION}.zip" release/

echo "✅ Build complete!"
echo ""
echo "📁 Release files created in $OUTPUT_DIR/:"
ls -la *.tar.gz *.zip

echo ""
echo "🎯 To test the release:"
echo "  cd $OUTPUT_DIR"
echo "  tar -xzf living-room-display-${VERSION}.tar.gz"
echo "  cd release"
echo "  ./install.sh"
