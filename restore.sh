#!/bin/bash

# === Config ===
SOURCE_DIR="./config"
LOG_FILE="restore_$(date +'%Y-%m-%d_%H-%M').log"

# === List of files to restore (from config/ to $HOME)
FILES_TO_RESTORE=(
    "bashrc"
    "vimrc"
    "gitconfig"
)

echo "[$(date)] Starting restore..." | tee "$LOG_FILE"

# === Restore loop ===
for FILE in "${FILES_TO_RESTORE[@]}"; do
    SOURCE_FILE="$SOURCE_DIR/$FILE"
    TARGET_FILE="$HOME/.$FILE"

    if [ -f "$SOURCE_FILE" ]; then
        cp "$SOURCE_FILE" "$TARGET_FILE"
        echo "✓ Restored: $TARGET_FILE" | tee -a "$LOG_FILE"
    else
        echo "⚠️ Missing file: $SOURCE_FILE (skipped)" | tee -a "$LOG_FILE"
    fi
done

echo "[$(date)] Restore completed." | tee -a "$LOG_FILE"

