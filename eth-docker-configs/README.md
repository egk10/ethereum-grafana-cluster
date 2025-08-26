# Eth-Docker Integration for Prometheus Federation

This directory contains configuration files to enable Prometheus federation sharing with eth-docker nodes.

## Files

- `custom.yml` - Custom docker-compose overrides that are safe from eth-docker updates
- `prometheus-shared.yml` - Prometheus federation configuration with port exposure

## Setup Instructions

### 1. Copy Files to Your Node

Copy these files to your eth-docker directory:

```bash
# On your ryzen7 node (minipcamd4)
cd ~/eth-docker
cp /path/to/this/repo/eth-docker-configs/custom.yml .
cp /path/to/this/repo/eth-docker-configs/prometheus-shared.yml .
```

### 2. Update .env File

Add the following line to your `.env` file:

```bash
# Enable custom compose files
COMPOSE_FILE=custom.yml:prometheus-shared.yml
```

### 3. Set Environment Variables (Optional)

You can customize the prometheus port and IP:

```bash
# Expose prometheus on all interfaces (default)
SHARE_IP=0.0.0.0
PROMETHEUS_PORT=9090

# Or expose on specific interface
SHARE_IP=100.90.57.27
PROMETHEUS_PORT=9090
```

### 4. Restart Services

```bash
cd ~/eth-docker
docker-compose down
docker-compose up -d
```

### 5. Verify Port Exposure

Check that prometheus is now accessible:

```bash
# From your opi5 monitoring node
curl -s http://minipcamd4.velociraptor-scylla.ts.net:9090/federate?match[]=up
```

## What These Files Do

### custom.yml
- Exposes node-exporter on port 9100 for hardware monitoring
- Exposes ethereum-metrics-exporter on port 9093 (if present)
- Safe from eth-docker updates (added to .gitignore)

### prometheus-shared.yml
- Exposes Prometheus on port 9090 for federation scraping
- Uses environment variables for flexible IP/port configuration
- Enables your central monitoring to scrape all node metrics

## Integration with Central Monitoring

Once these files are deployed:

1. Your ryzen7 node's prometheus will be accessible at `minipcamd4.velociraptor-scylla.ts.net:9090`
2. The central prometheus on opi5 will automatically scrape metrics via federation
3. Grafana dashboards will populate with ryzen7 data
4. Hardware metrics will be available via node-exporter on port 9100

## Troubleshooting

### Port Already in Use
If port 9090 is already in use, change the PROMETHEUS_PORT variable:
```bash
PROMETHEUS_PORT=9091
```

### Permission Issues
Ensure you're running commands as the same user that owns the eth-docker directory.

### Services Not Starting
Check docker logs:
```bash
docker-compose logs prometheus
docker-compose logs node-exporter
```

## Security Note

These configurations expose prometheus and node-exporter to the network. Ensure your Tailscale network is secure, or consider using firewall rules to restrict access to your monitoring IP only.
