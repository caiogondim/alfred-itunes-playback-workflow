#!/usr/bin/osascript

-- Source: http://stackoverflow.com/questions/14674517/how-to-set-itunes-11-in-shuffle-or-repeat-mode-via-applescript

on getRepeatType() -- the return value is a string: Off/All/One
  tell application "System Events"
    tell process "iTunes"
      set menuItems to menu items of menu bar 1's menu bar item "Controls"'s menu 1's menu item "Repeat"'s menu 1
      set currentChoice to "unknown"
      repeat with anItem in menuItems
        try
          set theResult to value of attribute "AXMenuItemMarkChar" of anItem
          if theResult is not "" then
            set currentChoice to name of anItem
            exit repeat
          end if
        end try
      end repeat
    end tell
  end tell
  return currentChoice
end getRepeatType

on setRepeatType(repeatType) -- repeatType is a string: Off/All/One
  set currentValue to my getRepeatType()
  ignoring case
    tell application "System Events" to tell process "iTunes"'s menu bar 1's menu bar item "Controls"'s menu 1's menu item "Repeat"'s menu 1
      if repeatType is "all" then
        perform action "AXPress" of menu item "All"
      else if repeatType is "one" then
        perform action "AXPress" of menu item "One"
      else
        perform action "AXPress" of menu item "Off"
      end if
    end tell
  end ignoring
end setRepeatType

on alfred_script(q)
  setRepeatType(q as string)
end alfred_script
