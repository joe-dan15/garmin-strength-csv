#!/usr/bin/env bash
# 1) write GarminConnectConfig.json from secrets
mkdir -p "$HOME/.GarminDb"
jq -n \
  --arg u "$GARMIN_USER" \
  --arg p "$GARMIN_PASS" \
  --arg d "${START_DATE_LOCAL:-2020-01-01}" \
  '{username:$u, password:$p, start_date_local:$d}' \
  > "$HOME/.GarminDb/GarminConnectConfig.json"

# 2) run GarminDB: update & export
~/.local/bin/garmindb_cli --latest --download --import --analyze
~/.local/bin/garmindb_cli --export activities --output garmin_activities.csv

chmod +x run.sh
