case $CONFIG in
'')
    if test -f config.sh; then TOP=.;
    elif test -f ../config.sh; then TOP=..;
    elif test -f ../../config.sh; then TOP=../..;
    elif test -f ../../../config.sh; then TOP=../../..;
    elif test -f ../../../../config.sh; then TOP=../../../..;
    else
        echo "Can't find config.sh."; exit 1
    fi
    . $TOP/config.sh
    ;;
esac
case "$0" in
*/*) cd `expr X$0 : 'X\(.*\)/'` ;;
esac
CURRENT=.
DIR=`echo $CURRENT/ | sed -e 's/\.\///g'`
echo "Extracting ${DIR}Makefile (with variable substitutions)"
$spitshell >Makefile <<!GROK!THIS!

CC=$cc
CFLAGS=$ccflags $optimize \$(INCLUDE_PATH)
INCLUDE_PATH=-I../run-time

all:: special_tables.o

special_tables.o : special_tables.c
	\$(CC) \$(CFLAGS) -I../run-time -I. -c special_tables.c

clean::
	\$(RM) *.o 
clobber:: clean
	\$(RM) Makefile *.o
	
Makefiles::
!GROK!THIS!
