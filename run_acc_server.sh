#!/bin/bash
rm ./cfg/settings.json
git pull
echo "..."
echo "..."
adminpass=`cat admin.pass`
specpass=`cat spectator.pass`
echo "admin pass set: $adminpass"
echo "spectator pass set: $specpass"
tmp=$(mktemp)
jq --arg a "$adminpass" '.adminPassword = $a' ./cfg/settings_template.json > "$tmp" && mv "$tmp" temp.json
jq --arg a "$specpass" '.spectatorPassword = $a' temp.json > ./cfg/settings.json && rm temp.json

echo "Starting ACC Server"
wine ./accServer.exe | sed -r '/Server was running late/d'
