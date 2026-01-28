#!/bin/bash
set -euo pipefail
ROOT_PASS=$(grep MYSQL_ROOT_PASSWORD .env | cut -d'=' -f2 | tr -d '"')
sudo mkdir -p /opt/backup

docker run --rm \
  --network my-solution_backend \
  -v /opt/backup:/backup \
  mysql:8 \
  mysqldump \
    -h 172.20.0.10 \
    -u root \
    -p"$ROOT_PASS" \
    --all-databases > /opt/backup/backup_$(date +%F_%H-%M).sql

echo "Backup saved to: $(ls -t /opt/backup/ | head -n1)"
