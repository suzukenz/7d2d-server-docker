#!/bin/bash
echo "Backup start."
gsutil -m rsync -r "$SAVE_DIR" "$GCS_SAVE_URL"
gsutil -m cp "$LOGS_DIR/output_log*.txt" "$GCS_LOGS_URL"
