#!/bin/bash

#####################
# Optional settings #
#####################

#export SVN_EIFFELSTUDIO_REPO_REVISION=103046
export SVN_ISE_BRANCH=/branches/Eiffel_20.05
export SVN_EIFFELSTUDIO_BRANCH=/branches/Eiffel_20.05


export include_enterprise=true

export include_64bits="true"
#export include_64bits="false"
export include_32bits="true"
#export include_32bits="false"

./build_deliveries.sh

