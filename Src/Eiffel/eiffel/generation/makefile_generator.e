note
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

	SHARED_BATCH_NAMES

	SHARED_ERROR_HANDLER

	SHARED_CONFIGURE_RESOURCES

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

	Packet_number: INTEGER
			-- Maximum number of files in a single linking phase in Workbench mode.
		once
			Result := configure_resources.get_integer ({SHARED_CONFIGURE_RESOURCES}.r_workbench_c_basket_limit, 33)
		end

	Final_packet_number: INTEGER
			-- Maximum number of files in a single linking phase in Final mode.
		once
			Result := configure_resources.get_integer ({SHARED_CONFIGURE_RESOURCES}.r_finalized_c_basket_limit, 50)
		end

	System_packet_number: INTEGER = 20
			-- Maximum number of files in a single linking phase

feature -- Initialization

	make
			-- Creation
		do
			create cecil_rt_basket.make
			create empty_class_types.make (50)
		end

	init_objects_baskets
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
			create object_baskets.make_filled (create {LINKED_LIST [STRING]}.make, 1, basket_nb)
			from i := 2 until i > basket_nb loop
				create basket.make
				object_baskets.put (basket, i)
				i := i + 1
			end

			create system_baskets.make_filled (create {LINKED_LIST [STRING]}.make, 1, system_basket_nb)
			from i := 2 until i > system_basket_nb loop
				create basket.make
				system_baskets.put (basket, i)
				i := i + 1
			end
		end

	clear
			-- Forget the lists
		do
			object_baskets := Void
			system_baskets := Void
			cecil_rt_basket := Void
			empty_class_types := Void
		end

feature

	run_time: STRING
			-- Run time with which the application must be linked
		deferred
		end

	system_name: STRING
			-- Name of executable
		do
			Result := System.name
		end

feature -- Object basket managment

	add_specific_objects
			-- Add objects specific to Current compilation mode.
		deferred
		end

	add_eiffel_objects
			-- Insert objects files in basket.
		deferred
		end

	add_in_primary_system_basket (base_name: STRING)
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

	add_in_system_basket (base_name: STRING; basket_number: INTEGER)
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

	add_common_objects
			-- Add common objects file
		do
			add_in_primary_system_basket (Eplug)
			add_in_primary_system_basket (Eskelet)
			add_in_primary_system_basket (Enames)
			add_in_primary_system_basket (Evisib)
			add_in_primary_system_basket (Ececil)
			add_in_primary_system_basket (Einit)
			add_in_primary_system_basket (Eparents)
		end

feature -- Cecil

	add_cecil_objects
		deferred
		end

	generate_cecil
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

	generate_dynamic_lib
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
			make_file.put_string ("/egc_dynlib.o: Makefile ")
			make_file.put_string (packet_name (system_object_prefix, 1))
			make_file.put_string ("/Makefile")
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
			make_file.put_string ("/Makefile ")
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

	generate
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

	generate_il (has_il_cpp: BOOLEAN)
			-- Generate make files
		local
			basket: LINKED_LIST [STRING]
		do
			create system_baskets.make_empty
			create basket.make
			basket.extend (System.name + ".o")
			object_baskets := <<basket>>

			make_file := make_f (system.in_final_mode)

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

	generate_sub_makefiles (sub_dir: CHARACTER; baskets: ARRAY [LINKED_LIST [STRING]])
				-- Generate makefile in subdirectories.
		require
			baskets_not_void: baskets /= Void
		local
			old_makefile: like make_file
			nb, i: INTEGER
			f_name: like full_file_name
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
					f_name := full_file_name (system.in_final_mode, packet_name (sub_dir, i), Makefile_sh, Void)
					create make_file.make_open_write (f_name)
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
		rescue
			if f_name /= Void then
				error_handler.insert_error (create {C_COMPILER_ERROR}.make (messages.w_not_creatable (f_name.name)))
				error_handler.raise_error
			end
		end

	cleanup_generated_makefiles (sub_dir: CHARACTER; baskets: ARRAY [LINKED_LIST [STRING]])
			-- Remove directory when associated baskets is empty.
		require
			baskets_not_void: baskets /= Void
		local
			nb, i: INTEGER
			f_name: PATH
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
						f_name := project_location.final_path
					else
						f_name := project_location.workbench_path
					end
					safe_recursive_delete (f_name.extended (packet_name (sub_dir, i)))
				end
				i := i + 1
			end
		end

