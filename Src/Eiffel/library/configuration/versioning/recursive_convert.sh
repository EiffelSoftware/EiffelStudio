#!/bin/sh

/usr/bin/find . -name "*.ecf" -exec $EIFFEL_SRC/Eiffel/library/configuration/versioning/update_ecf.sh {} \;
