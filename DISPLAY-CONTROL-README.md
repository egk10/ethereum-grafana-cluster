# 🎮 Living Room Display Control Guide

## Quick Commands for Editing Grafana Without Interrupting Switching

### When you need to edit Grafana dashboards:

```bash
# 1. Pause the automatic switching
./scripts/control-display.sh pause

# 2. Edit your Grafana playlist/dashboard
# (The system won't switch windows while paused)

# 3. Resume automatic switching when done
./scripts/control-display.sh resume
```

### Check Status Anytime:
```bash
./scripts/control-display.sh status
```

### Available Commands:
- `pause` - Stop automatic window switching
- `resume` - Restart automatic window switching
- `status` - Show current switching state
- `stop` - Stop all display processes

## How It Works

The pause/resume system uses a temporary file (`/tmp/living-room-display-pause`) to signal the switcher to stop switching windows. When paused:

- ✅ Windows stay on the current display
- ✅ You can safely edit Grafana dashboards
- ✅ No automatic switching interrupts your work
- ✅ All other processes continue running

When resumed:
- 🔄 Normal automatic switching continues
- ⏱️  Resumes from the current window's remaining time
- 📊 Full logging continues

## Example Workflow

```bash
# Check current status
./scripts/control-display.sh status
# Output: ▶️ STATUS: Switching is ACTIVE

# Pause for editing
./scripts/control-display.sh pause
# Output: ⏸️ PAUSING window switching...

# Edit your Grafana dashboard/playlist
# (take your time, no switching will happen)

# Resume when done
./scripts/control-display.sh resume
# Output: ▶️ RESUMING window switching...
```

## Troubleshooting

If switching doesn't pause:
1. Check if the switcher is running: `ps aux | grep advanced-switcher`
2. Verify the pause file: `ls -la /tmp/living-room-display-pause`
3. Check logs: `tail -f logs/switcher.log`

The system is designed to be safe - if the pause file gets stuck, simply delete it:
```bash
rm -f /tmp/living-room-display-pause
```
