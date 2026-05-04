#!/bin/bash
set -e

echo "🔨 Rebuilding APT repo metadata..."
./scripts/build.sh

echo "📂 Staging changes..."
git add dists pool scripts

echo "📊 Status:"
git status --short

echo "📦 Committing changes (if any)..."
if ! git diff --cached --quiet; then
    git commit -m "Update APT repo"
else
    echo "No changes to commit"
fi

echo "📥 Syncing with remote..."
git fetch origin main
git pull --rebase origin main

echo "📤 Pushing to GitHub..."
git push origin main

echo ""
echo "✅ APT repo updated successfully."
echo "⏳ Wait 2–5 minutes before running apt update."
