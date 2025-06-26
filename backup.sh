#!/bin/bash

# === Configuration ===
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M")
BACKUP_DIR="./config"
LOG_FILE="backup_$TIMESTAMP.log"
FILES_TO_BACKUP=(
    "$HOME/.bashrc"
    "$HOME/.vimrc"
    "$HOME/.gitconfig"
)

# === Create backup directory ===
mkdir -p "$BACKUP_DIR"

echo "[$(date)] Starting backup..." | tee "$LOG_FILE"

# === Copy selected files ===
for FILE in "${FILES_TO_BACKUP[@]}"; do
    if [ -f "$FILE" ]; then
        cp "$FILE" "$BACKUP_DIR/$(basename "$FILE" | sed 's/^\.//')"
        echo " Backed up: $FILE" | tee -a "$LOG_FILE"
    else
        echo "File not found, skipped: $FILE" | tee -a "$LOG_FILE"
    fi
done

# === Git operations ===
cd "$BACKUP_DIR" || exit 1
git add .
git commit -m " Auto-backup: $TIMESTAMP" >> ../"$LOG_FILE" 2>&1
git push origin main >> ../"$LOG_FILE" 2>&1

cd ..
echo "[$(date)] Backup completed." | tee -a "$LOG_FILE"

# === Slack operations ===
SLACK_WEBHOOK="https://hooks.slack.com/services/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"

curl -X POST -H 'Content-type: application/json' \
--data "{\"text\":\"✅ Backup completed successfully on $(date)\"}" \
$SLACK_WEBHOOK

