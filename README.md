# Ethereum Grafana Cluster Display

A simple living room display system for monitoring Ethereum validator clusters with automated window switching.

## 🚀 Quick Start

```bash
# Start the display system
./start-persistent.sh

# Control commands
./display.sh p    # Pause switching (for editing Grafana)
./display.sh r    # Resume switching
./display.sh s    # Check status
./display.sh start # Start the display system
./display.sh stop  # Stop everything
```

## 📦 Installation

See [INSTALL.md](INSTALL.md) for detailed installation instructions including:
- Download from GitHub Releases
- Systemd service setup
- Manual installation
- Requirements and troubleshooting

## 🎮 Control Systema Cluster Display

A simple living room display system for monitoring Ethereum validator clusters with automated window switching.

## 🚀 Quick Start

```bash
# Start the display system
./start-persistent.sh

# Control commands
./display.sh p    # Pause switching (for editing Grafana)
./display.sh r    # Resume switching
./display.sh s    # Check status
```

## � Control System

### Pause for Editing Grafana
```bash
./display.sh p
```
✅ **Safe to edit Grafana dashboards** - switching stops automatically

### Resume Switching
```bash
./display.sh r
```
✅ **Normal switching resumes** - seamless continuation

### Check Status
```bash
./display.sh s
```
📊 **Shows current state** - active or paused

## 📋 Window Configuration

The system cycles through 6 windows:
- 🖥️ **Grafana Dashboard** (5 min) - `http://localhost:3000/dashboards`
- 🖥️ **Nethermind UI** (3 min) - `http://100.67.5.3:8545`
- 🖥️ **Beaconcha.in** (2 min) - `https://beaconcha.in/`
- 🖥️ **Charon-Etherfi-BR** (2 min) - Custom dashboard
- 🖥️ **Rocketpool-stats** (1 min) - Custom dashboard
- 🖥️ **Rocketpool Minipool** (1 min) - Custom dashboard

**Total cycle time: 14 minutes**

## 🎯 Key Features

- ✅ **Automated switching** between monitoring dashboards
- ✅ **Pause/resume system** for safe Grafana editing
- ✅ **Persistent operation** (survives terminal close)
- ✅ **Custom durations** for each window
- ✅ **Comprehensive logging** in `logs/` directory

## 📁 Files

- `start-persistent.sh` - Main launcher
- `display.sh` - Quick control commands
- `control-display.sh` - Full control panel
- `advanced-switcher.sh` - Smart window switcher
- `display-config.sh` - Configuration settings
- `DISPLAY-CONTROL-README.md` - Detailed documentation

## 🛑 Emergency Controls

```bash
# Stop everything (stops systemd service + processes)
./display.sh stop

# Or manually stop service
systemctl --user stop living-room-switcher.service

# Kill processes (if service is stopped)
pkill firefox && pkill -f advanced-switcher
```

## 📊 Monitoring

```bash
# Check running processes
ps aux | grep -E '(firefox|advanced-switcher)'

# View logs
tail -f logs/switcher.log
```

## ⚙️ Requirements

- Ubuntu Linux with X11
- Firefox browser
- wmctrl (for window control)

## 🔧 Advanced Usage

See `DISPLAY-CONTROL-README.md` for detailed documentation and advanced configuration options.
