copy size.win eif_size.h
copy makefile.win makefile
copy ..\config.win ..\eif_config.h
copy ..\confmagi.h ..\confmagc.h
copy ..\idrs\makefile.win ..\idrs\makefile
copy ..\platform\makefile.win ..\platform\makefile
copy ..\parsing\makefile.win ..\parsing\makefile
copy ..\parsing\shared\makefile.win ..\parsing\shared\makefile
copy ..\parsing\eiffel\makefile.win ..\parsing\eiffel\makefile
copy ..\parsing\eiffel\parser.cwn ..\parsing\eiffel\parser.c
copy ..\parsing\eiffel\parser.hwn ..\parsing\eiffel\parser.h
copy ..\parsing\lace\makefile.win ..\parsing\lace\makefile
copy ..\parsing\lace\lace_y.cwn ..\parsing\lace\lace_y.c
copy ..\parsing\lace\lace_y.hwn ..\parsing\lace\lace_y.h
wmake
cd ..\platform
wmake
cd ..\extra\mswin\ipc
wmake
cd ..\parsing
wmake
