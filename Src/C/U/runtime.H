/* AddSource:
 *	Generate source list for make depend.
 */
#define AddSource(srclist)	@!\
++SOURCES srclist @!

/*
 * CustomLibraryTarget:
 *      Generate rules to create a library. The 'objlist'
 *      parameters are added to OBJECTS macros.
 */
#define CustomLibraryTarget(libname,objlist)    @!\
>RM @!\
>AR @!\
>RANLIB @!\
++OBJECTS objlist @!\
NormalLibraryObjectRule()               @!\
AllTarget(lib^^libname.a)               @!\
                                                                @!\
lib^^libname.a: objlist                 @@\
        $(RM) $@                                        @@\
        $(AR) $@ objlist                        @@\
        $(RANLIB) $@


/*
 * CustomSharedLibraryTarget:
 *      Generate rules to create a shared library; build it into a
 *      different name so that the we don't hose people by having the
 *      library gone for long periods.
 */
#define CustomSharedLibraryTarget(libname,objlist)      @!\
>RM @!\
>SHAREDLINK @!\
>LDSHAREDFLAGS @!\
AllTarget(lib^^libname.so)      @!\
                                                                        @!\
lib^^libname.so:  objlist           @@\
        $(RM) $@                                                @@\
        $(SHAREDLINK) $(LDSHAREDFLAGS) $@ objlist               @@\

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

/*
 * CustomObjectTarget:
 *      Generate rules to create an object file. The 'objlist'
 *      parameters are added to OBJECTS macros.
 */
#define CustomObjectTarget(objlist)    @!\
++OBJECTS objlist @!\
AllTarget(objlist)

