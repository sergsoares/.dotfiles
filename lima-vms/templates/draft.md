# Draft

# Start (downloads image ~400MB on first run)
limactl start --name=debian13 debian13-isolated.yaml
limactl start --name=claudelab debian13-isolated.yaml


# Shell into it
limactl shell debian13
limactl shell claudelab

# Or SSH directly
ssh -p 2222 user@localhost

# Stop / destroy
limactl stop debian13
limactl delete debian13
