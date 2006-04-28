#!/bin/sh

/usr/bin/find . -name "*.acex" -exec $EIFFEL_SRC/Eiffel/library/configuration/versioning/update_acex.sh {} \;
