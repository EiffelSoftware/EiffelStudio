#!/bin/bash

#####################
# Optional settings #
#####################

#export SVN_EIFFELSTUDIO_REPO_REVISION=103046
#export SVN_ISE_BRANCH=/branches/Eiffel_19.12
#export SVN_EIFFELSTUDIO_BRANCH=/branches/Eiffel_19.12


include_enterprise=false

include_64bits="true"
#include_64bits="false"
include_32bits="true"
#include_32bits="false"

./build_deliveries.sh

