mkdir ../tmp
cp clean.sh compile_all.sh configure.in install_to_apache.sh Makefile.am mod_xebra.c xebrasockets.c xebrasockets.h ../tmp/
rm -Rf *
rm -Rf .libs
rm -Rf .deps
cp ../tmp/*.* .
rm -Rf ../tmp
