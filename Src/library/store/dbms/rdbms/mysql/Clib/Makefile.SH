case $CONFIG in
'')
    if test ! -f config.sh; then
        (echo "Can't find config.sh."; exit 1)
    fi 2>/dev/null
    . ./config.sh
    ;;
esac
case "$O" in
*/*) cd `expr X$0 : 'X\(.*\)/'` ;;
esac
echo "Extracting "."/Makefile (with variable substitutions)"
$spitshell >Makefile <<!GROK!THIS!
SHELL = /bin/sh
CC= $cc
AR = ar rc
CFLAGS = $optimize $ccflags $large -I$rt_include `${ISE_LIBRARY}/library/store/dbms/rdbms/mysql/Clib/mysql-config --cflags`
LDFLAGS = $ldflags
LIBS = $libs
MAKE = $make
MKDEP = $mkdep \$(DPFLAGS) --
MV = $mv
RANLIB = $ranlib
RM = $rm -f
PLATFORM = $ISE_PLATFORM

!GROK!THIS!
$spitshell >>Makefile <<'!NO!SUBS!'
.c.o:
	$(CC) $(CFLAGS) -c $<

OBJECTS = eif_mysql.o

libmysql_store.a: $(OBJECTS)
	mkdir -p ../../../../spec/$(PLATFORM)/lib
	$(RM) $@
	$(AR) $@ $(OBJECTS)
	$(MV) $@ ../../../../spec/$(PLATFORM)/lib
	$(RANLIB) ../../../../spec/$(PLATFORM)/lib/$@
	$(MAKE) clean

	#$(RM) libmysql_store.a $(OBJECTS) Makefile config.sh
clean:
	$(RM) libmysql_store.a $(OBJECTS)
!NO!SUBS!
chmod 644 Makefile
$eunicefix Makefile

