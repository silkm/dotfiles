set meetFound to false

-- ---------------------------------------------------------
-- PART 1: CHECK GOOGLE CHROME (works for Tabs & PWA)
-- ---------------------------------------------------------
try
    tell application "Google Chrome"
        repeat with w in windows
            repeat with t in tabs of w
                if URL of t starts with "https://meet.google.com" then
                    execute t javascript "var btn = document.querySelector('button[aria-label^=\"Turn\"][aria-label*=\"microphone\"]'); if (btn) { btn.click(); }"
                    set meetFound to true
                    exit repeat
                end if
            end repeat
            if meetFound then exit repeat
        end repeat
    end tell
on error
    set meetFound to false
end try

-- ---------------------------------------------------------
-- PART 2: CHECK GATHER OR FALLBACK
-- ---------------------------------------------------------
if meetFound is false then
    tell application "System Events"
        set runningProcesses to name of every application process

        if "Gather" is in runningProcesses then
            set currentAppProcess to first application process whose frontmost is true
            set currentAppName to name of currentAppProcess

            tell process "Gather"
                set frontmost to true
            end tell

            delay 0.1

            keystroke "a" using {command down, shift down}

            tell process currentAppName
                set frontmost to true
            end tell

        else
            keystroke "a" using {command down, shift down}
        end if
    end tell
end if
