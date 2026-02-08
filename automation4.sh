#!/bin/bash
set -e

LOG_DIR="/opt/logs"

BACKUP_ROOT="/opt/log_backups" 
DATE=$(date +%Y-%m-%d)
HOST=$(hostname)
TEMP_HOLD="$BACKUP_ROOT/temp_$DATE"

mkdir -p "$TEMP_HOLD"
cd "$LOG_DIR"

find . -type f -name '*.log' -exec cp --parents '{}' "$TEMP_HOLD" \;

cd "$BACKUP_ROOT"

tar -czvf "${HOST}_${DATE}.tar.gz" -C "$TEMP_HOLD" .

rm -rf "$TEMP_HOLD"