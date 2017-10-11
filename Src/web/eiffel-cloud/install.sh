#!/bin/bash

if [ ! -f "./roc" ]; then
	ecb -config $ISE_LIBRARY/unstable/library/web/cms/tools/roc/roc.ecf -target roc -finalize -c_compile -project_path /tmp
	cp /tmp/EIFGENs/roc/F_code/roc roc
fi

./roc install --config roc.cfg
