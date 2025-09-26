# Ethereum Grafana Cluster Display

A living-room friendly dashboard rotation for monitoring the Ethereum validator cluster that runs across your Tailscale-connected homelab. Firefox kiosk windows cycle through Grafana, client UIs, and beacon monitoring dashboards, while `display.sh` gives you a single entry point for pausing, resuming, and supervising the setup.

## 🏁 Quick Start

```bash
# Optional one-time setup – install the user service
./scripts/install-service.sh

# Start the rotating display (launches the systemd user service)
./display.sh start

# Day-to-day controls
./display.sh p   # Pause switching to edit dashboards
./display.sh r   # Resume the rotation
./display.sh s   # Show current status
./display.sh stop  # Stop Firefox + switcher processes
```

Behind the scenes the `living-room-switcher.service` unit invokes `scripts/start-persistent.sh`, which launches Firefox kiosks according to `display-config.sh` and hands control to `scripts/advanced-switcher.sh`. The service is configured with `Restart=never`, so a manual `./display.sh start` (or `systemctl --user start living-room-switcher.service`) is required after any stop.

## 🧭 Controlling the Display

| Command | When to use it | What it does |
| --- | --- | --- |
| `./display.sh start` | When you want the display running | Starts the systemd user service, which launches Firefox windows and the switcher |
| `./display.sh p` | Before editing Grafana, Rocketpool, etc. | Drops a pause flag so `scripts/advanced-switcher.sh` holds the current window |
| `./display.sh r` | After you're done editing | Removes the pause flag and resumes automatic switching |
| `./display.sh s` | Any time you need a heartbeat | Reports whether the service is active, if switching is paused, and how many processes are alive |
| `./display.sh stop` | To clear the display or debug | Stops Firefox, the switcher, and removes the pause flag |

`scripts/control-display.sh` contains the underlying pause/resume logic and keeps the state in `/tmp/living-room-display-pause`, so you can integrate the same flow in other automation if needed.

## 🪟 Window Rotation (defaults)

Start from [`config/display-config.sample.sh`](./config/display-config.sample.sh) and copy it to `display-config.sh` for your local deployment. Durations are defined in seconds; the current sample values are one minute per view so the full loop resets every eight minutes.

| Slot | Title | Default Duration | Example URL (replace with yours) |
| --- | --- | --- | --- |
| 1 | Grafana | 60 s | `http://localhost:3000/dashboards` |
| 2 | Nethermind UI | 60 s | `http://nethermind.example.tailnet:8545` |
| 3 | Beaconcha.in | 60 s | `https://beaconcha.in/` |
| 4 | Charon Cluster | 60 s | `http://charon-grafana.example.tailnet:3001/d/charon-overview?orgId=1&refresh=1m` |
| 5 | Beaconcha.in Alt | 60 s | `https://beaconcha.in/` |
| 6 | Rocketpool | 60 s | `http://rocketpool-grafana.example.tailnet:3101/d/rocketpool-dashboard?orgId=1&refresh=30s` |
| 7 | 🗄️ Ceph Storage Cluster | 60 s | `https://ceph-dashboard.example.tailnet:8443/#/dashboard` |
| 8 | Beaconcha.in Extra | 60 s | `https://beaconcha.in/` |

To adjust the loop, toggle `WINDOW_X_ENABLED`, change URLs, or extend `WINDOW_X_DURATION` in `display-config.sh`. Replace the example hostnames with your own Tailscale MagicDNS names or internal services. The switcher automatically skips any slots marked `false`.

## 🧰 Files that matter

- `display.sh` – primary operator interface for start/pause/resume/stop
- `scripts/advanced-switcher.sh` – wmctrl-based window focus sequencer with pause awareness
- `display-config.sh` – local-only file (gitignored) with URLs, durations, and Firefox profile settings
- `config/display-config.sample.sh` – sanitized template to copy for new deployments
- `scripts/start-persistent.sh` – launches Firefox kiosk sessions and invokes the switcher (called by the service)
- `systemd/living-room-switcher.service` – user-level systemd unit used by `display.sh start`
- `scripts/install-service.sh` – installs and enables the systemd unit in `~/.config/systemd/user`
- `logs/` – per-window Firefox output plus `switcher.log`

The historical helper scripts (`configure.sh`, `start-living-room.sh`, `super-simple-switcher.sh`, `test-config.sh`) were removed because they were empty and unused.

## 🔎 Monitoring & Troubleshooting

- View switcher logs: `tail -f logs/switcher.log`
- Watch Firefox/stdout noise: `tail -f logs/*.log`
- Inspect the service: `systemctl --user status living-room-switcher.service`
- Follow service journal: `journalctl --user -u living-room-switcher.service -f`

If you need to interact with Firefox manually, run `./display.sh p` first so window focus does not jump away mid-edit.

## 📦 Installation notes

[INSTALL.md](./INSTALL.md) documents the full install flow (manual setup, requirements, systemd enablement). After running `./scripts/install-service.sh` once, subsequent boots will start the display automatically.

## ✅ Requirements

- Ubuntu Server 24.04+ with an X11 session on the Orange Pi 5 living-room display
- Firefox (kiosk mode capable)
- `wmctrl` for window management
- Tailscale connectivity to reach Grafana, Nethermind, Rocketpool, and Ceph dashboards

Hardware acceleration is disabled (`MOZ_DISABLE_GPU=1`) for reliability, and the main Firefox profile (`widltds1.default-release`) is reused so saved passwords, sync, and extensions keep working.

---

This repository powers the living-room Grafana display for the Ethereum validator cluster. With the cleanup complete, `display.sh` is the canonical entry point; build artifacts and obsolete shells have been removed to keep maintenance simple.
