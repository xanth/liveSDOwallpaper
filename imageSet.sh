#!/bin/sh
FILE="$1/theSun.jpg"

/usr/bin/osascript <<END
tell application "Finder"
  set myFile to POSIX file "$FILE" as string
  set desktop picture to file myFile
end tell
END