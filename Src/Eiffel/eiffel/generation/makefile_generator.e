indexing
	description: "[
		Makefile generation control. The generated Makefile.SH is to be run through
		/bin/sh to get properly instantiated for a given platform. A partial linking
		of `Packet_number' files is done, as needed to avoid kernel internal argument
		space overflow.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			Result := System.name
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
			create object_name.make (0)
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
			create object_name.make (0)
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
			make_file.put_string ("STATIC_CECIL = lib")
			make_file.put_string (system_name)
			make_file.put_string (".a%N")

			make_file.put_string ("cecil: $(STATIC_CECIL)%N")
			make_file.put_string ("$(STATIC_CECIL): ")
			make_file.put_character (' ')
			make_file.put_string ("$(OBJECTS) %N")
			make_file.put_string ("%T$(AR) x ")
			make_file.put_string ("$(EIFLIB)")
			make_file.put_new_line
			make_file.put_string ("%T$(AR) cr ")
			make_file.put_string ("$(STATIC_CECIL)")
			make_file.put_character (' ')
			make_file.put_string ("$(OBJECTS) $(PRECOMP_OBJECTS) $(RCECIL)")
			make_file.put_new_line
			make_file.put_string ("%T$(RANLIB) ")
			make_file.put_string ("$(STATIC_CECIL)%N")
			make_file.put_string ("%T$(RM) $(RCECIL) ")
			make_file.put_new_line
			make_file.put_new_line

				-- SHARED_CECIL
			make_file.put_string ("SHARED_CECIL = lib")
			make_file.put_string (system_name)
			make_file.put_string ("$(SHARED_SUFFIX)%N")
			make_file.put_string ("dynamic_cecil: $(SHARED_CECIL) %N")
			make_file.put_string ("SHARED_CECIL_OBJECT = $(OBJECTS) ")
			make_file.put_character (continuation)
			make_file.put_new_line
			make_file.put_string ("%T%T")
			make_file.put_string (packet_name (system_object_prefix, 1))
			make_file.put_string ("/emain.o")
			make_file.put_new_line
			make_file.put_string ("SHAREDFLAGS = $(LDSHAREDFLAGS) $(SHARED_CECIL) %N");
			make_file.put_string ("$(SHARED_CECIL): $(SHARED_CECIL_OBJECT) %N")
			make_file.put_string ("%T$(RM) $(SHARED_CECIL) %N")
			make_file.put_string ("%T$(SHAREDLINK) $(SHAREDFLAGS) $(SHARED_CECIL_OBJECT) $(PRECOMP_OBJECTS) $(EXTERNALS) $(EIFLIB) $(SHAREDLIBS) %N")

			make_file.put_new_line
			make_file.put_new_line
		end

feature -- Generate Dynamic Library

	generate_dynamic_lib is
		local
			egc_dynlib_file: STRING
		do
			-- Generate the line concerning edynlib.o and egc_dynlib.o
			egc_dynlib_file := "egc_dynlib.template"

			-- Generate SYSTEM_IN_DYNAMIC_LIB...
			make_file.put_string ("%Ndynlib: $(SYSTEM_IN_DYNAMIC_LIB) ")

			-- Generate "E1/egc_dynlib.o"
			make_file.put_string ("%N")
			make_file.put_string (packet_name (system_object_prefix, 1))
			make_file.put_string ("/egc_dynlib.o: Makefile")
			make_file.put_string ("%N%T$(CP) %"$(EIFTEMPLATES)/")
			make_file.put_string (egc_dynlib_file)
			make_file.put_string ("%" ")
			make_file.put_string (packet_name (system_object_prefix, 1))
			make_file.put_string ("/egc_dynlib.c")

			make_file.put_string ("%N%Tcd ")
			make_file.put_string (packet_name (system_object_prefix, 1))
			make_file.put_string (" ; $(MAKE) egc_dynlib.o")
			make_file.put_string (" ; cd ..")

			-- Generate "E1/edynlib.o"
			make_file.put_string ("%N")
			make_file.put_string (packet_name (system_object_prefix, 1))
			make_file.put_string ("/edynlib.o: Makefile ")
			make_file.put_string (packet_name (system_object_prefix, 1))
			make_file.put_string ("/edynlib.c ")
			make_file.put_string ("%N%Tcd ")
			make_file.put_string (packet_name (system_object_prefix, 1))
			make_file.put_string (" ; $(MAKE) edynlib.o")
			make_file.put_string (" ; cd ..%N")

			-- Continue the declaration for the SYSTEM_IN_DYNAMIC_LIB
			make_file.put_string ("%NSYSTEM_IN_DYNAMIC_LIB_OBJ = $(OBJECTS) ")
			make_file.put_character (continuation)
			make_file.put_new_line
			make_file.put_string ("%T%T")
			make_file.put_string (packet_name (system_object_prefix, 1))
			make_file.put_string ("/edynlib.o ")
			make_file.put_string (packet_name (system_object_prefix, 1))
			make_file.put_string ("/egc_dynlib.o ")
			make_file.put_string ("%NDYNLIBSHAREDFLAGS = $(LDSHAREDFLAGS) $(SYSTEM_IN_DYNAMIC_LIB) %N");
			make_file.put_string ("$(SYSTEM_IN_DYNAMIC_LIB): $(SYSTEM_IN_DYNAMIC_LIB_OBJ) %N")
			make_file.put_string ("%T$(RM) $(SYSTEM_IN_DYNAMIC_LIB) %N")
			make_file.put_string ("%T$(SHAREDLINK) $(DYNLIBSHAREDFLAGS) $(SYSTEM_IN_DYNAMIC_LIB_OBJ) $(PRECOMP_OBJECTS) $(EXTERNALS) $(EIFLIB) $(SHAREDLIBS) %N")
			make_file.put_new_line
			make_file.put_new_line
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
			generate_sub_makefiles (system_object_prefix, system_baskets)

			make_file := make_f (system.in_final_mode)
			make_file.open_write
				-- Generate main /bin/sh preamble
			generate_preamble
				-- Customize main Makefile macros
			generate_customization (False)
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

				-- Cleanup
			cleanup_generated_makefiles (C_prefix, object_baskets)
			cleanup_generated_makefiles (system_object_prefix, system_baskets)

			object_baskets := Void
			system_baskets := Void
			cecil_rt_basket.wipe_out
		end

	generate_il (has_il_cpp: BOOLEAN) is
			-- Generate make files
		local
			basket: LINKED_LIST [STRING]
		do
			create system_baskets.make (1, 0)
			create object_baskets.make (1, 1)
			create basket.make
			basket.extend (System.name + ".o")
			object_baskets.put (basket, 1)

			make_file := make_f (system.in_final_mode)

			make_file.open_write
				-- Generate main /bin/sh preamble
			generate_preamble
				-- Customize main Makefile macros
			generate_customization (has_il_cpp)
				-- How to produce a .o from a .c file
			generate_compilation_rule

				-- Generate subdir names
			generate_subdir_names

				-- Generate external objects
			generate_externals

				-- Generate executable
			generate_il_dll

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
		require
			baskets_not_void: baskets /= Void
		local
			new_makefile, old_makefile: INDENT_FILE
			nb, i: INTEGER
			f_name: FILE_NAME
			basket: LINKED_LIST [STRING]
		do
			old_makefile := make_file
			from
				nb := baskets.count
				i := 1
			until
				i > nb
			loop
				basket := baskets.item (i)
				if basket /= Void and then not basket.is_empty then
					if system.in_final_mode then
						create f_name.make_from_string (project_location.final_path)
					else
						create f_name.make_from_string (project_location.workbench_path)
					end
					f_name.extend (packet_name (sub_dir, i))
					f_name.set_file_name (Makefile_SH)
					create new_makefile.make (f_name)
					make_file  := new_makefile
					make_file.open_write
						-- Generate main /bin/sh preamble
					generate_sub_preamble (packet_name (sub_dir, i))
						-- Customize main Makefile macros
					generate_customization (False)
						-- How to produce a .o from a .c file
					generate_compilation_rule
						-- Generate object list.
					generate_macro ("OBJECTS", basket)
						-- Generate partial object.
					make_file.put_string ("all: ")
					if sub_dir = system_object_prefix and i = 1 then
							-- For E1 directory, we do not use the large .o file, just the small ones.
						make_file.put_string ("$(OBJECTS)")
						make_file.put_new_line
						make_file.put_new_line
					else
						make_file.put_character (sub_dir)
						make_file.put_string ("obj")
						make_file.put_integer (i)
						make_file.put_string (".o")
						make_file.put_new_line
						make_file.put_new_line
						generate_partial_objects_linking (sub_dir, i)
					end
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

	cleanup_generated_makefiles (sub_dir: CHARACTER; baskets: ARRAY [LINKED_LIST [STRING]]) is
			-- Remove directory when associated baskets is empty.
		require
			baskets_not_void: baskets /= Void
		local
			nb, i: INTEGER
			f_name: FILE_NAME
			basket: LINKED_LIST [STRING]
		do
			from
				nb := baskets.count
				i := 1
			until
				i > nb
			loop
				basket := baskets.item (i)
				if basket /= Void and then basket.is_empty then
					if system.in_final_mode then
						create f_name.make_from_string (project_location.final_path)
					else
						create f_name.make_from_string (project_location.workbench_path)
					end
					f_name.extend (packet_name (sub_dir, i))
					safe_recursive_delete (f_name)
				end
				i := i + 1
			end
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
			make_file.put_string ("case $CONFIG in%N'')%N")
			make_file.put_string ("%
				%%Tif test ! -f config.sh; then%N%
				%%T%T(echo %"Can't find config.sh.%"; exit 1)%N%
				%%Tfi 2>/dev/null%N%
				%%T. ./config.sh%N%
				%%T;;%N%
				%esac%N")
			make_file.put_string ("%
				%case %"$O%" in%N%
				%*/*) cd `expr X$0 : 'X\(.*\)/'` ;;%N%
				%esac%N")
			make_file.put_string ("%
				%echo %"Preparing C compilation%"%N%
				%$spitshell >Makefile <<!GROK!THIS!%N")
		end

	generate_sub_preamble (a_directory: STRING) is
			-- Generate leading part (directions to /bin/sh)
			-- for subdirectory Makefiles.
		require
			a_directory_not_void: a_directory /= Void
		do
			make_file.put_string ("case $CONFIG in%N'')%N")
			make_file.put_string ("%
				%%Tif test ! -f ../config.sh; then%N%
				%%T%T(echo %"Can't find ../config.sh.%"; exit 1)%N%
				%%Tfi 2>/dev/null%N%
				%%T. ../config.sh%N%
				%%T;;%N%
				%esac%N")
			make_file.put_string ("%
				%case %"$O%" in%N%
				%*/*) cd `expr X$0 : 'X\(.*\)/'` ;;%N%
				%esac%N")
			make_file.put_string ("%
				%echo %"Compiling C code in " + a_directory + "%"%N%
				%$spitshell >Makefile <<!GROK!THIS!%N")
		end

	generate_customization (has_il_cpp: BOOLEAN) is
			-- Customize generic Makefile
		do
			generate_include_path
			make_file.put_string ("%
				%SHELL = /bin/sh%N%
				%CC = $cc%N%
				%CPP = $cpp%N")

			if System.in_final_mode then
				make_file.put_string ("CFLAGS = $optimize ")
			else
				make_file.put_string ("CFLAGS = $wkoptimize ")
			end

			if System.il_generation then
				make_file.put_string ("$il_flags ")
			end

			if System.has_multithreaded then
				make_file.put_string ("$mtccflags $large ")
			else
				make_file.put_string ("$ccflags $large ")
			end

			if System.has_dynamic_runtime then
				make_file.put_string ("$shared_flags ")
			end

			if not System.uses_ise_gc_runtime then
				make_file.put_string ("-DNO_ISE_GC ")
			end

			if not System.check_for_void_target then
					-- Disable check for Void target.
				make_file.put_string ("-DEIF_NO_RTCV ")
			end

			generate_specific_defines
			make_file.put_string ("-I%"$rt_include%" ")
			make_file.put_string ("-I. %H$(INCLUDE_PATH)%N")

			if System.in_final_mode then
				make_file.put_string ("CPPFLAGS = $optimize ")
			else
				make_file.put_string ("CPPFLAGS = $wkoptimize ")
			end

			if System.il_generation then
				make_file.put_string ("$il_flags ")
			end

			if System.has_multithreaded then
				make_file.put_string ("$mtcppflags $large ")
			else
				make_file.put_string ("$cppflags $large ")
			end

			if not System.uses_ise_gc_runtime then
				make_file.put_string ("-DNO_ISE_GC ")
			end

			if not System.check_for_void_target then
					-- Disable check for Void target.
				make_file.put_string ("-DEIF_NO_RTCV ")
			end


			generate_specific_defines

			make_file.put_string ("-I%"$rt_include%" ")
			make_file.put_string ("-I. %H$(INCLUDE_PATH)%N")

			make_file.put_string ("LDFLAGS = $ldflags%N")

			make_file.put_string ("CCLDFLAGS = $ccldflags ")
			if System.is_console_application then
				make_file.put_string (" $console_flags")
			else
				make_file.put_string (" $windows_flags")
			end

			make_file.put_new_line
			make_file.put_string ("LDSHAREDFLAGS = ")
			if System.has_multithreaded then
				make_file.put_string (" $mtldsharedflags")
			else
				make_file.put_string (" $ldsharedflags")
			end

			make_file.put_string ("%NEIFLIB = ")
			make_file.put_string (run_time)

			make_file.put_string ("%NEIFTEMPLATES = ")
			make_file.put_string ("$rt_templates")

			if System.has_multithreaded then
				make_file.put_string ("%NLIBS = $mtlibs")
			else
				make_file.put_string ("%NLIBS = $libs")
			end

			make_file.put_string ("%NMAKE = $make%N%
				%AR = $ar%N%
				%LD = $ld%N%
				%MKDEP = $mkdep %H$(DPFLAGS) --%N%
				%MV = $mv%N%
				%CP = $cp%N%
				%RANLIB = $ranlib%N%
				%RM = $rm -f%N%
				%FILE_EXIST = $file_exist%N%
				%RMDIR = $rmdir%N")

			make_file.put_string ("X2C = %"$x2c%"%N")
			make_file.put_string ("SHAREDLINK = $sharedlink%N")
			make_file.put_string ("SHAREDLIBS = $sharedlibs%N")
			make_file.put_string ("SHARED_SUFFIX = $shared_suffix%N")

			if not universe.conf_system.all_external_make.is_empty then
				generate_makefile_names -- EXTERNAL_MAKEFILES = ...
				make_file.put_string ("COMMAND_MAKEFILE = $command_makefile%N")
			else
				make_file.put_string ("COMMAND_MAKEFILE = %N")
			end

			make_file.put_string ("START_TEST = $start_test %N")
			make_file.put_string ("END_TEST = $end_test %N")
			make_file.put_string ("CREATE_TEST = $create_test %N")

			make_file.put_string ("SYSTEM_IN_DYNAMIC_LIB = ")
			make_file.put_string (system_name)
			make_file.put_string ("$shared_suffix %N")

			if System.il_generation then
				make_file.put_string ("IL_SYSTEM = lib")
				make_file.put_string (system_name)
				make_file.put_string ("$shared_suffix%N")
				make_file.put_string ("IL_OBJECTS = lib")
				make_file.put_string (system_name)
				make_file.put_string (".$obj_file_ext")
				if has_il_cpp then
					make_file.put_string (" lib")
					make_file.put_string (system_name)
					make_file.put_string ("_cpp.$obj_file_ext")
				end
				make_file.put_string ("%NIL_RESOURCE = ")
				make_file.put_string (system_name)
				make_file.put_new_line
			end

			make_file.put_string ("%
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
			make_file.put_string (mname)
			make_file.put_string (" = ")
			from
				basket.start
				size := mname.count + 3
			until
				basket.after
			loop
				file_name := basket.item
				size := size + file_name.count + 1
				if size > 78 then
					make_file.put_character (Continuation)
					make_file.put_new_line
					make_file.put_character ('%T')
					size := 8 + file_name.count + 1
					make_file.put_string (file_name)
				else
					make_file.put_string (file_name)
				end
				make_file.put_character (' ')
				basket.forth
			end
			make_file.put_new_line
			make_file.put_new_line
		end

feature -- Generation, External archives and object files.

	generate_externals is
			-- Generate declaration fo the external variable
		local
			object_file_names: LIST [CONF_EXTERNAL]
			i, nb: INTEGER
			l_ext: CONF_EXTERNAL
			l_added_objects: SEARCH_TABLE [STRING]
			l_path: STRING
			l_has_objects: BOOLEAN
			l_state: CONF_STATE
		do
			create l_added_objects.make (10)
				-- add the object files
			object_file_names := universe.conf_system.all_external_object
			l_state := universe.conf_state
			if object_file_names /= Void then
				make_file.put_string ("EXTERNALS = ")
				l_has_objects := True
				from
					i := 1
					nb := object_file_names.count
				until
					i > nb
				loop
					l_ext := object_file_names.i_th (i)
					if l_ext.is_enabled (l_state) then
						l_path := l_ext.location
						safe_external_path (l_path, False)
							-- don't add the same object multiple times
						if not l_added_objects.has (l_path) then
							l_added_objects.force (l_path)
							make_file.put_character (' ')
							make_file.put_character (Continuation)
							make_file.put_string ("%N%T")
							make_file.put_string (l_path)
						end
					end
					i := i + 1
				end
			end

				-- add the libraries
			l_added_objects.wipe_out
			object_file_names := universe.conf_system.all_external_library
			if object_file_names /= Void then
				if not l_has_objects then
					make_file.put_string ("EXTERNALS = ")
				end
				from
					i := 1
					nb := object_file_names.count
				until
					i > nb
				loop
					l_ext := object_file_names.i_th (i)
					if l_ext.is_enabled (l_state) then
						l_path := l_ext.location
						safe_external_path (l_path, False)
							-- don't add the same library multiple times
						if not l_added_objects.has (l_path) then
							l_added_objects.force (l_path)
							make_file.put_character (' ')
							make_file.put_character (Continuation)
							make_file.put_string ("%N%T")
							make_file.put_string (l_path)
						end
					end
					i := i + 1
				end

				make_file.put_new_line
				make_file.put_new_line
			end
		end

	generate_include_path is
			-- Generate declaration fo the include_paths
		local
			include_paths: LIST [CONF_EXTERNAL_INCLUDE]
			i, nb: INTEGER
			l_ext: CONF_EXTERNAL_INCLUDE
			l_path: STRING
			l_added_includes: SEARCH_TABLE [STRING]
			l_state: CONF_STATE
		do
			create l_added_includes.make (10)
			include_paths := universe.conf_system.all_external_include
			if include_paths /= Void then
				make_file.put_string ("INCLUDE_PATH = ")
				from
					i := 1
					nb := include_paths.count
					l_state := universe.conf_state
				until
					i > nb
				loop
					l_ext := include_paths.i_th (i)
					if l_ext.is_enabled (l_state) then
						l_path := l_ext.location
						safe_external_path (l_path, False)
							-- all remaining $ are by choice so mask them
						l_path.replace_substring_all ("$", "\$")
							-- because its possible that they were already masked, correct double masking
						l_path.replace_substring_all ("\\$", "\$")
							-- don't add the same include multiple times
						if not l_added_includes.has (l_path) then
							l_added_includes.force (l_path)
							make_file.put_string ("-I")
							make_file.put_string (l_path)
							if i /= nb then
								make_file.put_character (' ')
							end
						end
					end
					i := i + 1
				end
				make_file.put_new_line
			end
		end

	generate_makefile_names is
		local
			makefile_names: LIST [CONF_EXTERNAL_MAKE]
			i, nb: INTEGER
			l_ext: CONF_EXTERNAL_MAKE
			l_added_make: SEARCH_TABLE [STRING]
			l_path: STRING
			l_state: CONF_STATE
		do
			create l_added_make.make (1)
			makefile_names := universe.conf_system.all_external_make
			from
				make_file.put_string ("EXTERNAL_MAKEFILES = ")
				i := 1
				nb := makefile_names.count
				l_state := universe.conf_state
			until
				i > nb
			loop
				l_ext := makefile_names.i_th (i)
				if l_ext.is_enabled (l_state) then
					l_path := l_ext.location
					safe_external_path (l_path, False)
					if not l_added_make.has (l_path) then
						l_added_make.force (l_path)
						make_file.put_string (" ")
						make_file.put_string (l_path)
					end
				end
				i := i + 1
			end
			make_file.put_new_line
		end

feature -- Generation (Linking rules)

	generate_il_dll is
			-- Generate rules to produce DLL for IL code generation.
			--| So far this is a Windows specific code generation.
		do
			make_file.put_string ("all: $(IL_SYSTEM)")
			make_file.put_new_line

			make_file.put_string ("OBJECTS= $(IL_OBJECTS)")
			make_file.put_new_line
			make_file.put_new_line

			make_file.put_string ("PRECOMP_OBJECTS= ")
			generate_precompile_objects
			make_file.put_new_line
			make_file.put_new_line

				-- Continue the declaration for the IL_SYSTEM
			make_file.put_string ("$il_system_compilation_line")
			make_file.put_new_line

			make_file.put_new_line
		end

	generate_executable is
			-- Generate rules to produce executable
		do
			make_file.put_string ("all: ")
			make_file.put_string (system_name)
				-- At this stage `update' on `Eiffel_dynamic_lib' was called by AUXILIARY_FILES.generate_dynamic_lib
				-- and therefore `is_content_valid' is still meaningful.
			if
				Eiffel_dynamic_lib /= Void and then Eiffel_dynamic_lib.is_content_valid and then
				not Eiffel_dynamic_lib.is_empty
			then
				make_file.put_string (" $(SYSTEM_IN_DYNAMIC_LIB)")
			end

			make_file.put_new_line
			make_file.put_new_line
			generate_partial_objects_dependencies
			generate_partial_system_objects_dependencies
			generate_simple_executable
		end

	generate_simple_executable is
			-- Generate rule to produce simple executable, linked in
			-- with `run_time' archive.
		do
			make_file.put_string ("OBJECTS= ")
			generate_objects_macros
			make_file.put_character (' ')
			generate_system_objects_macros
			make_file.put_new_line
			make_file.put_new_line

			make_file.put_string ("PRECOMP_OBJECTS= ")
			generate_precompile_objects
			make_file.put_new_line
			make_file.put_new_line

			make_file.put_new_line
			make_file.put_string (system_name)
			make_file.put_string (": ")
			make_file.put_string ("$(OBJECTS) ")
			make_file.put_character (' ')
			make_file.put_string (packet_name (system_object_prefix, 1))
			make_file.put_string ("/emain.o Makefile%N%T$(RM) ")
			make_file.put_string (system_name)
			make_file.put_new_line
			if not universe.conf_system.all_external_make.is_empty then
				make_file.put_string ("%T$(COMMAND_MAKEFILE) $(EXTERNAL_MAKEFILES)%N")
			end
			if System.has_cpp_externals then
				make_file.put_string ("%T$(CPP")
			else
				make_file.put_string ("%T$(CC")
			end
			make_file.put_string (") -o ")
			make_file.put_string (system_name)
			make_file.put_string ("%
				% $(C")
			if System.has_cpp_externals then
				make_file.put_string ("PP")
			end
			make_file.put_string ("FLAGS) $(CCLDFLAGS) ")
			make_file.put_string (" $(OBJECTS) ")
			make_file.put_string (packet_name (system_object_prefix, 1))
			make_file.put_string ("/emain.o ")
			make_file.put_character (Continuation)
			make_file.put_new_line
			make_file.put_string ("%T%T$(PRECOMP_OBJECTS) $(EXTERNALS) $(EIFLIB) $(LIBS)%N")

			generate_additional_rules
			make_file.put_new_line
		end

	generate_additional_rules is
		do
		end

	generate_precompile_objects is
		do
		end

	generate_system_objects_macros is
			-- Generate the system object macros
			-- (dependencies for final executable).
		local
			l_baskets: like system_baskets
			l_basket: LIST [STRING]
		do
			if system_baskets.count > 1 then
					-- System object files.
				l_baskets := system_baskets.subarray (system_baskets.lower + 1, system_baskets.upper)
				generate_basket_objects (l_baskets, system_object_prefix)
			end

				-- Generate `system_baskets.item (1)' now.
				-- It is needed because on some platforms (e.g SGI) Eobj1.o is too big
				-- to be linked.
			l_basket := system_baskets.item (1)
			from
				l_basket.start
			until
				l_basket.after
			loop
				make_file.put_character (' ')
				make_file.put_string (packet_name (system_object_prefix, 1))
				make_file.put_character ('/')
				make_file.put_string (l_basket.item)
				l_basket.forth
			end
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
			i, nb: INTEGER
			not_first: BOOLEAN
		do
			make_file.put_string ("SUBDIRS = ")

			if not_first then
				make_file.put_character (' ')
				not_first := False
			end

				-- Class object files.
			from
				nb := object_baskets.count
				i := 1
			until
				i > nb
			loop
				if not object_baskets.item (i).is_empty then
					if not_first then
						make_file.put_character (' ')
					else
						not_first := True
					end
					make_file.put_string (packet_name (C_prefix, i))
				end
				i := i + 1
			end

			from
				nb := system_baskets.count
				i := 1
			until
				i > nb
			loop
				if not system_baskets.item (i).is_empty then
					make_file.put_character (' ')
					make_file.put_string (packet_name (system_object_prefix, i))
				end
				i := i + 1
			end

			make_file.put_new_line
			make_file.put_new_line
		end

	generate_partial_objects_linking (dir_prefix: CHARACTER; index: INTEGER) is
			-- Generate rules to produce partial linking and the
			-- final executable linked in with `run_time'.
		do
			make_file.put_character (dir_prefix)
			make_file.put_string ("obj")
			make_file.put_integer (index)
			make_file.put_string (".o: $(OBJECTS) Makefile")
			make_file.put_new_line
				-- The following is not portable (if people want to use
				-- their own linker).
				-- FIXME
			make_file.put_string ("%T$(LD) $(LDFLAGS) -r -o ")
			make_file.put_character (dir_prefix)
			make_file.put_string ("obj")
			make_file.put_integer (index)
			make_file.put_string (".o $(OBJECTS)")

			make_file.put_string ("%N%T$(RM) $(OBJECTS)")
			make_file.put_string ("%N%T$(CREATE_TEST)")

			make_file.put_new_line
			make_file.put_new_line
		end

	generate_partial_system_objects_dependencies is
			-- Depencies to update partial system objects in subdirectories.
		local
			i, nb: INTEGER
			emain_file: STRING
			l_basket: LIST [STRING]
		do
			emain_file := "emain.template"

				-- Generate the dependence rule for E1/Makefile
			make_file.put_string (packet_name (system_object_prefix, 1))
			make_file.put_string ("/Makefile: ")
			make_file.put_string (packet_name (system_object_prefix, 1))
			make_file.put_string ("/Makefile.SH")
			make_file.put_string ("%N%Tcd ")
			make_file.put_string (packet_name (system_object_prefix, 1))
			make_file.put_string (" ; $(SHELL) Makefile.SH%N%N")

				-- Generate the dependence rule for E1/emain.o
			make_file.put_string (packet_name (system_object_prefix, 1))
			make_file.put_string ("/emain.o: Makefile ")
			make_file.put_string (packet_name (system_object_prefix, 1))
			make_file.put_string ("/Makefile")
			make_file.put_string ("%N%T$(CP) %"$(EIFTEMPLATES)/")
			make_file.put_string (emain_file)
			make_file.put_character ('"')
			make_file.put_character (' ')
			make_file.put_string (packet_name (system_object_prefix, 1))
			make_file.put_string ("/emain.c")
			make_file.put_string ("%N%Tcd ")
			make_file.put_string (packet_name (system_object_prefix, 1))
			make_file.put_string (" ; $(MAKE) emain.o%N%N")

			if System.in_final_mode then
					-- Generate dependence rule for E1/estructure.h in final mode
				make_file.put_string (packet_name (system_object_prefix, 1))
				make_file.put_string ("/estructure.h: ")
				make_file.put_string (packet_name (system_object_prefix, 1))
				make_file.put_string ("/estructure.x")
				make_file.new_line
				make_file.put_string ("%T$(X2C) ")
				make_file.put_string (packet_name (system_object_prefix, 1))
				make_file.put_string ("/estructure.x ")
				make_file.put_string (packet_name (system_object_prefix, 1))
				make_file.put_string ("/estructure.h")
				make_file.new_line
				make_file.new_line
					-- Generate dependence rule for E1/eoffsets.h in final mode
				make_file.put_string (packet_name (system_object_prefix, 1))
				make_file.put_string ("/eoffsets.h: ")
				make_file.put_string (packet_name (system_object_prefix, 1))
				make_file.put_string ("/eoffsets.x")
				make_file.new_line
				make_file.put_string ("%T$(X2C) ")
				make_file.put_string (packet_name (system_object_prefix, 1))
				make_file.put_string ("/eoffsets.x ")
				make_file.put_string (packet_name (system_object_prefix, 1))
				make_file.put_string ("/eoffsets.h")
				make_file.new_line
				make_file.new_line
			end

			l_basket := system_baskets.item (1)
			from
				l_basket.start
			until
				l_basket.after
			loop
				make_file.put_string (packet_name (system_object_prefix, 1))
				make_file.put_character ('/')
				make_file.put_string (l_basket.item)
				make_file.put_string (": Makefile ")
				make_file.put_string (packet_name (system_object_prefix, 1))
				make_file.put_string ("/Makefile ")
				make_file.put_string (packet_name (system_object_prefix, 1))
				make_file.put_string ("/estructure.h")
				if system.in_final_mode then
					make_file.put_character (' ')
					make_file.put_string (packet_name (system_object_prefix, 1))
					make_file.put_string ("/eoffsets.h")
				end
				make_file.put_string ("%N%Tcd ")
				make_file.put_string (packet_name (system_object_prefix, 1))
				make_file.put_string (" ; $(MAKE) ")
				make_file.put_string (l_basket.item)
				make_file.put_string ("%N%N")
				l_basket.forth
			end

			from
				i := 2
				nb := system_baskets.count
			until
				i > nb
			loop
				make_file.put_string (packet_name (system_object_prefix, i))
				make_file.put_character ('/')
				make_file.put_character (system_object_prefix)
				make_file.put_string ("obj")
				make_file.put_integer (i)
				make_file.put_string (".o: Makefile ")
				make_file.put_string (packet_name (system_object_prefix, 1))
				make_file.put_string ("/estructure.h")
				if system.in_final_mode then
					make_file.put_character (' ')
					make_file.put_string (packet_name (system_object_prefix, 1))
					make_file.put_string ("/eoffsets.h")
				end
				make_file.put_string ("%N%Tcd ")
				make_file.put_string (packet_name (system_object_prefix, i))
				make_file.put_string (" ; $(START_TEST) $(SHELL) Makefile.SH ; $(MAKE) ")
				make_file.put_character (system_object_prefix)
				make_file.put_string ("obj")
				make_file.put_integer (i)
				make_file.put_string (".o $(END_TEST)%N%N")
				i := i + 1
			end
		end

	generate_partial_objects_dependencies is
			-- Depencies to update partial objects in subdirectories.
		local
			i, nb: INTEGER
		do
				-- Class object files.
			from
				nb := object_baskets.count
				i := 1
			until
				i > nb
			loop
				if not object_baskets.item (i).is_empty then
					make_file.put_string (packet_name (C_prefix, i))
					make_file.put_character ('/')
					make_file.put_character (C_prefix)
					make_file.put_string ("obj")
					make_file.put_integer (i)
					make_file.put_string (".o: Makefile ")
					make_file.put_string (packet_name (system_object_prefix, 1))
					make_file.put_string ("/estructure.h")
					if system.in_final_mode then
						make_file.put_character (' ')
						make_file.put_string (packet_name (system_object_prefix, 1))
						make_file.put_string ("/eoffsets.h")
					end
					make_file.put_string ("%N%Tcd ")
					make_file.put_string (packet_name (C_prefix, i))
					make_file.put_string (" ; $(START_TEST) $(SHELL) Makefile.SH ; $(MAKE) $(END_TEST)")
					make_file.put_new_line
					make_file.put_new_line
				end
				i := i + 1
			end
		end

feature -- Cleaning rules

	generate_main_cleaning is
			-- Generate "make clean" and "make clobber" in the main Makefile.
		do
			make_file.put_string ("clean: sub_clean local_clean%N")
			make_file.put_string ("clobber: sub_clobber local_clobber%N%N")
			make_file.put_string ("local_clean::%N")
			make_file.put_string ("%T$(RM) core finished *.o *.so *.a%N%N")
			make_file.put_string ("local_clobber:: local_clean%N%T")
			make_file.put_string ("$(RM) Makefile config.sh finish_freezing%N")
			make_file.put_string ("%Nsub_clean::%N")
			make_file.put_string ("%Tfor i in $(SUBDIRS); \%N")
			make_file.put_string ("%Tdo \%N%T%Tif [ -r $$i")
			make_file.put_character ('/')
			make_file.put_string ("Makefile ]; then \%N%T%T%T")
			make_file.put_string ("(cd $$i ; $(MAKE) clean); \")
			make_file.put_string ("%N%T%Tfi; \%N%Tdone%N%N")
			make_file.put_string ("sub_clobber::%N")
			make_file.put_string ("%Tfor i in $(SUBDIRS); \%N")
			make_file.put_string ("%Tdo \%N%T%Tif [ -r $$i")
			make_file.put_character ('/')
			make_file.put_string ("Makefile ]; then \%N%T%T%T")
			make_file.put_string ("(cd $$i ; $(MAKE) clobber); \")
			make_file.put_string ("%N%T%Tfi; \%N%Tdone%N%N")
		end

	generate_sub_cleaning is
			-- Generate "make clean" and "make clobber" in the sub directories.
		do
			make_file.put_string ("clean: local_clean%N")
			make_file.put_string ("clobber: local_clobber%N%N")
			make_file.put_string ("local_clean::%N")
			make_file.put_string ("%T$(RM) core finished *.o%N%N")
			make_file.put_string ("local_clobber:: local_clean%N")
			make_file.put_string ("%T$(RM) Makefile%N%N")
		end

feature -- Generation, Tail

	generate_ending is
			-- Ends Makefile wrapping scheme
		do
			make_file.put_string ("%
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
			i, nb: INTEGER
			not_first: BOOLEAN
		do
			from
				i := baskets.upper
				nb := baskets.lower
			until
				i < nb
			loop
				if not baskets.item (i).is_empty then
					if not_first then
						make_file.put_character (' ')
					else
						not_first := True
					end
					make_file.put_string (packet_name (dir_prefix, i))
					make_file.put_character ('/')
					make_file.put_character (dir_prefix)
					make_file.put_string ("obj")
					make_file.put_integer (i)
					make_file.put_string (".o")
				end
				i := i - 1
			end
		end

	safe_recursive_delete (a_dir: STRING) is
			-- Delete `a_dir' content.
		require
			a_dir_not_void: a_dir /= Void
			a_dir_not_empty: not a_dir.is_empty
		local
			retried: BOOLEAN
			l_dir: DIRECTORY
		do
			if not retried then
				create l_dir.make (a_dir)
				if l_dir.exists then
					l_dir.recursive_delete
				end
			end
		rescue
			retried := True
			retry
		end

	safe_external_path (a_path: STRING; a_force_quotation: BOOLEAN) is
			-- If `a_path' has no white spaces or if `a_force_quotation', add the `"' around it.
			-- If it has some white spaces, we cannot do anything since it would
			-- break existing code.
		require
			a_path_not_void: a_path /= Void
			a_path_not_empty: not a_path.is_empty
		do
			a_path.left_adjust
			a_path.right_adjust
			if
				a_force_quotation or else
				(not a_path.has (' ') and not a_path.has ('%T'))
			then
					-- If the path has no white space, then we can safely add the " around it
					-- so that it will work in case the path is expanded with an environment
					-- variable containing spaces. Of course we only do it if no " are already
					-- present.
				if a_path.item (1) /= '"' then
					a_path.prepend_character ('"')
				end
				if a_path.item (a_path.count) /= '"' then
					a_path.append_character ('"')
				end
			end
		end

feature {NONE} -- Constants

	lib_location: STRING is
			-- Location of run-time library files.
		once
			if System.uses_ise_gc_runtime then
				Result := "$rt_lib/"
			else
				Result := "\$(ISE_EIFFEL)/studio/spec/\$(ISE_PLATFORM)/lib-"
				Result.append (System.external_runtime)
				Result.append_character ('/')
			end
		ensure
			lib_location_not_void: Result /= Void
		end

	boehm_library: STRING is
			-- Addition library if boehm is selected
		do
			if not system.uses_ise_gc_runtime and then system.external_runtime.as_lower.is_equal ("boehm") then
				Result := " %"\$(ISE_EIFFEL)/studio/spec/\$(ISE_PLATFORM)/lib-boehm/"
				Result.append ("$prefix")
				Result.append ("$boehmgclib")
				Result.append ("$suffix%"")
			else
				Result := ""
			end
		ensure
			boehm_library_not_void: Result /= Void
			boehm_library_has_space_if_not_empty: not Result.is_empty implies Result.item (1) = ' '
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
