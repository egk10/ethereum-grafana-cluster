# Ethereum Grafana Cluster Monitor

A comprehensive monitoring solution for Ethereum validator clusters with automated living room display switching.

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
- **Auto-Switching**: ✅ **WORKING** - Switches every 5 minutes between Grafana and Nethermind
- **Background Mode**: ✅ **WORKING** - All methods tested and functional

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
├── super-simple-switcher.sh    # Auto-switching script
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
