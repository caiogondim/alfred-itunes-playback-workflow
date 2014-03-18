#!/usr/bin/osascript

-- Source: http://stackoverflow.com/questions/14674517/how-to-set-itunes-11-in-shuffle-or-repeat-mode-via-applescript

on getShuffleType() -- the return value is a string: Off/By Songs/By Albums/By Groupings
  tell application "System Events"
    tell process "iTunes"
      set menuItems to menu items of menu bar 1's menu bar item "Controls"'s menu 1's menu item "Shuffle"'s menu 1
      set onOffItemName to name of item 1 of menuItems
    end tell
  end tell

  -- is shuffle off
  ignoring case
    if onOffItemName contains " on " then return "Off"
  end ignoring

  -- shuffle is on so find how we are shuffling
  set currentChoice to "Unknown"
  tell application "System Events"
    tell process "iTunes"
      repeat with i from 2 to count of menuItems
        set anItem to item i of menuItems
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
end getShuffleType

on setShuffleType(shuffleType) -- shuffleType is a string:  Off/By Songs/By Albums/By Groupings
  set currentValue to my getShuffleType()

  script subs
    on toggleShuffleOnOff()
      tell application "System Events" to perform action "AXPress" of (first menu item of process "iTunes"'s menu bar 1's menu bar item "Controls"'s menu 1's menu item "Shuffle"'s menu 1 whose name ends with "Shuffle")
    end toggleShuffleOnOff

    on pressBySongs()
      tell application "System Events" to perform action "AXPress" of (first menu item of process "iTunes"'s menu bar 1's menu bar item "Controls"'s menu 1's menu item "Shuffle"'s menu 1 whose name ends with "Songs")
    end pressBySongs

    on pressByAlbums()
      tell application "System Events" to perform action "AXPress" of (first menu item of process "iTunes"'s menu bar 1's menu bar item "Controls"'s menu 1's menu item "Shuffle"'s menu 1 whose name ends with "Albums")
    end pressByAlbums

    on pressByGroupings()
      tell application "System Events" to perform action "AXPress" of (first menu item of process "iTunes"'s menu bar 1's menu bar item "Controls"'s menu 1's menu item "Shuffle"'s menu 1 whose name ends with "Groupings")
    end pressByGroupings
  end script

  ignoring case
    if shuffleType contains "off" then -- we have to make sure it's off
      if currentValue does not contain "off" then subs's toggleShuffleOnOff()
    else
      -- make sure it's on
      if currentValue contains "off" then subs's toggleShuffleOnOff()

      -- select the shuffle menu item for the type
      if shuffleType contains "song" and currentValue does not contain "song" then
        subs's pressBySongs()
      else if shuffleType contains "album" and currentValue does not contain "album" then
        subs's pressByAlbums()
      else if shuffleType contains "group" and currentValue does not contain "group" then
        subs's pressByGroupings()
      end if
    end if
  end ignoring
end setShuffleType


on alfred_script(q)
  setShuffleType(q as string)
end alfred_script
