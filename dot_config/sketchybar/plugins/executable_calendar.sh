#!/bin/bash

RESULT=$(osascript -e '
set eventStrings to {}
tell application "Calendar"
    set nowDate to current date
    set endDate to nowDate + (5 * 60)
    repeat with aCal in every calendar
        set calEvents to (every event of aCal whose start date >= nowDate and start date <= endDate)
        repeat with e in calEvents
            set sd to start date of e
            set y to year of sd as string
            set mo to text -2 thru -1 of ((100 + (month of sd as integer)) as string)
            set d to text -2 thru -1 of ((100 + (day of sd)) as string)
            set h to text -2 thru -1 of ((100 + (hours of sd)) as string)
            set mi to text -2 thru -1 of ((100 + (minutes of sd)) as string)
            copy (y & "-" & mo & "-" & d & "T" & h & ":" & mi & "|||" & (summary of e)) to end of eventStrings
        end repeat
    end repeat
end tell
set text item delimiters to "~~~"
set output to eventStrings as text
set text item delimiters to ""
return output
' 2>/dev/null)

[ -z "$RESULT" ] && sketchybar --set "$NAME" drawing=off && exit 0

NOW=$(date +%s)
LABEL=""

IFS='~~~' read -ra EVENTS <<< "$RESULT"
for EVENT in "${EVENTS[@]}"; do
    DATESTR="${EVENT%%|||*}"
    TITLE="${EVENT##*|||}"
    EVENT_TS=$(date -j -f "%Y-%m-%dT%H:%M" "$DATESTR" +%s 2>/dev/null)
    [ -z "$EVENT_TS" ] && continue
    [ "$EVENT_TS" -le "$NOW" ] && continue
    DELTA=$((EVENT_TS - NOW))
    [ "$DELTA" -gt 300 ] && continue
    TIME=$(date -j -f "%Y-%m-%dT%H:%M" "$DATESTR" +"%H:%M" 2>/dev/null)
    if [ "$DELTA" -le 60 ]; then
        LABEL="!!! $TIME: $TITLE"
    else
        LABEL="$TIME: $TITLE"
    fi
    break
done

if [ -n "$LABEL" ]; then
    sketchybar --set "$NAME" label="$LABEL" drawing=on
else
    sketchybar --set "$NAME" drawing=off
fi
