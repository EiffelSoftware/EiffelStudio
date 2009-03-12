mkdir ../tmp
cp clean.sh compile_all.sh configure.in client.c server.c Makefile.am xebrasockets.c xebrasockets.h ../tmp/
rm -Rf *
rm -Rf .libs
rm -Rf .deps
cp ../tmp/*.* .
rm -Rf ../tmp
