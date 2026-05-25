# Email Setup with Mailtrap

## Step 1: Set Up Your Mailtrap Account

1. Go to Mailtrap.io and sign up (free tier works).

2. Verify your email address.

3. In the Mailtrap dashboard, go to Transactional → Add Domain (e.g., yourcompany.com).

4. Follow Mailtrap’s DNS verification steps – this proves you own the domain and prevents spammers from impersonating you.

5. Once verified, collect these credentials:

Username (your Mailtrap username)

Password (SMTP password from Mailtrap)

Server: live.smtp.mailtrap.io

Port: 587

## Step 2: Connect Passbolt to Mailtrap

1. Log into Passbolt as an administrator.

2. Go to Administration → Email Server.

3. Select “Other” as the email provider.

4. Enter the Mailtrap details:

SMTP Host: live.smtp.mailtrap.io

Username: (your Mailtrap username)

Password: (your Mailtrap password)

Port: 587

TLS: ON (this encrypts your emails)

5. Set your Sender Identity:

Sender Name: e.g., YourCompany IT Team

Sender Email: passbolt@yourcompany.com

## Step 3: Test It

Click “Send Test Email” – enter your own email address.
If it arrives (check spam just in case), you’re done! If not, double‑check:

Username/password are correct.

TLS is enabled and port is 587.

Your domain is fully verified in Mailtrap.

Troubleshooting emails going to spam?
Make sure you completed Mailtrap’s domain verification and use a professional passbolt@yourcompany.com sender address – avoid generic noreply.

Result: Your critical password alerts, reset requests, and invitations will now reach your team reliably – no more missed security notifications.