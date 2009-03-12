aclocal
autoheader
libtoolize --force
touch NEWS README AUTHORS ChangeLog
automake --add-missing
autoconf
./configure
make all
