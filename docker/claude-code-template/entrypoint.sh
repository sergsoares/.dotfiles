#!/usr/bin/env bash
set -euo pipefail

# Tighten default file permissions for anything created in the container
umask 077

# Ensure Claude config directory exists with safe permissions.
if [ ! -d "${HOME}/.claude" ]; then
  mkdir -p "${HOME}/.claude"
fi
chmod 700 "${HOME}/.claude" || true

# Ensure workspace exists and is accessible.
mkdir -p /workspace
chmod 755 /workspace || true

exec "$@"

