ec -experiment -config $XEBRA_DEV/eiffel_projects/library/xebra_precompile/xebra_precompile.ecf -target xebra_precompile -c_compile -clean -precompile
ec -experiment -config $XEBRA_DEV/eiffel_projects/xebra_translator/xebra_translator-voidunsafe.ecf -target xebra_translator -c_compile -clean -finalize
ec -experiment -config $XEBRA_DEV/eiffel_projects/xebra_server/xebra_server-voidunsafe.ecf -target xebra_server -c_compile -clean 
