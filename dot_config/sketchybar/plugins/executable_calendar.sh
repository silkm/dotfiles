#!/bin/bash

BINARY="$HOME/.cache/sketchybar/calendar-events"
SWIFT_SRC="$HOME/.config/sketchybar/plugins/calendar_events.swift"

if [ ! -f "$BINARY" ] || [ "$SWIFT_SRC" -nt "$BINARY" ]; then
    mkdir -p "$HOME/.cache/sketchybar"
    swiftc -O "$SWIFT_SRC" -o "$BINARY" 2>/dev/null
fi

RESULT=$("$BINARY" 2>/dev/null)

[ -z "$RESULT" ] && sketchybar --set "$NAME" drawing=off && exit 0

NOW=$(date +%s)
LABEL=""

while IFS= read -r EVENT; do
    TS="${EVENT%%|||*}"
    TITLE="${EVENT##*|||}"
    [ -z "$TS" ] && continue
    DELTA=$((TS - NOW))
    [ "$DELTA" -le 0 ] || [ "$DELTA" -gt 300 ] && continue
    TIME=$(date -r "$TS" +"%H:%M")
    if [ "$DELTA" -le 60 ]; then
        LABEL="!!! $TIME: $TITLE"
    else
        LABEL="$TIME: $TITLE"
    fi
    break
done <<< "$RESULT"

if [ -n "$LABEL" ]; then
    sketchybar --set "$NAME" label="$LABEL" drawing=on
else
    sketchybar --set "$NAME" drawing=off
fi
