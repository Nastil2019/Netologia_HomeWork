#!/bin/bash
set -e
BACKUP_DIR="/opt/backup"
mkdir -p "$BACKUP_DIR"
docker run --rm \
  --network my-solution_backend \
  -v "$BACKUP_DIR":/backup \
  -e MYSQL_PWD=secret123 \
  mysql:8 \
  mysqldump -h 172.20.0.10 -u root --all-databases > "/backup/backup_$(date +%F_%H-%M).sql"
echo "Backup created: $(ls -1 /opt/backup/ | tail -1)"
