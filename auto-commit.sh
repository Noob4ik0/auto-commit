#!/bin/bash
# auto-commit.sh — daily GitHub activity commit
# Add to cron: 0 12 * * * /root/github-repos/auto-commit/auto-commit.sh >> /root/github-repos/auto-commit/cron.log 2>&1

REPO_DIR="$(dirname "$0")"
LOG_FILE="$REPO_DIR/activity.log"
DATE="$(date '+%Y-%m-%d %H:%M:%S')"

cd "$REPO_DIR" || exit 1

# Check git is configured
if ! git -C "$REPO_DIR" rev-parse --git-dir > /dev/null 2>&1; then
    echo "[$DATE] ERROR: not a git repo" >> "$LOG_FILE"
    exit 1
fi

# Write today's entry
echo "[$DATE] daily check-in" >> "$LOG_FILE"

git add activity.log
git commit -m "chore: daily activity $(date '+%Y-%m-%d')" --quiet 2>/dev/null || true
git push origin main --quiet 2>/dev/null

echo "[$DATE] pushed to GitHub" | tee -a "$LOG_FILE"
