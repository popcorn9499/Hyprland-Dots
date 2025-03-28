#!/bin/bash

# Extract the battery percentage specifically for the G502 X LIGHTSPEED
BATTERY_LEVEL=$(solaar show | awk '
  $0 ~ /G502 X LIGHTSPEED/ { in_device = 1; next }
  in_device && $0 ~ /Battery:/ {
    match($0, /Battery: ([0-9]+)%/, m)
    if (m[1] != "") {
      print m[1]
      exit
    }
  }
' 2>/dev/null)

if [ -z "$BATTERY_LEVEL" ]; then
    echo '{"text": "🖱: ?", "tooltip": "Battery info not found"}'
    exit 0
fi

echo "{\"text\": \"🖱 ${BATTERY_LEVEL}%\", \"tooltip\": \"G502 Battery: ${BATTERY_LEVEL}%\", \"percentage\": ${BATTERY_LEVEL}}"
