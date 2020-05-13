note
	description: "Summary description for {WRAPC_MAKEFILES_GENERATOR}."
	date: "$Date$"
	revision: "$Revision$"

class
	WRAPC_MAKEFILES_GENERATOR

inherit

	EWG_ABSTRACT_GENERATOR

create
	make

feature -- Generator


feature -- Generation

	generate (a_eiffel_wrapper_set: EWG_EIFFEL_WRAPPER_SET)
		local
			object_name: STRING
			directory_name: STRING
			l_content: STRING
		do
			object_name := if attached (create {PATH}.make_from_string (directory_structure.callback_c_glue_code_object_name (eiffel_compiler_mode.eiffel_compiler_mode))).entry as l_entry then l_entry.out else "" end
			directory_name := if attached  (create {PATH}.make_from_string (directory_structure.wrapper_directory_name)).entry as l_entry then l_entry.out else "" end

			if object_name.is_empty or else directory_name.is_empty then
				error_handler.report_warning_message ("Can't build Makefiles Object name or Wrapper directory namea Unkown !!!")
			else
					-- Linux
				create l_content.make_from_string (makefile_linux)

					-- $EIF_LIBARY_NAME, $OBJECT_LIST, $OUTPUT_DIRECTORY $LIBRARY_NAME
				l_content.replace_substring_all ("$EIF_LIBARY_NAME", "eif_" + directory_structure.config_system.name)
				l_content.replace_substring_all ("$OBJECT_LIST", object_name + ".o")
				l_content.replace_substring_all ("$OUTPUT_DIRECTORY", directory_name)
				l_content.replace_substring_all ("$LIBRARY_NAME", directory_structure.config_system.name)
				create_make_file (makefilename, l_content)

					-- Windows
				create l_content.make_from_string (makefile_windows)

					-- $EIF_LIBARY_NAME, $OBJECT_LIST, $OUTPUT_DIRECTORY
					-- $INCLUDE_PATH
				l_content.replace_substring_all ("$EIF_LIBARY_NAME", "eif_" + directory_structure.config_system.name)
				l_content.replace_substring_all ("$OBJECT_LIST", object_name + ".$obj")
				l_content.replace_substring_all ("$OUTPUT_DIRECTORY", directory_name)
				if directory_structure.config_system.include_path.is_empty then
					l_content.replace_substring_all ("$INCLUDE_PATH", "")
				else
					if
						attached directory_structure.config_system.include_path.entry as l_entry and then
						not l_entry.out.is_case_insensitive_equal ("include")
					then
						l_content.replace_substring_all ("$INCLUDE_PATH", l_entry.out)
					else
						l_content.replace_substring_all ("$INCLUDE_PATH", "")
					end
				end
				create_make_file (makefilename_win, l_content)
			end
		end



feature -- Makefile build

	create_make_file (a_makefile_name: STRING; a_content: STRING)
		local
			l_raw_file: RAW_FILE
		do
			create l_raw_file.make_create_read_write ((create {PATH}.make_from_string (directory_structure.c_src_directory_name)).extended (a_makefile_name).name)
			l_raw_file.put_string (a_content)
			l_raw_file.flush
			l_raw_file.close
		end


feature {NONE} -- Implementation

	makefilename: STRING = "Makefile.SH"
		-- Linux makefilename

	makefilename_win: STRING = "Makefile-win.SH"
		-- Windows makefilename.


	Makefile_windows: STRING = "[
TOP = ..
DIR = $dir_sep
OUTDIR= .
INDIR= .
CC = $cc
OUTPUT_CMD = $output_cmd
CFLAGS = -I"$rt_include" -I $(TOP)$(DIR)include -I $(TOP)$(DIR)$(TOP)$(DIR)$(TOP)$(DIR)$OUTPUT_DIRECTORY$(DIR)c$(DIR)include -I $(TOP)$(DIR)$(TOP)$(DIR)$(TOP)$(DIR)C$(DIR)include$INCLUDE_PATH  
JCFLAGS = $(CFLAGS) $optimize $ccflags
JMTCFLAGS = $(CFLAGS) $optimize $mtccflags
JILCFLAGS = $(CFLAGS) $optimize $mtccflags  -DEIF_IL_DLL
LN = copy
MV = $mv
RM = $del
MAKE = $make
MKDIR = $mkdir
OBJECTS = $OBJECT_LIST

.c.$obj:
	$(CC) -c $(JCFLAGS) $<

all:: standard
	$(MAKE) clean

standard:: $EIF_LIBARY_NAME.lib

clean:
	$(RM) *.$obj
	$(RM) *.lib

$EIF_LIBARY_NAME.lib: $(OBJECTS)
	$alib_line
	$(MKDIR) $(TOP)$(DIR)$(TOP)$(DIR)$(TOP)$(DIR)C$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib
	$(MV) $@ $(TOP)$(DIR)$(TOP)$(DIR)$(TOP)$(DIR)C$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib$(DIR)$@
]"



	Makefile_linux:  STRING = "[
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
CFLAGS = $optimize $ccflags $large -I$rt_include -I../../../$OUTPUT_DIRECTORY/c/include -I../include `pkg-config --cflags $LIBRARY_NAME` -I../../../C/include
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

OBJECTS = $OBJECT_LIST

$EIF_LIBARY_NAME.a: $(OBJECTS)
	mkdir -p ../../../C/spec/$(PLATFORM)/lib
	$(RM) $@
	$(AR) $@ $(OBJECTS)
	$(MV) $@ ../../../C/spec/$(PLATFORM)/lib
	$(RANLIB) ../../../C/spec/$(PLATFORM)/lib/$@
	$(MAKE) clean

	#$(RM) $EIF_LIBARY_NAME.a $(OBJECTS) Makefile config.sh
clean:
	$(RM) $EIF_LIBARY_NAME.a $(OBJECTS)
!NO!SUBS!
chmod 644 Makefile
$eunicefix Makefile
]"
	--$EIF_LIBARY_NAME, $OBJECT_LIST, $OUTPUT_DIRECTORY

end
