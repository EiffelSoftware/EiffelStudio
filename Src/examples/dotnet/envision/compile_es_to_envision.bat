cd es_to_envision_src
ec -batch -finalize -ace es_to_envision.ace
cd EIFGEN\F_code
finish_freezing -silent
copy es_to_envision.exe ..\..\..\
cd ..\..\
rd /q /s EIFGEN
del *.epr *.rc
cd ..