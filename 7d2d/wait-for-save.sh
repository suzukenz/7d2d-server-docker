#!/bin/bash
# Wait for save directory is to be prepared by other container.
set -e

SAVE_DIR=$APP_ROOT/Save

shift
cmd="$*"

echo "$SAVE_DIR"
while [ -z "$(ls -A "$SAVE_DIR")" ]; do
  >&2 echo "Save directory is unavailable - sleeping"
  sleep 1
done

>&2 echo "Save directory is up - executing command"
exec $cmd
