#!/bin/bash
# /etc/letsencrypt/renewal-hooks/deploy/restart-passbolt.sh
# Restart Passbolt container after certificate renewal

echo "$(date): Certificate renewed - Restarting Passbolt"

# Adjust the path to your docker-compose file if needed
docker compose -f /opt/Passbolt/docker-compose-ce.yaml restart passbolt

echo "$(date): Passbolt restarted successfully"