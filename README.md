# 🛡️ DotBackup

**DotBackup** is a lightweight Bash-based tool to back up and restore your Linux dotfiles like `.bashrc`, `.gitconfig`, etc.

It includes:
- GitHub integration for version control
- Cron-based scheduling for daily automation
- Slack notifications to keep you informed

---

## ✨ Features

- ✅ Backup selected dotfiles (e.g. `.bashrc`, `.vimrc`, `.gitconfig`)
- 🔁 Restore these files to a new machine in seconds
- 🌍 Automatically push backups to GitHub
- 🕒 Schedule automatic backups via `cron`
- 🔔 Receive Slack messages when a backup completes

---

## 📁 Folder Structure

```
dotbackup/
├── backup.sh       # Backup script
├── restore.sh      # Restore script
├── config/         # Where backed-up files live
├── *.log           # Timestamped logs (can also be used for cron output)
└── README.md
```
---

🚀 How to Use
🔁 Backup
bash

./backup.sh
This script:

Copies selected files to the config/ folder

Commits & pushes them to GitHub

Sends a Slack notification on success

###  🔄 Restore

bash
./restore.sh

# ⚙️ Setup
1. Clone the Repo

git clone https://github.com/yourusername/dotbackup.git
cd dotbackup
chmod +x *.sh

2. Select Files to Back Up
   Edit inside backup.sh:

FILES_TO_BACKUP=(
  "$HOME/.bashrc"
  "$HOME/.vimrc"
  "$HOME/.gitconfig"
)

3. Set Your Slack Webhook
   Edit inside backup.sh:

bash
SLACK_WEBHOOK="https://hooks.slack.com/services/your/webhook/url"

⏰ Automate with Cron

Edit your crontab:
crontab -e

Add this line to back up daily at 8 PM:
0 20 * * * /full/path/to/dotbackup/backup.sh


