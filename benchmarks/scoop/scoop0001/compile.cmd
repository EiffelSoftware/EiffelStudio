call ec -finalize -config scoopquery.ecf
cd EIFGENs\scoopquery\F_code
call finish_freezing
copy scoopquery.exe ..\..\..
cd ..\..\..
del *.rc
rmdir /S /Q EIFGENs