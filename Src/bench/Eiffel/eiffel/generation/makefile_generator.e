indexing
	description: "[
		Makefile generation control. The generated Makefile.SH is to be run through
		/bin/sh to get properly instantiated for a given platform. A partial linking
		of `Packet_number' files is done, as needed to avoid kernel internal argument
		space overflow.
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class MAKEFILE_GENERATOR 

inherit
	SHARED_CODE_FILES

	SHARED_COUNTER

	SHARED_GENERATOR

	SHARED_EIFFEL_PROJECT

	COMPILER_EXPORTER

feature -- Attributes

	object_baskets: ARRAY [LINKED_LIST [STRING]]
			-- The entire set of class object files we have 
			-- to make. It contains:
			-- * C code for classes
			-- * C code for descriptors
			-- * C code for feature tables

	system_baskets: ARRAY [LINKED_LIST [STRING]]
			-- The entire set of system object files we have 
			-- to make is generated in the first entry. The
			-- other entries contain the polymorphic routine
			-- and attribute tables.

	cecil_rt_basket: LINKED_LIST [STRING]
			-- Run-time object files to be put in the Cecil
			-- archive

	empty_class_types: SEARCH_TABLE [INTEGER]
			-- Set of all the class types that have no used
			-- features (final mode), i.e. the C file would
			-- be empty.

	partial_system_objects: INTEGER
			-- Number of partial object files needed
			-- for system object files

	Packet_number: INTEGER is 33
			-- Maximum number of files in a single linking phase in Workbench mode.
	
	Final_packet_number: INTEGER is 100
			-- Maximum number of files in a single linking phase in Final mode.

	System_packet_number: INTEGER is 20
			-- Maximum number of files in a single linking phase

feature -- Initialization

	make is
			-- Creation
		do
			create cecil_rt_basket.make
			create empty_class_types.make (50)
		end

	init_objects_baskets is
			-- Create objects baskets.
		local
			basket_nb, i: INTEGER
			system_basket_nb: INTEGER
			basket: LINKED_LIST [STRING]
		do
			if System.in_final_mode then
				basket_nb := 1 + System.static_type_id_counter.count // Final_packet_number
				system_basket_nb := (Rout_generator.file_counter - 1) // System_packet_number + 2
			else
				basket_nb := 1 + System.static_type_id_counter.current_count // Packet_number
				system_basket_nb := 1
			end
			create object_baskets.make (1, basket_nb)
			from i := 1 until i > basket_nb loop
				create basket.make
				object_baskets.put (basket, i)
				i := i + 1
			end

			create system_baskets.make (1, system_basket_nb)
			from i := 1 until i > system_basket_nb loop
				create basket.make
				system_baskets.put (basket, i)
				i := i + 1
			end
		end

	clear is
			-- Forget the lists
		do
			object_baskets := Void
			system_baskets := Void
			cecil_rt_basket := Void
			empty_class_types := Void
		end

feature

	run_time: STRING is
			-- Run time with which the application must be linked
		deferred
		end

	system_name: STRING is
			-- Name of executable
		do
			Result := System.system_name
		end

feature -- Object basket managment

	add_specific_objects is
			-- Add objects specific to Current compilation mode.
		deferred
		end

	add_eiffel_objects is
			-- Insert objects files in basket.
		deferred
		end

	add_in_primary_system_basket (base_name: STRING) is
		local	
			object_name: STRING
 			string_list: LINKED_LIST [STRING]
		do
			!!object_name.make (0)
			object_name.append (base_name)
			object_name.append (".o")
 			string_list := system_baskets.item (1)
			string_list.extend (object_name)
 			string_list.forth 
		end

	add_in_system_basket (base_name: STRING; basket_number: INTEGER) is
		local	
			object_name: STRING
 			string_list: LINKED_LIST [STRING]
		do
			!!object_name.make (0)
			object_name.append (base_name)
			object_name.append (".o")
 			string_list := system_baskets.item (basket_number)
			string_list.extend (object_name)
 			string_list.forth 
		end

	add_common_objects is
			-- Add common objects file
		do
			add_in_primary_system_basket (Eplug)
			add_in_primary_system_basket (Eskelet)
			add_in_primary_system_basket (Evisib)
			add_in_primary_system_basket (Ececil)
			add_in_primary_system_basket (Einit)
			add_in_primary_system_basket (Eparents)
		end

feature -- Cecil

	add_cecil_objects is
		deferred
		end

	generate_cecil is
		do
				-- Cecil run-time macro
			generate_macro ("RCECIL", cecil_rt_basket)

				-- Cecil library prodcution rule
			make_file.putstring ("STATIC_CECIL = lib")
			make_file.putstring (system_name)
			make_file.putstring (".a%N")

			make_file.putstring ("cecil: $(STATIC_CECIL)%N")
			make_file.putstring ("$(STATIC_CECIL): ")
			make_file.putchar (' ')
			make_file.putstring ("$(OBJECTS) %N")
			make_file.putstring ("%T$(AR) x ")
			make_file.putstring ("$(EIFLIB)")
			make_file.new_line
			make_file.putstring ("%T$(AR) cr ")
			make_file.putstring ("$(STATIC_CECIL)")
			make_file.putchar (' ')
			make_file.putstring ("$(OBJECTS) ")
			make_file.putchar (continuation)
			make_file.new_line
			generate_other_objects
			make_file.putstring ("%T%T$(RCECIL)")
			make_file.new_line
			make_file.putstring ("%T$(RANLIB) ")
			make_file.putstring ("$(STATIC_CECIL)%N")
			make_file.putstring ("%T$(RM) $(RCECIL) ")
			make_file.new_line
			make_file.new_line

				-- SHARED_CECIL
			make_file.putstring ("SHARED_CECIL = lib")
			make_file.putstring (system_name)
			make_file.putstring ("$(SHARED_SUFFIX)%N")
			make_file.putstring ("dynamic_cecil: $(SHARED_CECIL) %N")
			make_file.putstring ("SHARED_CECIL_OBJECT = $(OBJECTS) $(EXTERNALS) $(EIFLIB)")
			make_file.putchar (continuation)
			make_file.new_line
			generate_other_objects
			make_file.putstring ("%T%TE1/emain.o")
			make_file.new_line
			make_file.putstring ("SHAREDFLAGS = $(LDSHAREDFLAGS) $(SHARED_CECIL) %N");
			make_file.putstring ("$(SHARED_CECIL): $(SHARED_CECIL_OBJECT) %N")
			make_file.putstring ("%T$(RM) $(SHARED_CECIL) %N")
			make_file.putstring ("%T$(SHAREDLINK) $(SHAREDFLAGS) $(SHARED_CECIL_OBJECT) $(SHAREDLIBS) %N")
			
			make_file.new_line
			make_file.new_line
		end

feature -- Generate Dynamic Library

	generate_dynamic_lib is
		local
			egc_dynlib_file: STRING
		do
			-- Generate the line concerning edynlib.o and egc_dynlib.o
			egc_dynlib_file := "egc_dynlib.template"

			-- Generate SYSTEM_IN_DYNAMIC_LIB...
			make_file.putstring ("%Ndynlib: $(SYSTEM_IN_DYNAMIC_LIB) ")

			-- Generate "E1/egc_dynlib.o"
			make_file.putstring ("%N")
			make_file.putchar (System_object_prefix)
			make_file.putint (1)
			make_file.putstring ("/egc_dynlib.o: Makefile $(ISE_EIFFEL)/studio/config/$(ISE_PLATFORM)/templates/")
			make_file.putstring (egc_dynlib_file)
			make_file.putstring ("%N%T$(CP) $(ISE_EIFFEL)/studio/config/$(ISE_PLATFORM)/templates/")
			make_file.putstring (egc_dynlib_file)
			make_file.putstring (" ")
			make_file.putchar (System_object_prefix)
			make_file.putint (1)
			make_file.putstring ("/egc_dynlib.c") 

			make_file.putstring ("%N%Tcd ")
			make_file.putchar (System_object_prefix)
			make_file.putint (1)
			make_file.putstring (" ; $(MAKE) egc_dynlib.o")
			make_file.putstring (" ; cd ..")

			-- Generate "E1/edynlib.o"
			make_file.putstring ("%N")
			make_file.putchar (System_object_prefix)
			make_file.putint (1)
			make_file.putstring ("/edynlib.o: Makefile ")
			make_file.putchar (System_object_prefix)
			make_file.putint (1)
			make_file.putstring ("/edynlib.c ")
			make_file.putstring ("%N%Tcd ")
			make_file.putchar (System_object_prefix)
			make_file.putint (1)
			make_file.putstring (" ; $(MAKE) edynlib.o")
			make_file.putstring (" ; cd ..%N")

			-- Continue the declaration for the SYSTEM_IN_DYNAMIC_LIB
			make_file.putstring ("%NSYSTEM_IN_DYNAMIC_LIB_OBJ = $(EIFLIB) ")
			make_file.putchar (continuation)
			make_file.new_line
			generate_other_objects
			make_file.putstring ("%T%T$(OBJECTS) $(EXTERNALS) E1/edynlib.o E1/egc_dynlib.o ")
			make_file.putstring ("%NDYNLIBSHAREDFLAGS = $(LDSHAREDFLAGS) $(SYSTEM_IN_DYNAMIC_LIB) %N");
			make_file.putstring ("$(SYSTEM_IN_DYNAMIC_LIB): $(SYSTEM_IN_DYNAMIC_LIB_OBJ) %N")
			make_file.putstring ("%T$(RM) $(SYSTEM_IN_DYNAMIC_LIB) %N")
			make_file.putstring ("%T$(SHAREDLINK) $(DYNLIBSHAREDFLAGS) $(SYSTEM_IN_DYNAMIC_LIB_OBJ) $(SHAREDLIBS) %N")
			
			make_file.new_line
			make_file.new_line
		end

feature -- Actual generation

	make_file: INDENT_FILE
		-- File in which we are going to generate the Makefile.

	generate is
			-- Generate make files
		do
			init_objects_baskets
				-- Insert all the class objects in the baskets.
			add_eiffel_objects
				-- Add objects specific to Current compilation mode
			add_specific_objects
				-- Add objects common to all compilation modes.
			add_common_objects
			add_cecil_objects

				-- Generate makefile in subdirectories.
			generate_sub_makefiles (C_prefix, object_baskets)
			generate_sub_makefiles (System_object_prefix, system_baskets)

			make_file := make_f (system.in_final_mode)
			make_file.open_write
				-- Generate main /bin/sh preamble
			generate_preamble
				-- Customize main Makefile macros
			generate_customization
				-- How to produce a .o from a .c file
			generate_compilation_rule

				-- Generate subdir names
			generate_subdir_names

				-- Generate external objects
			generate_externals

				-- Generate executable
			generate_executable

				-- Generate Cecil rules
			generate_cecil

				-- Generate Dynamic Lib rules
			generate_dynamic_lib

				-- Generate cleaning rules
			generate_main_cleaning

				-- End production
			generate_ending

			make_file.close
			object_baskets := Void
			system_baskets := Void
			cecil_rt_basket.wipe_out
		end

feature -- Sub makefile generation

	generate_sub_makefiles (sub_dir: CHARACTER; baskets: ARRAY [LINKED_LIST [STRING]]) is
				-- Generate makefile in subdirectories.
		local
			new_makefile, old_makefile: INDENT_FILE
			baskets_count, i: INTEGER
			f_name: FILE_NAME
			subdir_name: STRING
			basket: LINKED_LIST [STRING]
		do
			old_makefile := make_file
			from
				baskets_count := baskets.count
				i := 1
			until
				i > baskets_count
			loop
				basket := baskets.item (i)
				if not basket.is_empty then
					if system.in_final_mode then
						!!f_name.make_from_string (Final_generation_path)
					else
						!!f_name.make_from_string (Workbench_generation_path)
					end
					create subdir_name.make (5)
					subdir_name.append_character (sub_dir)
					subdir_name.append_integer (i)
					f_name.extend (subdir_name)
					f_name.set_file_name (Makefile_SH)
					!! new_makefile.make (f_name)
					make_file  := new_makefile
					make_file.open_write
						-- Generate main /bin/sh preamble
					generate_sub_preamble
						-- Customize main Makefile macros
					generate_customization
						-- How to produce a .o from a .c file
					generate_compilation_rule
						-- Generate object list.
					generate_macro ("OBJECTS", basket)
						-- Generate partial object.
					make_file.putstring ("all: ")
					make_file.putchar (sub_dir)
					make_file.putstring ("obj")
					make_file.putint (i)
					make_file.putstring (".o")
					make_file.new_line
					make_file.new_line
					generate_partial_objects_linking (sub_dir, i)
						-- Generate cleaning rules
					generate_sub_cleaning
						-- End production.
					generate_ending
					make_file.close
				end
				i := i + 1
			end
			make_file := old_makefile
		end

feature -- Generation, Header

	generate_compilation_rule is
			-- Generates the .c -> .o compilation rule
		deferred
		end

	generate_specific_defines is
			-- Generate specific "-D" flags.
			-- Do nothing by default.
		do
		end

	generate_preamble is
			-- Generate leading part (directions to /bin/sh)
		do
			make_file.putstring ("case $CONFIG in%N'')%N")
			make_file.putstring ("%
				%%Tif test ! -f config.sh; then%N%
				%%T%T(echo %"Can't find config.sh.%"; exit 1)%N%
				%%Tfi 2>/dev/null%N%
				%%T. ./config.sh%N%
				%%T;;%N%
				%esac%N")
			make_file.putstring ("%
				%case %"$O%" in%N%
				%*/*) cd `expr X$0 : 'X\(.*\)/'` ;;%N%
				%esac%N")
			make_file.putstring ("%
				%echo %"Extracting %".%"/Makefile%
								% (with variable substitutions)%"%N%
				%$spitshell >Makefile <<!GROK!THIS!%N")
		end

	generate_sub_preamble is
			-- Generate leading part (directions to /bin/sh)
			-- for subdirectory Makefiles.
		do
			make_file.putstring ("case $CONFIG in%N'')%N")
			make_file.putstring ("%
				%%Tif test ! -f ../config.sh; then%N%
				%%T%T(echo %"Can't find ../config.sh.%"; exit 1)%N%
				%%Tfi 2>/dev/null%N%
				%%T. ../config.sh%N%
				%%T;;%N%
				%esac%N")
			make_file.putstring ("%
				%case %"$O%" in%N%
				%*/*) cd `expr X$0 : 'X\(.*\)/'` ;;%N%
				%esac%N")
			make_file.putstring ("%
				%echo %"Extracting %".%"/Makefile%
								% (with variable substitutions)%"%N%
				%$spitshell >Makefile <<!GROK!THIS!%N")
		end

	generate_customization is
			-- Customize generic Makefile
		do
			generate_include_path
			make_file.putstring ("%
				%SHELL = /bin/sh%N%
				%CC = $cc%N%
				%CPP = $cpp%N")

			if System.in_final_mode then
				make_file.putstring ("CFLAGS = $optimize ")
			else
				make_file.putstring ("CFLAGS = $wkoptimize ")
			end

			if System.has_multithreaded then
				make_file.putstring ("$mtccflags $large ")
			else
				make_file.putstring ("$ccflags $large ")
			end

			if System.has_dynamic_runtime then
				make_file.putstring ("$shared_flags ")
			end

			if System.has_separate then
				make_file.putstring ("-DCONCURRENT_EIFFEL ")
			end

			if not System.uses_ise_gc_runtime then
				make_file.putstring ("-DNO_ISE_GC ")
			end

			generate_specific_defines
			make_file.putstring ("-I%H$(ISE_EIFFEL)/studio/spec/%H$(ISE_PLATFORM)/include -I. %H$(INCLUDE_PATH)%N")

			if System.in_final_mode then
				make_file.putstring ("CPPFLAGS = $optimize ")
			else
				make_file.putstring ("CPPFLAGS = $wkoptimize ")
			end

			if System.has_multithreaded then
				make_file.putstring ("$mtcppflags $large ")
			else
				make_file.putstring ("$cppflags $large ")
			end

			if System.has_separate then
				make_file.putstring ("-DCONCURRENT_EIFFEL ")
			end

			generate_specific_defines
			make_file.putstring ("-I%H$(ISE_EIFFEL)/studio/spec/%H$(ISE_PLATFORM)/include -I. %H$(INCLUDE_PATH)%N")

			make_file.putstring ("LDFLAGS = ")

			if System.is_console_application then
				make_file.putstring (" $console_flags")
			else
				make_file.putstring (" $windows_flags")
			end

			if System.has_multithreaded then
				make_file.putstring (" $mtldflags")
			else
				make_file.putstring (" $ldflags")
			end

			make_file.new_line
			make_file.putstring ("LDSHAREDFLAGS = ")
			if System.has_multithreaded then
				make_file.putstring (" $mtldsharedflags")
			else
				make_file.putstring (" $ldsharedflags")
			end

			make_file.putstring ("%NEIFLIB = ")
			make_file.putstring (run_time)

			if System.has_multithreaded then
				make_file.putstring ("%NLIBS = $mtlibs")
			else
				make_file.putstring ("%NLIBS = $libs")
			end

			make_file.putstring ("%NMAKE = $make%N%
				%AR = $ar%N%
				%LD = $ld%N%
				%MKDEP = $mkdep %H$(DPFLAGS) --%N%
				%MV = $mv%N%
				%CP = $cp%N%
				%RANLIB = $ranlib%N%
				%RM = $rm -f%N%
				%RMDIR = $rmdir%N")

			make_file.putstring ("X2C = \$(ISE_EIFFEL)/studio/spec/\$(ISE_PLATFORM)/bin/x2c%N")
			make_file.putstring ("SHAREDLINK = $sharedlink%N")
			make_file.putstring ("SHAREDLIBS = $sharedlibs%N")
			make_file.putstring ("SHARED_SUFFIX = $shared_suffix%N")

			if System.makefile_names /= Void then
				generate_makefile_names -- EXTERNAL_MAKEFILES = ...
				make_file.putstring ("COMMAND_MAKEFILE = $command_makefile%N")
			else
				make_file.putstring ("COMMAND_MAKEFILE = %N")
			end

			make_file.putstring ("START_TEST = $start_test %N")
			make_file.putstring ("END_TEST = $end_test %N")
			make_file.putstring ("CREATE_TEST = $create_test %N")

			make_file.putstring ("SYSTEM_IN_DYNAMIC_LIB = ")
			make_file.putstring (system_name)
			make_file.putstring ("$shared_suffix %N")

			make_file.putstring ("%
				%!GROK!THIS!%N%
				%$spitshell >>Makefile <<'!NO!SUBS!'%N")
		end

feature -- Generation, Object list(s)

	generate_macro (mname: STRING; basket: LINKED_LIST [STRING]) is
			-- Generate a bunch of objects to be put in macro `mname'
		local
			size: INTEGER
			file_name: STRING
		do
			make_file.putstring (mname)
			make_file.putstring (" = ")
			from
				basket.start
				size := mname.count + 3
			until
				basket.after
			loop
				file_name := basket.item
				size := size + file_name.count + 1
				if size > 78 then
					make_file.putchar (Continuation)
					make_file.new_line
					make_file.putchar ('%T')
					size := 8 + file_name.count + 1
					make_file.putstring (file_name)
				else
					make_file.putstring (file_name)
				end
				make_file.putchar (' ')
				basket.forth
			end
			make_file.new_line
			make_file.new_line
		end

