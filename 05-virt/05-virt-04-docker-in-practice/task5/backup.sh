#!/bin/bash
set -e

BACKUP_DIR="/opt/backup"
DATE=$(date +%F_%H-%M)
BACKUP_FILE="$BACKUP_DIR/backup_$DATE.sql"

mkdir -p "$BACKUP_DIR"

# Запускаем mysqldump ВНУТРИ контейнера, но вывод направляем НА ХОСТ
docker run --rm \
  --network task5_backend \
  -e MYSQL_PWD=very_strong \
  mysql:8 \
  mysqldump -h 172.20.0.10 -u app --all-databases > "$BACKUP_FILE"

echo "[$(date)] Backup created: $BACKUP_FILE"
