/*
 * SpecialLibraryTarget:
 *	Generate rules to create a library. No 'srclist' is needed. The
 *	'flags' are added to 'CFLAGS' macros before re-invokation of make.
 */
#ifdef NEVER
#define SpecialLibraryTarget(libname,objlist,flags)	@!\
>RM @!\
>AR @!\
>RANLIB @!\
++OBJECTS objlist @!\
AllTarget(lib^^libname.a)		@!\
								@!\
lib^^libname.a: objlist			@@\
	$(MAKE) slib^^libname.a CFLAGS='$(CFLAGS) flags' @!\
								@!\
slib^^libname.a: objlist		@@\
	$(RM) lib^^libname.a		@@\
	$(AR) lib^^libname.a objlist	@@\
	$(RANLIB) lib^^libname.a
#endif
#define SpecialLibraryTarget(libname,objlist,flags)	@!\
>RM @!\
>AR @!\
>RANLIB @!\
++OBJECTS objlist @!\
NormalLibraryTarget(libname,/**/,objlist)

/*
 * AddSourceFileC:
 *	Adds the C source file to SOURCES and OBJECTS macros.
 */
#define AddSourceFileC(basename)	@!\
++OBJECTS basename^^.o				@!\
++SOURCES basename^^.c

/*
 * TestProgramTarget:
 *	Makes a small test program by compiling a single source
 *	file with -DTEST.
 */
#define TestProgramTarget(name,source,flags) @!\
>CC @!\
>JCFLAGS @!\
name: source				@@\
	$(CC) $(JCFLAGS) -DTEST flags -o $@ source

