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

# Copy files
echo "📋 Copying files..."
cp *.sh "$RELEASE_DIR/" 2>/dev/null || true
cp *.service "$RELEASE_DIR/" 2>/dev/null || true
cp *.md "$RELEASE_DIR/" 2>/dev/null || true
cp LICENSE "$RELEASE_DIR/" 2>/dev/null || true

# Make scripts executable
echo "🔧 Making scripts executable..."
chmod +x "$RELEASE_DIR"/*.sh

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
