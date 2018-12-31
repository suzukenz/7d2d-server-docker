#!/bin/bash
if [ -z "$(ls -A "$SAVE_DIR")" ]; then
  echo "Save directory is empty."
  echo "Get save data from gcs..."
  ./create-and-restore-save.sh
else
  echo "Save directory is already exist."
fi

busybox crond -f -L /dev/stderr