feature -- Generation, External archives and object files.

	generate_externals is
			-- Generate declaration fo the external variable
		local
			object_file_names: LIST [STRING]
			i, nb: INTEGER
		do
			object_file_names := System.object_file_names
			if object_file_names /= Void then
				make_file.putstring ("EXTERNALS = ")
				from
					i := 1
					nb := object_file_names.count
				until
					i > nb
				loop
					make_file.putchar (' ')
					make_file.putchar (Continuation)
					make_file.putstring ("%N%T")
					make_file.putstring (object_file_names.i_th (i))
					i := i + 1
				end
				make_file.new_line
				make_file.new_line
			end
		end

	generate_include_path is
			-- Generate declaration fo the include_paths
		local
			include_paths: LIST [STRING]
			i, nb: INTEGER
		do
			include_paths := System.include_paths
			if include_paths /= Void then
				make_file.putstring ("INCLUDE_PATH = ")
				from
					i := 1
					nb := include_paths.count
				until
					i > nb
				loop
					make_file.putstring ("-I")
					make_file.putstring (include_paths.i_th (i))
					if i /= nb then
						make_file.putchar (' ')
					end
					i := i + 1
				end
				make_file.new_line
			end
		end

	generate_makefile_names is
		require
			list_not_void: System.makefile_names /= Void
		local
			makefile_names: LIST [STRING]
			i, nb: INTEGER
		do
			makefile_names := System.makefile_names
			from
				make_file.putstring ("EXTERNAL_MAKEFILES = ")
				i := 1
				nb := makefile_names.count
			until
				i > nb
			loop
				make_file.putstring (" ")
				make_file.putstring (makefile_names.i_th (i))
				i := i + 1
			end
			make_file.new_line
		end

