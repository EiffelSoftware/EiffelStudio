#!/bin/bash

EIFFEL_SRC=$PWD/../Src

cd ${EIFFEL_SRC}/C_library/libpng                              && ${ISE_EIFFEL}/studio/spec/${ISE_PLATFORM}/bin/finish_freezing -library
cd ${EIFFEL_SRC}/C_library/zlib                                && ${ISE_EIFFEL}/studio/spec/${ISE_PLATFORM}/bin/finish_freezing -library
cd ${EIFFEL_SRC}/library/cURL/Clib                             && ${ISE_EIFFEL}/studio/spec/${ISE_PLATFORM}/bin/finish_freezing -library
cd ${EIFFEL_SRC}/library/net/Clib                              && ${ISE_EIFFEL}/studio/spec/${ISE_PLATFORM}/bin/finish_freezing -library
cd ${EIFFEL_SRC}/library/vision2/Clib                          && ${ISE_EIFFEL}/studio/spec/${ISE_PLATFORM}/bin/finish_freezing -library
cp -p ${ISE_EIFFEL}/library/vision2/spec/${ISE_PLATFORM}/lib/gtk3_eiffel.o ${EIFFEL_SRC}/library/vision2/spec/${ISE_PLATFORM}/lib/
