#!/local/bin/bash

# system:     "Eiffel scanner"
# compiler:   "SmallEiffel -0.78"
# author:     "Eric Bezault <ericb@gobo.demon.co.uk>"
# copyright:  "Copyright (c) 1999, Eric Bezault"
# date:       "$Date$"
# revision:   "$Revision$"


echo ${GOBO}/example/lexical/eiffel/>		loadpath.se

#		-- Gobo Eiffel Lexical Library
echo ${GOBO}/library/lexical/skeleton/>>	loadpath.se

#		-- Gobo Eiffel Utility Library
echo ${GOBO}/library/utility/support/>>		loadpath.se

#		-- Gobo Eiffel Kernel Library
echo ${GOBO}/library/kernel/>>				loadpath.se
echo ${GOBO}/library/kernel/spec/se/>>		loadpath.se

#		-- SmallEiffel Kernel
# echo ${SmallEiffelDir}/lib_std/>>			loadpath.se


export geoptions="-boost -no_split -no_style_warning -no_gc"
compile $geoptions EIFFEL_SCANNER benchmark
