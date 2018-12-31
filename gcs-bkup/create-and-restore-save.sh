#!/bin/bash
mkdir -p "$SAVE_DIR"
gsutil -m rsync -d -r "$GCS_SAVE_URL" "$SAVE_DIR"
