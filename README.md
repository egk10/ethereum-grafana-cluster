# Ethereum Grafana Clust✅ **Simple background** | ✅ **Good for testing**

## 📦 Binary Releases

**Download the latest build** from [GitHub Actions](https://github.com/egk10/ethereum-grafana-cluster/actions)

### Installation from GitHub Actions Artifact

1. **Go to Actions tab** in the repository
2. **Find the latest successful workflow run** (triggered by version tag)
3. **Download the artifact** named `living-room-display-vX.X.X`
4. **Extract** the archive:
   ```bash
   tar -xzf living-room-display-v1.0.4.tar.gz
   cd release
   ```
5. **Run the installer**:
   ```bash
   ./install.sh
   ```
6. **Start the display**:
   ```bash
   cd ~/ethereum-grafana-cluster
   ./start-persistent.sh
   ```

### Local Build

To build release packages locally:

```bash
./build-release.sh [version]
```

Example:
```bash
./build-release.sh v1.0.4
```

This creates `.tar.gz` and `.zip` archives in the `dist/` directory.

## 📋 Release NotesMonitor

A comprehensive monitoring solution for Ethereum validator clusters with **automated living room display switching**.

## 🚀 Quick Start (3 Methods)

### Method 1: Persistent Background (Recommended)
```bash
cd /home/egk/ethereum-grafana-cluster
./start-persistent.sh
```
✅ **Survives terminal close** | ✅ **Auto-restarts** | ✅ **Production ready**

### Method 2: Systemd Service (Auto-start on boot)
```bash
./install-service.sh
systemctl --user start living-room-switcher.service
```
✅ **Starts automatically on boot** | ✅ **Managed by systemd**

### Method 3: Manual Start
```bash
./start-living-room.sh &
```
✅ **Simple background** | ✅ **Good for testing**

## � Release Notes

### v1.0.0 - Living Room Display System 🎉
**Released:** September 7, 2025

✅ **Core Features:**
- Automated switching between Grafana dashboards and Nethermind UI
- Persistent background operation (survives terminal close)
- Systemd service for auto-start on boot
- Robust error handling and process management
- Multiple startup methods (manual, persistent, systemd)

✅ **New Files:**
- `start-persistent.sh`: Main persistent launcher with nohup
- `install-service.sh`: Systemd service installer
- `living-room-switcher.service`: Systemd service definition
- Updated `super-simple-switcher.sh`: Fixed window title matching

✅ **Key Improvements:**
- Processes remain running after terminal closes
- Automatic restart on system boot
- Better window title detection
- Comprehensive logging
- Multiple startup methods (manual, persistent, systemd)

✅ **Tested & Verified:**
- Background operation works correctly
- Window switching every 5 minutes
- Graceful error handling
- Systemd integration functional

🚀 **Ready for production use!**

## 🎯 Features

- **8-Window Living Room Display**: Support for up to 8 Firefox windows with individual durations
- **Custom Durations**: Each window can have its own display time (1-60 minutes)
- **Enable/Disable Windows**: Turn windows on/off without removing configuration
- **Multi-Node Monitoring**: Monitor multiple Ethereum nodes via Prometheus federation
- **Grafana Dashboards**: Pre-configured dashboards for various Ethereum clients (Nethermind, Lighthouse, etc.)
- **Persistent Operation**: Processes continue running after terminal closes
- **Systemd Integration**: Auto-start on system boot
- **Docker Compose**: Easy deployment with Docker Compose
- **Tailscale Integration**: Secure remote access via Tailscale VPN
- **Interactive Configuration**: Easy-to-use configuration helper script

## Features

- **Multi-Node Monitoring**: Monitor multiple Ethereum nodes via Prometheus federation
- **Grafana Dashboards**: Pre-configured dashboards for various Ethereum clients (Nethermind, Lighthouse, etc.)
- **Living Room Display**: Automated switching between Grafana dashboards and Nethermind UI
- **Docker Compose**: Easy deployment with Docker Compose
- **Tailscale Integration**: Secure remote access via Tailscale VPN

## Quick Start

1. **Clone the repository:**
   ```bash
   git clone https://github.com/egk10/ethereum-grafana-cluster.git
   cd ethereum-grafana-cluster
   ```

2. **Set environment variables:**
   ```bash
   export GRAFANA_ADMIN_PASSWORD=your_secure_password
   ```

3. **Start the monitoring stack:**
   ```bash
   docker-compose up -d
   ```

4. **Access Grafana:**
   - URL: http://localhost:3000
   - Username: admin
   - Password: your_secure_password

## Living Room Display Setup

For automated display switching between Grafana and Nethermind:

### Background Mode Instructions

**Method 1 - Simple Background (Recommended):**
```bash
cd /home/egk/ethereum-grafana-cluster
./start-living-room.sh &
```

**Method 2 - Detached with Logging:**
```bash
cd /home/egk/ethereum-grafana-cluster
nohup ./start-living-room.sh > living-room.log 2>&1 &
```

**Method 3 - Screen Session:**
```bash
cd /home/egk/ethereum-grafana-cluster
screen -S living-room ./start-living-room.sh
# Detach: Ctrl+A, D
# Reattach: screen -r living-room
```

### Background Process Management

**Check if running:**
```bash
ps aux | grep start-living-room
ps aux | grep firefox
ps aux | grep super-simple-switcher
```

**View current windows:**
```bash
DISPLAY=:0 wmctrl -l
```

**Stop background process:**
```bash
kill <PID>  # Replace <PID> with process ID from ps command
```

**Stop all Firefox windows:**
```bash
pkill firefox
```

### Manual Start (Foreground)
```bash
./start-living-room.sh
```

### Auto-Start on Boot
The system is configured to automatically start on reboot:

1. **Cron Job**: Runs 30 seconds after system boot
2. **What it does**:
   - Opens Grafana in Firefox kiosk mode
   - Opens Nethermind UI in a new Firefox window
   - Starts automatic switching every 5 minutes

### Current Status ✅
- **Grafana**: Working perfectly at `http://localhost:3000/dashboards`
- **Nethermind**: ✅ **WORKING** - Connected to `http://100.67.5.3:8545`
- **Auto-Switching**: ✅ **WORKING** - Switches every 5 minutes between 4 windows
- **Background Mode**: ✅ **WORKING** - All methods tested and functional

## 🎛️ Advanced Display Customization (Up to 8 Windows)

The system now supports **up to 8 Firefox windows** with **individual durations** and **enable/disable controls**:

### Interactive Configuration

**Easiest Method - Interactive Helper:**
```bash
./configure.sh
```

This interactive tool lets you:
- ✅ Enable/disable any of the 8 windows
- ✅ Set custom durations for each window (1-60 minutes)
- ✅ Change URLs and titles
- ✅ View cycle time calculations
- ✅ Reset to defaults

### Manual Configuration

Edit `display-config.sh` to customize:

```bash
# Enable/disable windows
WINDOW_1_ENABLED=true   # Grafana Dashboard
WINDOW_2_ENABLED=true   # Nethermind UI
WINDOW_3_ENABLED=true   # Beaconcha.in Explorer
WINDOW_4_ENABLED=true   # EthStats Metrics
WINDOW_5_ENABLED=false  # Etherscan (disabled)
WINDOW_6_ENABLED=false  # EtherNodes (disabled)
WINDOW_7_ENABLED=false  # Custom URL (disabled)
WINDOW_8_ENABLED=false  # Another Custom (disabled)

# Set individual durations (in seconds)
WINDOW_1_DURATION=300   # 5 minutes
WINDOW_2_DURATION=300   # 5 minutes
WINDOW_3_DURATION=240   # 4 minutes
WINDOW_4_DURATION=240   # 4 minutes
WINDOW_5_DURATION=180   # 3 minutes
WINDOW_6_DURATION=180   # 3 minutes
```

### Pre-configured Window Options

**Available Windows:**
1. **Grafana Dashboard** - `http://localhost:3000/dashboards`
2. **Nethermind UI** - `http://100.67.5.3:8545` (with Prometheus fallback)
3. **Beaconcha.in Explorer** - `https://beaconcha.in/`
4. **EthStats Metrics** - `https://ethstats.net/`
5. **Etherscan** - `https://etherscan.io/`
6. **EtherNodes Map** - `https://ethernodes.org/`
7. **Custom URL** - Configure your own
8. **Another Custom** - Additional custom URL

### Advanced Settings

```bash
# Display settings
DISPLAY=:0                    # X11 display number
LOG_DIR="./logs"             # Log directory
TRANSITION_DELAY=3           # Delay between switches (seconds)
DEBUG_MODE=false             # Enable debug logging
AUTO_RECOVERY=true           # Auto-restart on failures
```

### Example Configurations

**Quick Monitoring (4 windows, 18 min cycle):**
```bash
WINDOW_1_ENABLED=true  # Grafana (5 min)
WINDOW_2_ENABLED=true  # Nethermind (5 min)
WINDOW_3_ENABLED=true  # Beaconcha.in (4 min)
WINDOW_4_ENABLED=true  # EthStats (4 min)
```

**Extended Monitoring (6 windows, 26 min cycle):**
```bash
WINDOW_1_ENABLED=true  # Grafana (5 min)
WINDOW_2_ENABLED=true  # Nethermind (5 min)
WINDOW_3_ENABLED=true  # Beaconcha.in (4 min)
WINDOW_4_ENABLED=true  # EthStats (4 min)
WINDOW_5_ENABLED=true  # Etherscan (3 min)
WINDOW_6_ENABLED=true  # EtherNodes (3 min)
```

**Minimal Setup (2 windows, 8 min cycle):**
```bash
WINDOW_1_ENABLED=true  # Grafana (4 min)
WINDOW_2_ENABLED=true  # Nethermind (4 min)
WINDOW_3_ENABLED=false # Disabled
WINDOW_4_ENABLED=false # Disabled
```

### Testing Your Configuration

**Test Configuration:**
```bash
./test-config.sh
```

**Test Switching Only:**
```bash
./advanced-switcher.sh
```

**Start Full Display:**
```bash
./start-persistent.sh

## Configuration

### Environment Variables

- `GRAFANA_ADMIN_PASSWORD`: Admin password for Grafana (default: changeme123)

### Node Integration

To add your Ethereum nodes to the monitoring:

1. Copy `eth-docker-configs/` to your node
2. Update Prometheus federation targets in `prometheus/prometheus.yml`
3. Update datasource URLs in `grafana/datasources/prometheus.yml`

## Project Structure

```
├── docker-compose.yml          # Main Docker Compose configuration
├── grafana/                    # Grafana configuration and dashboards
├── prometheus/                 # Prometheus configuration and rules
├── eth-docker-configs/         # Configuration for eth-docker integration
├── ethereum-metrics/           # Ethereum metrics exporter config
├── start-living-room.sh        # Living room display starter script
├── start-persistent.sh         # Persistent display starter with nohup
├── super-simple-switcher.sh    # Basic window switcher
├── advanced-switcher.sh        # Advanced switcher with custom durations
├── display-config.sh           # Configuration file for all settings
├── configure.sh                # Interactive configuration helper
├── test-config.sh              # Configuration testing tool
├── logs/                       # Log files directory (auto-created)
└── validator-dashboard/        # Additional dashboard files
```

## Supported Ethereum Clients

- Nethermind
- Lighthouse
- Prysm
- Teku
- And more via Prometheus metrics

## Requirements

- Docker and Docker Compose
- Firefox (for living room display)
- wmctrl (for window switching)
- Tailscale (for remote access)

## Security

- Change default Grafana password
- Use Tailscale for secure remote access
- Review firewall settings for Prometheus ports
- Consider using environment files for sensitive data

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## License

MIT License - see LICENSE file for details