feature -- Generation, Header

	generate_compilation_rule
			-- Generates the .c -> .o compilation rule
		deferred
		end

	generate_specific_defines
			-- Generate specific "-D" flags.
			-- Do nothing by default.
		do
		end

	generate_preamble
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

	generate_sub_preamble (a_directory: STRING)
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

	generate_customization (has_il_cpp: BOOLEAN)
			-- Customize generic Makefile
		do
			generate_include_path
			make_file.put_string ("%
				%SHELL = /bin/sh%N%
				%CC = $cc%N%
				%CPP = $cpp%N")

			generate_cflags ("CFLAGS", "ccflags")
			generate_cflags ("CPPFLAGS", "cppflags")

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

feature {NONE} -- Generation, Header

	generate_cflags (name: STRING; option: STRING)
			-- Generate CFLAGS of name `name` with specific options `option` in the format
			-- "name = ... (mt)option ...".
		require
			valid_name: name.same_string ("CFLAGS") or name.same_string ("CPPFLAGS")
			valid_option: option.same_string ("ccflags") or option.same_string ("cppflags")
			consistent_name_and_option: name.same_string ("CFLAGS") implies option.same_string ("ccflags")
		do
			make_file.put_string (name)

			make_file.put_string (if System.in_final_mode then " = $optimize " else " = $wkoptimize " end)

			if System.il_generation then
				make_file.put_string ("$il_flags ")
			end

			make_file.put_string (if System.has_multithreaded then "$mt" else "$" end)
			make_file.put_string (option)
			make_file.put_string (" $large ")

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

			if not system.total_order_on_reals then
				make_file.put_string ("-DEIF_IEEE_BEHAVIOR ")
			end

			generate_specific_defines

			make_file.put_string ("-I%"$rt_include%" ")
			make_file.put_string ("-I. %H$(INCLUDE_PATH)%N")
		end

feature -- Generation, Object list(s)

	generate_macro (mname: STRING; basket: LINKED_LIST [STRING])
			-- Generate a bunch of objects to be put in macro `mname'
		local
			size: INTEGER
			file_name: STRING
		do
			make_file.put_string (mname)
			make_file.put_string (" = ")
			across
				basket as b
			from
				size := mname.count + 3
			loop
				file_name := b.item
				size := size + file_name.count + 1
				if size > 78 then
					make_file.put_character (Continuation)
					make_file.put_new_line
					make_file.put_character ('%T')
					size := 8 + file_name.count + 1
				end
				make_file.put_string (file_name)
				make_file.put_character (' ')
			end
			make_file.put_new_line
			make_file.put_new_line
		end

feature -- Generation, External archives and object files.

	generate_externals
			-- Generate declaration fo the external variable
		local
			l_has_items: BOOLEAN
			l_prefix: STRING
		do
				-- Every item is placed on a new line.
			l_prefix := " " + continuation.out + "%N%T"
				-- Add the object files.
			if attached universe.conf_system.all_external_object as e then
				generate_external_section ("EXTERNALS", e, False, l_prefix, False, True)
				l_has_items := True
			end
				-- Add the libraries.
			if attached universe.conf_system.all_external_library as e then
				generate_external_section ("EXTERNALS", e, False, l_prefix, l_has_items, True)
				l_has_items := True
			end
				-- Add the linker flags.
			if attached universe.conf_system.all_external_linker_flag as e then
				generate_external_section ("EXTERNALS", e, False, l_prefix, l_has_items, False)
				l_has_items := True
			end
			if l_has_items then
					-- Add empty line.
				make_file.put_new_line
				make_file.put_new_line
			end
		end

	generate_include_path
			-- Generate declaration fo the include_paths
		local
			l_has_items: BOOLEAN
		do
				-- Add the include paths.
			if attached universe.conf_system.all_external_include as e then
				generate_external_section ("INCLUDE_PATH", e, True, " -I", False, True)
				l_has_items := True
			end
				-- Add the C flags.
			if attached universe.conf_system.all_external_cflag as e then
				generate_external_section ("INCLUDE_PATH", e, False, " ", l_has_items, False)
				l_has_items := True
			end
			if l_has_items then
					-- Add new line.
				make_file.put_new_line
			end
		end

	generate_makefile_names
		do
				-- Add the makefiles.
			if attached universe.conf_system.all_external_make as e then
				generate_external_section ("EXTERNAL_MAKEFILES", e, False, " ", False, True)
				make_file.put_new_line
			end
		end

feature {NONE} -- Generate externals

	generate_external_section (a_name: STRING; a_data: ARRAYED_LIST [CONF_EXTERNAL]; a_is_mask_dollar: BOOLEAN;
		a_prefix: STRING; a_is_generated, a_is_path: BOOLEAN)
			-- Generate a section `a_name' with data `a_data' representing paths if `a_is_path',
			-- masking dollar sign if `a_is_mask_dollar' and prefixing each item with `a_prefix'.
			-- Prepend data by name if `not a_is_generated'.
		require
			a_name_attached: attached a_name
			a_data_attached: attached a_data
			a_prefix_attached: attached a_prefix
		local
			l_added_items: SEARCH_TABLE [STRING_32]
			l_path: STRING_32
			l_state: CONF_STATE
			u: UTF_CONVERTER
		do
			if not a_is_generated then
				make_file.put_string (a_name)
				make_file.put_string (" = ")
			end
			create l_added_items.make (10)
			l_state := universe.conf_state
			across a_data as c loop
				if c.item.is_enabled (l_state) then
					l_path := c.item.location
					if a_is_path then
							-- Protect paths.
						safe_external_path (l_path)
					else
							-- Preserve options.
						l_path.left_adjust
						l_path.right_adjust
					end
					if a_is_mask_dollar then
							-- Mask all remaining '$'.
						l_path.replace_substring_all ({STRING_32} "$", {STRING_32} "\$")
							-- Correct double masking if '$' were already masked.
						l_path.replace_substring_all ({STRING_32} "\\$", {STRING_32} "\$")
					end
						-- Don't add the same items multiple times.
					if not l_added_items.has (l_path) then
						l_added_items.force (l_path)
						make_file.put_string (a_prefix)
						make_file.put_string (u.utf_32_string_to_utf_8_string_8 (l_path))
					end
				end
			end
		end

feature -- Generation (Linking rules)

	generate_il_dll
			-- Generate rules to produce DLL for IL code generation.
			--| So far this is a IL (.net) specific code generation.
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
			if system.is_il_netcore and then not {PLATFORM}.is_windows then
					-- FIXME: find a way to avoid checking for the current machine's platform [2023-09-08]

					-- FIXME: for now, no resource support for Eiffel netcore.
					-- Needed on non Windows platforms
					-- to rename .so file into .dll
				make_file.put_string ("IL_SYSTEM_DLL = lib")
				make_file.put_string (system_name)
				make_file.put_string (".dll%N")

				make_file.put_string ("[
					$(IL_SYSTEM): $(OBJECTS)
						$(RM) $(IL_SYSTEM)
						$(SHAREDLINK) $(LDSHAREDFLAGS) $(IL_SYSTEM) $(IL_OBJECTS) $(EXTERNALS) $(EIFLIB) $(SHAREDLIBS)
						$(CP) $(IL_SYSTEM) $(IL_SYSTEM_DLL)
						$(RM) $(OBJECTS)
						echo Success > completed.eif
				]")
				make_file.put_new_line
				make_file.put_new_line
			else
				make_file.put_string ("$il_system_compilation_line")
				make_file.put_new_line
			end
			make_file.put_new_line
		end

	generate_executable
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

	generate_simple_executable
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

	generate_additional_rules
		do
		end

	generate_precompile_objects
		do
		end

	generate_system_objects_macros
			-- Generate the system object macros
			-- (dependencies for final executable).
		local
			l_baskets: like system_baskets
		do
			if system_baskets.count > 1 then
					-- System object files.
				l_baskets := system_baskets.subarray (system_baskets.lower + 1, system_baskets.upper)
				generate_basket_objects (l_baskets, system_object_prefix)
			end

				-- Generate `system_baskets [1]' now.
				-- It is needed because on some platforms (e.g SGI) Eobj1.o is too big
				-- to be linked.
			across
				system_baskets [1] as b
			loop
				make_file.put_character (' ')
				make_file.put_string (packet_name (system_object_prefix, 1))
				make_file.put_character ('/')
				make_file.put_string (b.item)
			end
		end

	generate_objects_macros
			-- Generate the object macros (dependencies for final executable)
		do
				-- Class object files.
			generate_basket_objects (object_baskets, C_prefix)
		end

	generate_subdir_names
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

	generate_partial_objects_linking (dir_prefix: CHARACTER; index: INTEGER)
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

	generate_partial_system_objects_dependencies
			-- Depencies to update partial system objects in subdirectories.
		local
			i, nb: INTEGER
			emain_file: STRING
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
			make_file.put_character ('"')
			make_file.put_string (packet_name (system_object_prefix, 1))
			make_file.put_string ("/emain.c%"")
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

			across
				system_baskets [1] as b
			loop
				make_file.put_string (packet_name (system_object_prefix, 1))
				make_file.put_character ('/')
				make_file.put_string (b.item)
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
				make_file.put_string (b.item)
				make_file.put_string ("%N%N")
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

	generate_partial_objects_dependencies
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

	generate_main_cleaning
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

	generate_sub_cleaning
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

	generate_ending
			-- Ends Makefile wrapping scheme
		do
			make_file.put_string ("%
				%!NO!SUBS!%N%
				%chmod 644 Makefile%N%
				%$eunicefix Makefile%N")
		end

feature -- Removal of empty classes

	record_empty_class_type (a_class_type: INTEGER)
			-- add `a_class_type' to the set of class types that
			-- are not generated
		do
			empty_class_types.put (a_class_type)
		end

feature {NONE} -- Implementation

	generate_basket_objects (baskets: ARRAY [LINKED_LIST [STRING]]; dir_prefix: CHARACTER)
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

	safe_recursive_delete (a_dir: PATH)
			-- Delete `a_dir' content.
		require
			a_dir_not_void: a_dir /= Void
			a_dir_not_empty: not a_dir.is_empty
		local
			retried: BOOLEAN
			l_dir: DIRECTORY
		do
			if not retried then
				create l_dir.make_with_path (a_dir)
				if l_dir.exists then
					l_dir.recursive_delete
				end
			end
		rescue
			retried := True
			retry
		end

	safe_external_path (a_path: STRING_32)
			-- Add double quotes around `a_path' if necessary.
		require
			a_path_not_void: a_path /= Void
			a_path_not_empty: not a_path.is_empty
		do
			a_path.left_adjust
			a_path.right_adjust
				-- Add the double quotes around path so that
				-- it will work in case the path has white spaces.
				-- Do it if no double quotes are already present.
			if a_path.item (1) /= '"' then
				a_path.prepend_character ('"')
			end
			if a_path.item (a_path.count) /= '"' then
				a_path.append_character ('"')
			end
		end

feature {NONE} -- Constants

	lib_location: STRING
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

	boehm_library: STRING
			-- Addition library if boehm is selected
		do
			if not system.uses_ise_gc_runtime and then system.external_runtime.is_case_insensitive_equal ("boehm") then
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

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