feature -- Generation (Linking rules)

	generate_executable is
			-- Generate rules to produce executable
		do
			make_file.putstring ("all: ")
			make_file.putstring (system_name)
			if Eiffel_dynamic_lib /= Void then
				make_file.putstring (" $(SYSTEM_IN_DYNAMIC_LIB)")
			end

			make_file.new_line
			make_file.new_line
			generate_partial_objects_dependencies
			generate_partial_system_objects_dependencies
			generate_simple_executable
		end

	generate_simple_executable is
			-- Generate rule to produce simple executable, linked in
			-- with `run_time' archive.
		do
			make_file.putstring ("OBJECTS= ")
			generate_objects_macros
			make_file.putchar (' ')
			generate_system_objects_macros
			make_file.putstring ("%N") 

			make_file.new_line
			make_file.putstring (system_name)
			make_file.putstring (": ")
			make_file.putstring ("$(OBJECTS) ")
			make_file.putchar (' ')
			make_file.putchar (System_object_prefix)
			make_file.putint (1)
			make_file.putstring ("/emain.o Makefile%N%T$(RM) ") 
			make_file.putstring (system_name)
			make_file.new_line
			if System.makefile_names /= Void then
				make_file.putstring ("%T$(COMMAND_MAKEFILE) $(EXTERNAL_MAKEFILES)%N")
			end
			if System.has_cpp_externals then
				make_file.putstring ("%T$(CPP")
			else
				make_file.putstring ("%T$(CC")
			end
			make_file.putstring (") -o ")
			make_file.putstring (system_name)
			make_file.putstring ("%
				% $(C")
			if System.has_cpp_externals then
				make_file.putstring ("PP")
			end
			make_file.putstring ("FLAGS) $(LDFLAGS) ")
			make_file.putstring (" $(OBJECTS) ")
			make_file.putchar (System_object_prefix)
			make_file.putint (1)
			make_file.putstring ("/emain.o ") 
			make_file.putchar (Continuation)
			make_file.new_line
			generate_other_objects
			make_file.putstring ("%T%T")
			if System.object_file_names /= Void then
				make_file.putstring ("$(EXTERNALS) ")
			end
			make_file.putstring ("$(EIFLIB)")
			make_file.putstring (" $(LIBS)%N")

			generate_additional_rules
			make_file.new_line
		end

	generate_additional_rules is
		do
		end

	generate_other_objects is
		do
		end

	generate_system_objects_macros is
			-- Generate the system object macros 
			-- (dependencies for final executable).
		do
				-- System object files.
			generate_basket_objects (System_baskets, System_object_prefix)
		end

	generate_objects_macros is
			-- Generate the object macros (dependencies for final executable)
		do
				-- Class object files.
			generate_basket_objects (object_baskets, C_prefix)
		end


	generate_subdir_names is
			-- Generate the subdirectories' names.
		local
			i, baskets_count: INTEGER
			not_first: BOOLEAN
		do
			make_file.putstring ("SUBDIRS = ")

			if not_first then
				make_file.putchar (' ')
				not_first := false
			end

				-- Class object files.
			from
				baskets_count := object_baskets.count
				i := 1
			until
				i > baskets_count
			loop
				if not object_baskets.item (i).is_empty then
					if not_first then
						make_file.putchar (' ')
					else
						not_first := true
					end
					make_file.putchar (C_prefix)
					make_file.putint (i)
				end
				i := i + 1
			end

			from
				baskets_count := system_baskets.count
				i := 1
			until
				i > baskets_count
			loop
				if not system_baskets.item (i).is_empty then
					make_file.putchar (' ')
					make_file.putchar (System_object_prefix)
					make_file.putint (i)
				end
				i := i + 1
			end

			make_file.new_line
			make_file.new_line
		end

	generate_partial_objects_linking (dir_prefix: CHARACTER; index: INTEGER) is
			-- Generate rules to produce partial linking and the
			-- final executable linked in with `run_time'.
		do
			make_file.putchar (dir_prefix)
			make_file.putstring ("obj")
			make_file.putint (index)
			make_file.putstring (".o: $(OBJECTS) Makefile")
			make_file.new_line
				-- The following is not portable (if people want to use
				-- their own linker).
				-- FIXME
			make_file.putstring ("%T$(LD) $(LDFLAGS) -r -o ")
			make_file.putchar (dir_prefix)
			make_file.putstring ("obj")
			make_file.putint (index)
			make_file.putstring (".o $(OBJECTS)")

			make_file.putstring ("%N%T$(CREATE_TEST)")

			make_file.new_line
			make_file.new_line
		end

	generate_partial_system_objects_dependencies is
			-- Depencies to update partial system objects in subdirectories.
		local
			i, nb: INTEGER
			emain_file: STRING
		do
			if not System.has_separate then
				emain_file := "emain.template"
			else
				emain_file := "emain.separate_template"
			end

				-- Generate the dependence rule for E1/Makefile
			make_file.putchar (System_object_prefix)
			make_file.putint (1)
			make_file.putstring ("/Makefile: ")
			make_file.putchar (System_object_prefix)
			make_file.putint (1)
			make_file.putstring ("/Makefile.SH")
			make_file.putstring ("%N%Tcd ")
			make_file.putchar (System_object_prefix)
			make_file.putint (1)
			make_file.putstring (" ; $(SHELL) Makefile.SH%N%N")

				-- Generate the dependence rule for E1/emain.o
			make_file.putchar (System_object_prefix)
			make_file.putint (1)
			make_file.putstring ("/emain.o: Makefile ")
			make_file.putchar (System_object_prefix)
			make_file.putint (1)
			make_file.putstring ("/Makefile $(ISE_EIFFEL)/studio/config/$(ISE_PLATFORM)/templates/")
			make_file.putstring (emain_file)
			make_file.putstring ("%N%T$(CP) $(ISE_EIFFEL)/studio/config/$(ISE_PLATFORM)/templates/")
			make_file.putstring (emain_file)
			make_file.putchar (' ')
			make_file.putchar (System_object_prefix)
			make_file.putint (1)
			make_file.putstring ("/emain.c")
			make_file.putstring ("%N%Tcd ")
			make_file.putchar (System_object_prefix)
			make_file.putint (1)
			make_file.putstring (" ; $(MAKE) emain.o ; $(RM) emain.c%N%N")

			from
				i := 1
				nb := system_baskets.count
			until
				i > nb
			loop
				make_file.putchar (System_object_prefix)
				make_file.putint (i)
				make_file.putchar ('/')
				make_file.putchar (System_object_prefix)
				make_file.putstring ("obj")
				make_file.putint (i)
				if i = 1 then
					make_file.putstring (".o: Makefile ")
					make_file.putchar (System_object_prefix)
					make_file.putint (i)
					make_file.putstring ("/Makefile%N%Tcd ")
				else
					make_file.putstring (".o: Makefile%N%Tcd ")
				end
				make_file.putchar (System_object_prefix)
				make_file.putint (i)
				if i = 1 then
					make_file.putstring (" ; $(START_TEST) $(MAKE) ")
				else
					make_file.putstring (" ; $(START_TEST) $(SHELL) Makefile.SH ; $(MAKE) ")
				end
				make_file.putchar (System_object_prefix)
				make_file.putstring ("obj")
				make_file.putint (i)
				make_file.putstring (".o $(END_TEST)%N%N")
				i := i + 1
			end
		end

	generate_partial_objects_dependencies is
			-- Depencies to update partial objects in subdirectories.
		local
			i, baskets_count: INTEGER
		do
				-- Class object files.
			from
				baskets_count := object_baskets.count
				i := 1
			until
				i > baskets_count
			loop
				if not object_baskets.item (i).is_empty then
					make_file.putchar (C_prefix)
					make_file.putint (i)
					make_file.putchar ('/')
					make_file.putchar (C_prefix)
					make_file.putstring ("obj")
					make_file.putint (i)
					make_file.putstring (".o: Makefile%N%Tcd ")
					make_file.putchar (C_prefix)
					make_file.putint (i)
					make_file.putstring (" ; $(START_TEST) $(SHELL) Makefile.SH ; $(MAKE) $(END_TEST)")
					make_file.new_line
					make_file.new_line
				end
				i := i + 1
			end
		end

