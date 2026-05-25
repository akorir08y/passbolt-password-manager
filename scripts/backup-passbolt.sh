#!/bin/bash
# Daily backup of Passbolt database
# Add to crontab: 0 2 * * * /path/to/backup-passbolt.sh

BACKUP_DIR="/var/backups/passbolt"
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="$BACKUP_DIR/passbolt_db_$DATE.sql"
DOCKER_COMPOSE_FILE="/opt/Passbolt/docker-compose-ce.yaml"  # adjust path

mkdir -p "$BACKUP_DIR"

# Dump the database from the 'db' container
docker compose -f "$DOCKER_COMPOSE_FILE" exec -T db mysqldump -u passbolt -p"$PASSBOLT_DB_PASSWORD" passbolt > "$BACKUP_FILE"

# Optional: compress and delete old backups (>30 days)
gzip "$BACKUP_FILE"
find "$BACKUP_DIR" -name "*.sql.gz" -mtime +30 -delete

echo "$(date): Backup saved to $BACKUP_FILE.gz"