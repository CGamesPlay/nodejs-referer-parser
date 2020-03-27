#!/bin/sh
set -e

#latest_db="https://s3-eu-west-1.amazonaws.com/snowplow-hosted-assets/third-party/referer-parser/referers-latest.yaml"
# Use fork while I've got a PR out
latest_db="https://raw.githubusercontent.com/CGamesPlay/referer-parser/master/resources/referers.yml"

if ! which -s yaml2json; then
  echo "yaml2json not in PATH. Get it from here:" >&2
  echo "https://github.com/wakeful/yaml2json" >&2
  exit 1
fi

if ! which -s prettier; then
  echo "prettier not in PATH. Run npm install." >&2
  exit 1
fi

function check_yaml2json() {
  if ! yaml2json -version | grep -q wakeful >/dev/null; then
    echo "" >&2
    echo "yaml2json may be a different version, use the one from here:" >&2
    echo "https://github.com/wakeful/yaml2json" >&2
  fi
  return 1
}

wget -qO data/referers.yml "$latest_db"

yaml2json data/referers.yml | prettier --parser json > data/referers.json || check_yaml2json

rm data/referers.yml

echo "Referers database updated"
