# 🚀 Living Room Display - Installation Guide

## 📦 Installation Methods

### Method 1: Download from GitHub Releases (Recommended)

1. **Go to GitHub Releases:**
   - Visit: https://github.com/egk10/ethereum-grafana-cluster/releases
   - Download the latest version: `living-room-display-v1.1.0.tar.gz`

2. **Extract and Install:**
   ```bash
   # Extract the archive
   tar -xzf living-room-display-v1.1.0.tar.gz
   cd release

   # Run the installer
   ./install.sh
   ```

3. **Start the system:**
   ```bash
   cd ~/ethereum-grafana-cluster
   ./scripts/start-persistent.sh
   ```

### Method 2: Clone from Git Repository

1. **Clone the repository:**
   ```bash
   git clone https://github.com/egk10/ethereum-grafana-cluster.git
   cd ethereum-grafana-cluster
   ```

2. **Make scripts executable:**
   ```bash
   chmod +x display.sh
   chmod +x scripts/*.sh
   ```

3. **Start the system:**
   ```bash
   ./scripts/start-persistent.sh
   ```

### Method 3: Systemd Service (Auto-start on boot)

1. **Install the service:**
   ```bash
   ./scripts/install-service.sh
   ```

2. **Start the service:**
   ```bash
   systemctl --user start living-room-switcher.service
   ```

3. **Check status:**
   ```bash
   systemctl --user status living-room-switcher.service
   ```

## ⚙️ System Requirements

### Required Software
- **Ubuntu Linux** (or compatible with X11)
- **Firefox browser** (for kiosk mode)
- **wmctrl** (for window control)
- **X11 display server**

### Installation Commands
```bash
# Ubuntu/Debian
sudo apt update
sudo apt install firefox wmctrl

# Verify installation
firefox --version
wmctrl --version
```

## 🎯 Quick Start After Installation

### Basic Operation
```bash
# Start the display system
./scripts/start-persistent.sh

# Control commands
./display.sh p    # Pause switching (for editing Grafana)
./display.sh r    # Resume switching
./display.sh s    # Check status
```

### Systemd Service Management
```bash
# Start service
systemctl --user start living-room-switcher.service

# Stop service
systemctl --user stop living-room-switcher.service

# Check status
systemctl --user status living-room-switcher.service

# View logs
journalctl --user -u living-room-switcher.service -f

# Enable auto-start on boot
systemctl --user enable living-room-switcher.service

# Disable auto-start
systemctl --user disable living-room-switcher.service
```

## 🔧 Configuration

### Window Configuration
Copy `config/display-config.sample.sh` to `display-config.sh` and edit it to customize windows:

```bash
# Copy the sample once per host
cp config/display-config.sample.sh display-config.sh

# Enable/disable windows
WINDOW_1_ENABLED=true   # Grafana Dashboard
WINDOW_2_ENABLED=true   # Nethermind UI
WINDOW_3_ENABLED=true   # Beaconcha.in
WINDOW_4_ENABLED=true   # Charon-Etherfi-BR
WINDOW_5_ENABLED=true   # Rocketpool-stats
WINDOW_6_ENABLED=true   # Rocketpool Minipool

# Set durations (in seconds)
WINDOW_1_DURATION=300   # 5 minutes
WINDOW_2_DURATION=180   # 3 minutes
WINDOW_3_DURATION=120   # 2 minutes
WINDOW_4_DURATION=120   # 2 minutes
WINDOW_5_DURATION=60    # 1 minute
WINDOW_6_DURATION=60    # 1 minute
```

### Display Settings (defined in `display-config.sh`)
```bash
DISPLAY=:0                    # X11 display number
LOG_DIR="./logs"             # Log directory
TRANSITION_DELAY=3           # Delay between switches (seconds)
DEBUG_MODE=false             # Enable debug logging
```

## 📊 Monitoring & Troubleshooting

### Check System Status
```bash
# View running processes
ps aux | grep -E '(firefox|advanced-switcher)'

# View logs
tail -f logs/switcher.log

# Check window list
DISPLAY=:0 wmctrl -l
```

### Common Issues

#### Firefox not starting
```bash
# Check Firefox installation
firefox --version

# Test Firefox kiosk mode
firefox --kiosk http://localhost:3000
```

#### wmctrl not working
```bash
# Check wmctrl installation
wmctrl --version

# Test window listing
DISPLAY=:0 wmctrl -l
```

#### Permission issues
```bash
# Make scripts executable
chmod +x display.sh
chmod +x scripts/*.sh

# Check file permissions
ls -la display.sh scripts/*.sh
```

#### Display issues
```bash
# Check DISPLAY variable
echo $DISPLAY

# Test with explicit display
DISPLAY=:0 ./scripts/start-persistent.sh
```

## 🛑 Emergency Controls

### Stop Everything
```bash
# Quick stop
./display.sh stop

# Manual stop
pkill firefox
pkill -f advanced-switcher

# Stop systemd service
systemctl --user stop living-room-switcher.service
```

### Clean Restart
```bash
# Stop everything
./display.sh stop

# Wait a moment
sleep 3

# Restart
./scripts/start-persistent.sh
```

## 📁 File Structure After Installation

```
~/ethereum-grafana-cluster/
├── README.md                     # This documentation
├── DISPLAY-CONTROL-README.md     # Detailed control guide
├── display.sh                    # Quick aliases
├── config/
│   └── display-config.sample.sh  # Template for local display-config.sh
├── scripts/
│   ├── advanced-switcher.sh      # Smart window switcher
│   ├── control-display.sh        # Full control panel
│   ├── install-service.sh        # Systemd installer
│   ├── start-persistent.sh       # Main launcher (used by systemd)
│   └── wrapper.sh                # Systemd wrapper
├── systemd/
│   └── living-room-switcher.service # Systemd service file
├── logs/                         # Runtime logs (auto-created)
└── dist/                         # Release artifacts (if built)
```

## 🔄 Upgrading

### From Git Repository
```bash
git pull origin master
cd ~/ethereum-grafana-cluster
git pull origin master
chmod +x display.sh
chmod +x scripts/*.sh
```

### From Release Archive
```bash
# Backup current config
cp ~/ethereum-grafana-cluster/display-config.sh ~/display-config-backup.sh

# Extract new version
tar -xzf living-room-display-v1.1.0.tar.gz
cd release
./install.sh

# Restore config
cp ~/display-config-backup.sh ~/ethereum-grafana-cluster/display-config.sh
```

## 🎯 Usage Examples

### Daily Operation
```bash
# Start in morning
./scripts/start-persistent.sh

# Pause for maintenance
./display.sh p

# Edit Grafana dashboards...
# (safe to edit without interruption)

# Resume when done
./display.sh r
```

### Automated Operation
```bash
# Enable systemd service for auto-start
./scripts/install-service.sh
systemctl --user enable living-room-switcher.service

# System will start automatically on boot
```

### Monitoring
```bash
# Check status
./display.sh s

# View recent activity
tail -20 logs/switcher.log

# Monitor processes
watch -n 5 'ps aux | grep -E "(firefox|advanced-switcher)" | grep -v grep'
```

## 📞 Support

If you encounter issues:

1. Check the logs: `tail -f logs/switcher.log`
2. Verify requirements: `firefox --version && wmctrl --version`
3. Test manually: `DISPLAY=:0 firefox --kiosk http://localhost:3000`
4. Check permissions: `ls -la display.sh scripts/*.sh`

For more detailed documentation, see `DISPLAY-CONTROL-README.md`.