feature -- Cleaning rules

	generate_main_cleaning is
			-- Generate "make clean" and "make clobber" in the main Makefile.
		do
			make_file.putstring ("clean: sub_clean local_clean%N")
			make_file.putstring ("clobber: sub_clobber local_clobber%N%N")
			make_file.putstring ("local_clean::%N")
			make_file.putstring ("%T$(RM) core finished *.o *.so *.a%N%N")
			make_file.putstring ("local_clobber:: local_clean%N%T")
			make_file.putstring ("$(RM) Makefile config.sh finish_freezing%N")
			make_file.putstring ("%Nsub_clean::%N")
			make_file.putstring ("%Tfor i in $(SUBDIRS); \%N")
			make_file.putstring ("%Tdo \%N%T%Tif [ -r $$i")
			make_file.putchar ('/')
			make_file.putstring ("Makefile ]; then \%N%T%T%T")
			make_file.putstring ("(cd $$i ; $(MAKE) clean); \")
			make_file.putstring ("%N%T%Tfi; \%N%Tdone%N%N")
			make_file.putstring ("sub_clobber::%N")
			make_file.putstring ("%Tfor i in $(SUBDIRS); \%N")
			make_file.putstring ("%Tdo \%N%T%Tif [ -r $$i")
			make_file.putchar ('/')
			make_file.putstring ("Makefile ]; then \%N%T%T%T")
			make_file.putstring ("(cd $$i ; $(MAKE) clobber); \")
			make_file.putstring ("%N%T%Tfi; \%N%Tdone%N%N")
		end

	generate_sub_cleaning is
			-- Generate "make clean" and "make clobber" in the sub directories.
		do
			make_file.putstring ("clean: local_clean%N")
			make_file.putstring ("clobber: local_clobber%N%N")
			make_file.putstring ("local_clean::%N")
			make_file.putstring ("%T$(RM) core finished *.o%N%N")
			make_file.putstring ("local_clobber:: local_clean%N")
			make_file.putstring ("%T$(RM) Makefile%N%N")
		end

feature -- Generation, Tail
			
	generate_ending is
			-- Ends Makefile wrapping scheme
		do
			make_file.putstring ("%
				%!NO!SUBS!%N%
				%chmod 644 Makefile%N%
				%$eunicefix Makefile%N")
		end

feature -- Removal of empty classes

	record_empty_class_type (a_class_type: INTEGER) is
			-- add `a_class_type' to the set of class types that
			-- are not generated
		do
			empty_class_types.put (a_class_type)
		end

feature {NONE} -- Implementation

	generate_basket_objects (baskets: ARRAY [LINKED_LIST [STRING]]; dir_prefix: CHARACTER) is
			-- Generate the object macros in `baskets'.
		require
			baskets_not_void: baskets /= Void
		local
			i, baskets_count: INTEGER
			not_first: BOOLEAN
		do
			from
				baskets_count := baskets.count
				i := 1
			until
				i > baskets_count
			loop
				if not baskets.item (i).is_empty then
					if not_first then
						make_file.putchar (' ')
					else
						not_first := true
					end
					make_file.putchar (dir_prefix)
					make_file.putint (i)
					make_file.putchar ('/')
					make_file.putchar (dir_prefix)
					make_file.putstring ("obj")
					make_file.putint (i)
					make_file.putstring (".o")
				end
				i := i + 1
			end
		end

feature {NONE} -- Constants

	lib_location: STRING is "\$(ISE_EIFFEL)/studio/spec/\$(ISE_PLATFORM)/lib/"
			-- Location of run-time library files.

	libnet_location: STRING is "\$(ISE_EIFFEL)/library/net/spec/\$(ISE_PLATFORM)/lib/libnet.a"
			-- Library name + location of EiffelNet.

end
