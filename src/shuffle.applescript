#!/usr/bin/osascript

tell application "System Events"
    tell process "iTunes"
        click menu item 1 of menu 1 of menu item "Shuffle" of menu 1 ¬
        		of menu bar item "Controls" of menu bar 1
    end tell
end tell
