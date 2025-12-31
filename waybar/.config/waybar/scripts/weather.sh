#!/bin/bash

# EDIT THIS: Put your city name here
CITY="Frederick"

# Fetch weather data
WEATHER_DATA=$(curl -s "https://wttr.in/$CITY?format=j1")

# If fetch fails, output a fallback
if [[ $? -ne 0 || -z "$WEATHER_DATA" ]]; then
    echo '{"text": "󰖐", "tooltip": "Offline"}'
    exit 1
fi

# Parse JSON
TEMP=$(echo "$WEATHER_DATA" | jq -r '.current_condition[0].temp_C')
CODE=$(echo "$WEATHER_DATA" | jq -r '.current_condition[0].weatherCode')
DESC=$(echo "$WEATHER_DATA" | jq -r '.current_condition[0].weatherDesc[0].value')

# Map weather codes to icons
case $CODE in
    113) ICON="" ;; 116) ICON="" ;; 119|122) ICON="" ;; 
    143|248|260) ICON="" ;; 176|263|266|281|284|293|296|299|302|305|308) ICON="" ;;
    179|182|185|227|230|323|326|329|332|335|338|350|368|371|374|377) ICON="" ;;
    200|386|389|392|395) ICON="" ;; *) ICON="" ;;
esac

# Clean JSON output
echo "{\"text\":\"$ICON  $TEMP°C\", \"tooltip\":\"$DESC\"}"