#!/bin/sh
# Let you update recursively files that match a certain pattern and for each matched
# file run the `update_file.sh' script.

/usr/bin/find . -name "*Ace*" -exec $EWEASEL/bin/update_file.sh {} \;
