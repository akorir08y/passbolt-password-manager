# Self-Hosted Passbolt Password Manager – Complete Setup & Email Integration

> A battle‑tested guide to installing Passbolt CE with Docker, configuring reliable email notifications via Mailtrap, and avoiding the data‑loss nightmares that nearly wiped out 200+ passwords.

---

## Table of Contents

1. [Before You Begin](#before-you-begin)
2. [Installation (Standard Steps)](#installation-standard-steps)
3. [Email Setup with Mailtrap](#email-setup-with-mailtrap)
4. [The Disaster That Almost Happened](#the-disaster-that-almost-happened)
5. [Survival Checklist – Backups & Safe Renewals](#survival-checklist--backups--safe-renewals)
6. [Next Steps for Your Team](#next-steps-for-your-team)

---

## Before You Begin

Shopping list for a production‑ready Passbolt server:

- A Linux server (cloud VM recommended) with Docker & Docker Compose installed.
- A standard user account (not root) that can run Docker.
- An SMTP email service – we'll use Mailtrap (free tier works perfectly).
- A domain name (e.g., `passbolt.yourcompany.com`) pointed to your server.

---

## Installation (Standard Steps)

### 1. Grab the Passbolt Setup Files
```
curl -LO "https://download.passbolt.com/ce/docker/docker-compose-ce.yaml"
curl -LO "https://github.com/passbolt/passbolt_docker/releases/latest/download/docker-compose-ce-SHA512SUM.txt"
sha512sum -c docker-compose-ce-SHA512SUM.txt && echo "Checksum OK" || (echo "Bad checksum. Aborting" && rm -f docker-compose-ce.yaml)
```

### 2. Tell Passbolt About Your Team

| Variable	| Description	| Example |
| -------- | -------- | -------- |
| APP_FULL_BASE_URL	| Public access URL	| https://passbolt.yourcompany.com
| EMAIL_DEFAULT_FROM_NAME	| Sender name on emails	| YourCompany Passbolt
| EMAIL_DEFAULT_FROM	| Sender email	| passbolt@yourcompany.com
| EMAIL_TRANSPORT_DEFAULT_HOST	| SMTP host	| live.smtp.mailtrap.io
| EMAIL_TRANSPORT_DEFAULT_PORT	| SMTP port	| 587
| EMAIL_TRANSPORT_DEFAULT_USERNAME	| SMTP username	| (from Mailtrap)
| EMAIL_TRANSPORT_DEFAULT_PASSWORD	| SMTP password	| (from Mailtrap)
| EMAIL_TRANSPORT_DEFAULT_TLS	| Enable TLS	| true

Note: We'll replace the SMTP details with Mailtrap values in the email section below.

### 3. Start Your Password Manager
```
docker compose -f docker-compose-ce.yaml up -d
```

### 4. Create Your Admin Account
```
docker compose -f docker-compose-ce.yaml exec passbolt su -m -c "/usr/share/php/passbolt/bin/cake passbolt register_user -u admin@your-domain.com -f FirstName -l LastName -r admin" -s /bin/sh www-data
```

Important: Save the unique registration link – you'll use it to complete the admin setup in your browser.

### 5. Lock It Down with HTTPS (SSL)

Obtain a certificate (e.g., using certbot):
```
sudo apt install certbot
sudo certbot certonly --standalone -d passbolt.yourcompany.com
```

Get a free Let's Encrypt certificate, then add these volumes to your docker-compose-ce.yaml:

```
volumes:
  - /etc/letsencrypt/live/your-domain.com/fullchain.pem:/etc/ssl/certs/certificate.crt:ro
  - /etc/letsencrypt/live/your-domain.com/privkey.pem:/etc/ssl/certs/certificate.key:ro
ports:
  - "80:80"
  - "443:443"
```

### Set permissions and restart:

```
sudo chmod 644 /etc/letsencrypt/live/yourdomain.com/fullchain.pem /etc/letsencrypt/live/yourdomain.com/privkey.pem
docker compose -f docker-compose-ce.yaml up -d
```