#!/bin/sh
set -e

base_version="$(cat package.json | jq -r .version | cut -d. -f1-2)"
date_version="$base_version.$(date +%Y%m%d)"

./script/update_db.sh

if [ -z "$(git status -s -uno)" ]; then
  echo "No changes to published database"
  exit 0
fi

sed -i '' -e 's/"version": ".*"/"version": "'$date_version'"/' package.json
git add data package.json
git commit -m "Auto-update to $date_version"
