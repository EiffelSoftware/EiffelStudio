-- Makefile generation control. The generated Makefile.SH is to be run through
-- /bin/sh to get properly instantiated for a given platform. A partial linking
-- of `Packet_number' files is done, as needed to avoid kernel internal argument
-- space overflow.

deferred class MAKEFILE_GENERATOR 

inherit

	SHARED_CODE_FILES;
	SHARED_WORKBENCH;
	SHARED_GENERATOR;
	SHARED_BYTE_CONTEXT
		rename
			context as byte_context
		end;

feature -- Attributes

	object_baskets: ARRAY [EXTEND_STACK [STRING]];
			-- The entire set of class object files we have 
			-- to make

	descriptor_baskets: ARRAY [EXTEND_STACK [STRING]];
			-- The entire set of descriptor files we have
			-- to make

	feat_table_baskets: ARRAY [EXTEND_STACK [STRING]];
			-- The entire set of feature table files we have
			-- to make

	system_basket: EXTEND_STACK [STRING];
			-- The entire set of system object files we have 
			-- to make

	cecil_rt_basket: EXTEND_STACK [STRING];
			-- Run-time object files to be put in the Cecil
			-- archive

	empty_class_types: TWO_WAY_SORTED_SET [INTEGER];
			-- Set of all the class types that have no used
			-- features (final mode), i.e. the C file would
			-- be empty.

	partial_system_objects: INTEGER;
			-- Number of partial object files needed
			-- for system object files

	Packet_number: INTEGER is
			-- Maximum number of files in a single linking phase
		once
			Result := eif_packet_size
		end;

feature -- Initialization

	make is
			-- Creation
		do
			!!system_basket.make;
			!!cecil_rt_basket.make;
			!!empty_class_types.make
		end;

	init_objects_baskets is
			-- Create objects baskets.
		local
			basket_nb, i: INTEGER;
			basket: EXTEND_STACK [STRING]
		do
			basket_nb := 1 + (System.static_type_id_counter.value - 
							System.max_precompiled_type_id) // Packet_number;
			!!object_baskets.make (1, basket_nb);
			from i := 1 until i > basket_nb loop
				!!basket.make;
				object_baskets.put (basket, i);
				i := i + 1
			end;
			!!descriptor_baskets.make (1, basket_nb);
			from i := 1 until i > basket_nb loop
				!!basket.make;
				descriptor_baskets.put (basket, i);
				i := i + 1
			end;
			basket_nb := 1 + (System.class_counter.value - 
								System.max_precompiled_id) // Packet_number;
			!!feat_table_baskets.make (1, basket_nb);
			from i := 1 until i > basket_nb loop
				!!basket.make;
				feat_table_baskets.put (basket, i);
				i := i + 1
			end
		end;

	clear is
			-- Forget the lists
		do
			object_baskets := Void;
			descriptor_baskets := Void;
			feat_table_baskets := Void;
			system_basket := Void;
			cecil_rt_basket := Void;
			empty_class_types := Void;
		end;

feature

	run_time: STRING is
			-- Run time with which the application must be linked
		deferred
		end;

	system_name: STRING is
			-- Name of executable
		do
			Result := System.system_name
		end;

feature -- Object basket managment

	add_specific_objects is
			-- Add objects specific to Current compilation mode.
		deferred
		end;

	add_eiffel_objects is
			-- Insert objects files in basket.
		deferred
		end;

	add_in_system_basket (base_name: STRING) is
		local	
			object_name: STRING
		do
			!!object_name.make (0);
			object_name.append (base_name);
			object_name.append (Dot_o);
			system_basket.put (object_name)
		end;

	add_common_objects is
			-- Add common objects file
		do
			add_in_system_basket (Econform);
			add_in_system_basket (Eplug);
			add_in_system_basket (Eskelet);
			add_in_system_basket (Evisib);
			add_in_system_basket (Einit);
		end;

	compute_partial_system_objects is
			-- Compute number of partial system objects needed.
		do
			partial_system_objects := system_basket.count // Packet_number;
			if (system_basket.count \\ Packet_number) /= 0 then
				partial_system_objects := partial_system_objects + 1;
			end
		end;

feature -- Cecil

	add_cecil_objects is
		deferred
		end;

	generate_cecil is
		local
			libname: STRING;
		do
				-- Cecil run-time macro
			generate_macro ("RCECIL", cecil_rt_basket);

				-- Cecil library prodcution rule
			Make_file.putstring ("cecil: ");
			generate_objects_macros;
			Make_file.putchar (' ');
			generate_system_objects_macros;
			Make_file.putstring (" Makefile%N%Tar x ");
			Make_file.putstring (run_time);
			Make_file.new_line;
			Make_file.putstring ("%Tar cr ");
				!! libname.make (0);
				libname.append ("lib");
				libname.append (system_name);
				libname.append (".a");
			Make_file.putstring (libname);
			Make_file.putchar (' ');
			generate_objects_macros;
			Make_file.putchar (' ');
			generate_system_objects_macros;
			Make_file.putchar (' ');
			Make_file.putchar (continuation);
			Make_file.new_line;
			generate_other_objects;
			Make_file.putstring ("%T%T$(RCECIL)");
			Make_file.new_line;
			Make_file.putstring ("%T$(RANLIB) ");
			Make_file.putstring (libname);
			Make_file.new_line;
			Make_file.putstring ("%T$(RM) $(RCECIL)");
			Make_file.new_line;
		end;

feature -- Actual generation

	make_file: INDENT_FILE is
		do
			Result := System.make_file;
		end;

	generate is
			-- Generate make files
		do
			init_objects_baskets;
				-- Insert all the class objects in the baskets.
			add_eiffel_objects;
				-- Add objects specific to Current compilation mode
			add_specific_objects;
				-- Add objects common to all compilation modes.
			add_common_objects;
			add_cecil_objects;

				-- Compute number of partial system objects needed
				-- and generate corresponding object lists.
			compute_partial_system_objects;

				-- Generate makefile in subdirectories.
			generate_sub_makefiles (Feature_table_suffix, feat_table_baskets);
			generate_sub_makefiles (Descriptor_suffix, descriptor_baskets);
			generate_sub_makefiles (Class_suffix, object_baskets);
			generate_system_makefile;

			System.set_make_file (make_f (system.in_final_mode));
			Make_file.open_write;
				-- Generate main /bin/sh preamble
			generate_preamble;
				-- Customize main Makefile macros
			generate_customization;
				-- How to produce a .o from a .c file
			generate_compilation_rule;

				-- Generate external objects
			generate_externals;

				-- Generate executable
			generate_executable;

				-- Generate Cecil rules
			generate_cecil;

				-- End production
			generate_ending;

			Make_file.close;
			System.set_make_file (Void);
			object_baskets := Void;
			descriptor_baskets := Void;
			feat_table_baskets := Void;
			system_basket.wipe_out;
			cecil_rt_basket.wipe_out;
		end;

feature -- Sub makefile generation

	generate_sub_makefiles (sub_dir: STRING; 
							baskets: ARRAY [EXTEND_STACK [STRING]]) is
				-- Generate makefile in subdirectories.
		local
			new_makefile, old_makefile: INDENT_FILE;
			baskets_count, i: INTEGER;
			dir_name: STRING
		do
			old_makefile := System.make_file;
			from
				baskets_count := baskets.count;
				i := 1
			until
				i > baskets_count
			loop
				if system.in_final_mode then
					dir_name := Final_generation_path
				else
					dir_name := Workbench_generation_path
				end;
				dir_name := build_path (dir_name, sub_dir);
				dir_name.append_integer (i);
				!!new_makefile.make (build_path (dir_name, Makefile_SH));
				System.set_make_file (new_makefile);
				Make_file.open_write;
					-- Generate main /bin/sh preamble
				generate_sub_preamble;
					-- Customize main Makefile macros
				generate_customization;
					-- How to produce a .o from a .c file
				generate_compilation_rule;
					-- Generate object list.
				generate_macro ("OBJECTS", baskets.item (i));
					-- Generate partial object.
				Make_file.putstring ("all: ")
				Make_file.putstring (sub_dir);
				Make_file.putstring ("obj")
				Make_file.putint (i);
				Make_file.putstring (".o");
				Make_file.new_line;
				Make_file.new_line;
				generate_partial_objects_linking (sub_dir, i);
					-- End production.
				generate_ending;
				Make_file.close;
				i := i + 1
			end;
			System.set_make_file (old_makefile)
		end;

	generate_system_makefile is
			-- Create makefile to build system objects.
		local
			new_makefile, old_makefile: INDENT_FILE;
			baskets_count, i: INTEGER;
			dir_name: STRING
		do
			old_makefile := System.make_file;
			if system.in_final_mode then
				dir_name := Final_generation_path
			else
				dir_name := Workbench_generation_path
			end;
			dir_name := build_path (dir_name, System_object_prefix);
			dir_name.append_integer (1);
			!!new_makefile.make (build_path (dir_name, Makefile_SH));
			System.set_make_file (new_makefile);
			Make_file.open_write;
				-- Generate main /bin/sh preamble
			generate_sub_preamble;
				-- Customize main Makefile macros
			generate_customization;
				-- How to produce a .o from a .c file
			generate_compilation_rule;
				-- Generate object list.
			generate_system_objects_lists;
				-- Generate partial object.
			Make_file.putstring ("all: Emain.o")
			from i := 1 until i > partial_system_objects loop
				Make_file.putchar (' ');
				Make_file.putstring (System_object_prefix);
				Make_file.putstring ("obj")
				Make_file.putint (i);
				Make_file.putstring (".o");
				i := i + 1
			end;
			Make_file.new_line;
			Make_file.new_line;
			generate_partial_system_objects_linking;
				-- End production.
			generate_ending;
			Make_file.close;
			System.set_make_file (old_makefile)
		end;

feature -- Generation, Header

	generate_compilation_rule is
			-- Generates the .c -> .o compilation rule
		deferred
		end;

	generate_specific_defines is
			-- Generate specific "-D" flags.
			-- Do nothing by default.
		do
		end;

	generate_preamble is
			-- Generate leading part (directions to /bin/sh)
		do
			Make_file.putstring ("case $CONFIG in%N'')%N");
			Make_file.putstring ("%
				%%Tif test ! -f config.sh; then%N%
				%%T%T(echo %"Can't find config.sh.%"; exit 1)%N%
				%%Tfi 2>/dev/null%N%
				%%T. ./config.sh%N%
				%%T;;%N%
				%esac%N");
			Make_file.putstring ("%
				%case %"$O%" in%N%
				%*/*) cd `expr X$0 : 'X\(.*\)/'` ;;%N%
				%esac%N");
			Make_file.putstring ("%
				%echo %"Extracting %".%"/Makefile%
								% (with variable substitutions)%"%N%
				%$spitshell >Makefile <<!GROK!THIS!%N");
		end;

	generate_sub_preamble is
			-- Generate leading part (directions to /bin/sh)
			-- for subdirectory Makefiles.
		do
			Make_file.putstring ("case $CONFIG in%N'')%N");
			Make_file.putstring ("%
				%%Tif test ! -f ../config.sh; then%N%
				%%T%T(echo %"Can't find ../config.sh.%"; exit 1)%N%
				%%Tfi 2>/dev/null%N%
				%%T. ../config.sh%N%
				%%T;;%N%
				%esac%N");
			Make_file.putstring ("%
				%case %"$O%" in%N%
				%*/*) cd `expr X$0 : 'X\(.*\)/'` ;;%N%
				%esac%N");
			Make_file.putstring ("%
				%echo %"Extracting %".%"/Makefile%
								% (with variable substitutions)%"%N%
				%$spitshell >Makefile <<!GROK!THIS!%N");
		end;

	generate_customization is
			-- Customize generic Makefile
		do
			Make_file.putstring ("%
				%SHELL = /bin/sh%N%
				%CC = $cc%N%
				%CFLAGS = $optimize $ccflags $large ");
			generate_specific_defines;
			Make_file.putstring ("-I%H$(EIFFEL3)/bench/spec/%H$(PLATFORM)/include%N%
				%LDFLAGS = $ldflags%N%
				%LIBS = $libs%N%
				%MAKE = make%N%
				%MKDEP = $mkdep %H$(DPFLAGS) --%N%
				%MV = $mv%N%
				%RANLIB = $ranlib%N%
				%RM = $rm -f%N%N");
			Make_file.putstring ("%
				%!GROK!THIS!%N%
				%$spitshell >>Makefile <<'!NO!SUBS!'%N");
		end;

feature -- Generation, Object list(s)

	generate_system_objects_lists is
			-- Generate the EOBJECTS/EOBJ1,EOBJ2,EOBJ3... macros in Makefile
		local
			i: INTEGER;
			macro_name: STRING;
		do
			from
				i := 1;
			until
				i > partial_system_objects
			loop
				!!macro_name.make (4);
				macro_name.append ("EOBJ");
				macro_name.append_integer (i);
				generate_macro (macro_name, system_basket);
				i := i + 1;
			end;
		end;
	
	generate_macro (mname: STRING; basket: EXTEND_STACK [STRING]) is
			-- Generate a bunch of objects to be put in macro `mname'
		local
			size, amount: INTEGER;
			file_name: STRING;
		do
			Make_file.putstring (mname);
			Make_file.putstring (" = ");
			from
				amount := 0;
				size := mname.count + 3;
			until
				amount >= Packet_number or basket.empty
			loop
				file_name := basket.item;
				basket.remove;
				size := size + file_name.count + 1;
				if size > 78 then
					Make_file.putchar (Continuation);
					Make_file.new_line;
					Make_file.putchar ('%T');
					size := 8 + file_name.count + 1;
					Make_file.putstring (file_name);
				else
					Make_file.putstring (file_name);
				end;
				Make_file.putchar (' ');
				amount := amount + 1;
			end;
			Make_file.new_line;
			Make_file.new_line;
		end;

feature -- Generation, External archives and object files.

	generate_externals is
			-- Generate declaration fo the external variable
		local
			object_file_names: FIXED_LIST [STRING];
			i, nb: INTEGER;
		do
			object_file_names := System.object_file_names;
			if object_file_names /= Void then
				Make_file.putstring ("EXTERNALS = ");
				from
					i := 1;
					nb := object_file_names.count;
				until
					i > nb
				loop
					Make_file.putchar (' ');
					Make_file.putchar (Continuation);
					Make_file.putstring ("%N%T");
					Make_file.putstring (object_file_names.i_th (i));
					i := i + 1
				end;
				Make_file.new_line;
				Make_file.new_line;
			end
		end;

	generate_makefile_names is
		require
			list_not_void: System.makefile_names /= Void
		local
			makefile_names: FIXED_LIST [STRING];
			i, nb: INTEGER;
		do
			makefile_names := System.makefile_names;
			from
				i := 1;
				nb := makefile_names.count;
			until
				i > nb
			loop
				Make_file.putstring ("%T$(MAKE) -f ");
				Make_file.putstring (makefile_names.i_th (i));
				Make_file.new_line;
				i := i + 1;
			end;
		end;

feature -- Generation (Linking rules)

	generate_executable is
			-- Generate rules to produce executable
		do
			Make_file.putstring ("all: ");
			Make_file.putstring (System.system_name);
			Make_file.new_line;
			Make_file.new_line;
			generate_partial_objects_dependencies;
			generate_partial_system_objects_dependencies;
			generate_simple_executable
		end;
	

	generate_simple_executable is
			-- Generate rule to produce simple executable, linked in
			-- with `run_time' archive.
		do
			Make_file.putstring (System.system_name);
			Make_file.putstring (": ");
			generate_objects_macros;
			Make_file.putchar (' ');
			generate_system_objects_macros;
			Make_file.putchar (' ');
			Make_file.putstring (System_object_prefix);
			Make_file.putint (1);
			Make_file.putchar (Directory_separator);
			Make_file.putstring (Emain);
			Make_file.putstring (Dot_o);
			Make_file.putstring (" Makefile%N");
			Make_file.putstring ("%T$(RM) ");
			Make_file.putstring (system_name);
			Make_file.new_line;
			if System.makefile_names /= Void then
				generate_makefile_names;
			end;
			Make_file.putstring ("%T$(CC) -o ");
			Make_file.putstring (system_name);
			Make_file.putstring ("%
				% $(CFLAGS) $(LDFLAGS) ");
			generate_objects_macros;
			Make_file.putchar (' ');
			generate_system_objects_macros;
			Make_file.putchar (' ');
			Make_file.putstring (System_object_prefix);
			Make_file.putint (1);
			Make_file.putchar (Directory_separator);
			Make_file.putstring (Emain);
			Make_file.putstring (Dot_o);
			Make_file.putchar (' ');
			Make_file.putchar (Continuation);
			Make_file.new_line;
			generate_other_objects;
			Make_file.putstring ("%T%T");
			if System.object_file_names /= Void then
				Make_file.putstring ("$(EXTERNALS) ");
			end;
			Make_file.putstring (run_time);
			Make_file.putstring (" $(LIBS)%N");

			generate_additional_rules;
			Make_file.new_line;
		end;

	generate_additional_rules is
		do
		end;

	generate_other_objects is
		do
		end;

	generate_system_objects_macros is
			-- Generate the system object macros 
			-- (dependencies for final executable).
		local
			i: INTEGER;
		do
			from
				i := 1;
			until
				i > partial_system_objects
			loop
				if i > 1 then
					Make_file.putchar (' ')
				end;
				Make_file.putstring (System_object_prefix);
				Make_file.putint (1);
				Make_file.putchar (Directory_separator);
				Make_file.putstring (System_object_prefix);
				Make_file.putstring ("obj");
				Make_file.putint (i);
				Make_file.putstring (".o");
				i := i + 1
			end
		end;

	generate_objects_macros is
			-- Generate the object macros (dependencies for final executable)
		local
			i, baskets_count: INTEGER;
		do
				-- Feature table object files.
			from
				baskets_count := feat_table_baskets.count;
				i := 1
			until
				i > baskets_count
			loop
				if i > 1 then
					Make_file.putchar (' ');
				end;
				Make_file.putstring (Feature_table_suffix);
				Make_file.putint (i);
				Make_file.putchar (Directory_separator);
				Make_file.putstring (Feature_table_suffix);
				Make_file.putstring ("obj");
				Make_file.putint (i);
				Make_file.putstring (".o");
				i := i + 1
			end;

			if i > 1 then
				Make_file.putchar (' ');
			end;

				-- Descriptor object files.
			from
				baskets_count := descriptor_baskets.count;
				i := 1
			until
				i > baskets_count
			loop
				if i > 1 then
					Make_file.putchar (' ');
				end;
				Make_file.putstring (Descriptor_suffix);
				Make_file.putint (i);
				Make_file.putchar (Directory_separator);
				Make_file.putstring (Descriptor_suffix);
				Make_file.putstring ("obj");
				Make_file.putint (i);
				Make_file.putstring (".o");
				i := i + 1
			end;

			if i > 1 then
				Make_file.putchar (' ');
			end;

				-- Class object files.
			from
				baskets_count := object_baskets.count;
				i := 1
			until
				i > baskets_count
			loop
				if i > 1 then
					Make_file.putchar (' ');
				end;
				Make_file.putstring (Class_suffix);
				Make_file.putint (i);
				Make_file.putchar (Directory_separator);
				Make_file.putstring (Class_suffix);
				Make_file.putstring ("obj");
				Make_file.putint (i);
				Make_file.putstring (".o");
				i := i + 1
			end
		end;

	generate_subdir_names is
			-- Generate the subdirectories' names.
		local
			i, baskets_count: INTEGER;
		do
				-- Feature table object files.
			from
				baskets_count := feat_table_baskets.count;
				i := 1
			until
				i > baskets_count
			loop
				if i > 1 then
					Make_file.putchar (' ');
				end;
				Make_file.putstring (Feature_table_suffix);
				Make_file.putint (i);
				i := i + 1
			end;

			if i > 1 then
				Make_file.putchar (' ');
			end;

				-- Descriptor object files.
			from
				baskets_count := descriptor_baskets.count;
				i := 1
			until
				i > baskets_count
			loop
				if i > 1 then
					Make_file.putchar (' ');
				end;
				Make_file.putstring (Descriptor_suffix);
				Make_file.putint (i);
				i := i + 1
			end;

			if i > 1 then
				Make_file.putchar (' ');
			end;

				-- Class object files.
			from
				baskets_count := object_baskets.count;
				i := 1
			until
				i > baskets_count
			loop
				if i > 1 then
					Make_file.putchar (' ');
				end;
				Make_file.putstring (Class_suffix);
				Make_file.putint (i);
				i := i + 1
			end;

			Make_file.putchar (' ');
			Make_file.putstring (System_object_prefix);
			Make_file.putint (1)
		end;

	generate_partial_objects_linking (suffix: STRING; index: INTEGER) is
			-- Generate rules to produce partial linking and the
			-- final executable linked in with `run_time'.
		do
			Make_file.putstring (suffix);
			Make_file.putstring ("obj");
			Make_file.putint (index);
			Make_file.putstring (".o: $(OBJECTS) Makefile");
			Make_file.new_line;
				-- The following is not portable (if people want to use
				-- their own linker).
				-- FIXME
			Make_file.putstring ("%Tld -r -o ");
			Make_file.putstring (suffix);
			Make_file.putstring ("obj");
			Make_file.putint (index);
			Make_file.putstring (".o $(OBJECTS)");

			if remove_after_partial then
				Make_file.putstring ("%N%T$(RM) $(OBJECTS)");
			end;

			Make_file.new_line;
			Make_file.new_line;
		end;

	generate_partial_system_objects_linking is
			-- Generate rules to produce partial linking and the
			-- final executable linked in with `run_time'.
		local
			i: INTEGER;
		do
			from
				i := 1;
			until
				i > partial_system_objects
			loop
				Make_file.putstring (System_object_prefix);
				Make_file.putstring ("obj")
				Make_file.putint (i);
				Make_file.putstring (".o: $(EOBJ")
				Make_file.putint (i);
				Make_file.putchar (')');
				Make_file.new_line;
					-- The following is not portable (if people want to use
					-- their own linker).
					-- FIXME
				Make_file.putstring ("%Tld -r -o ");
				Make_file.putstring (System_object_prefix);
				Make_file.putstring ("obj");
				Make_file.putint (i);
				Make_file.putstring (".o $(EOBJ")
				Make_file.putint (i);
				Make_file.putchar (')');

				if remove_after_partial then
					Make_file.putstring ("%N%T$(RM) $(EOBJ");
					Make_file.putint (i);
					Make_file.putchar (')');
				end;

				Make_file.new_line;
				Make_file.new_line;
				i := i + 1
			end
		end;

	generate_partial_system_objects_dependencies is
			-- Depencies to update partial system objects in subdirectories.
		local
			i: INTEGER
		do
			Make_file.putstring (System_object_prefix);
			Make_file.putint (1);
			Make_file.putchar (Directory_separator);
			Make_file.putstring ("Emain.o:%N%T cd ");
			Make_file.putstring (System_object_prefix);
			Make_file.putint (1);
			Make_file.putstring (" ; $(SHELL) Makefile.SH ; ")
			Make_file.putstring ("$(MAKE) Emain.o ; cd ..%N%N")
			from i := 1 until i > partial_system_objects loop
				Make_file.putstring (System_object_prefix);
				Make_file.putint (1);
				Make_file.putchar (Directory_separator);
				Make_file.putstring (System_object_prefix);
				Make_file.putstring ("obj");
				Make_file.putint (i);
				Make_file.putstring (".o:%N%Tcd ");
				Make_file.putstring (System_object_prefix);
				Make_file.putint (1);
				Make_file.putstring (" ; $(SHELL) Makefile.SH ; $(MAKE) ")
				Make_file.putstring (System_object_prefix);
				Make_file.putstring ("obj");
				Make_file.putint (i);
				Make_file.putstring (".o ; cd ..%N%N");
				i := i + 1
			end
		end;

	generate_partial_objects_dependencies is
			-- Depencies to update partial objects in subdirectories.
		local
			i, baskets_count: INTEGER;
		do
				-- Feature table object files.
			from
				baskets_count := feat_table_baskets.count;
				i := 1
			until
				i > baskets_count
			loop
				Make_file.putstring (Feature_table_suffix);
				Make_file.putint (i);
				Make_file.putchar (Directory_separator);
				Make_file.putstring (Feature_table_suffix);
				Make_file.putstring ("obj");
				Make_file.putint (i);
				Make_file.putstring (".o:%N%Tcd ");
				Make_file.putstring (Feature_table_suffix);
				Make_file.putint (i);
				Make_file.putstring (" ; $(SHELL) Makefile.SH ; ")
				Make_file.putstring ("$(MAKE) ; cd ..%N%N");
				i := i + 1
			end;
				-- Descriptor object files.
			from
				baskets_count := descriptor_baskets.count;
				i := 1
			until
				i > baskets_count
			loop
				Make_file.putstring (Descriptor_suffix);
				Make_file.putint (i);
				Make_file.putchar (Directory_separator);
				Make_file.putstring (Descriptor_suffix);
				Make_file.putstring ("obj");
				Make_file.putint (i);
				Make_file.putstring (".o:%N%Tcd ");
				Make_file.putstring (Descriptor_suffix);
				Make_file.putint (i);
				Make_file.putstring (" ; $(SHELL) Makefile.SH ; ");
				Make_file.putstring ("$(MAKE) ; cd ..%N%N");
				i := i + 1
			end;
				-- Class object files.
			from
				baskets_count := object_baskets.count;
				i := 1
			until
				i > baskets_count
			loop
				Make_file.putstring (Class_suffix);
				Make_file.putint (i);
				Make_file.putchar (Directory_separator);
				Make_file.putstring (Class_suffix);
				Make_file.putstring ("obj");
				Make_file.putint (i);
				Make_file.putstring (".o:%N%Tcd ");
				Make_file.putstring (Class_suffix);
				Make_file.putint (i);
				Make_file.putstring (" ; $(SHELL) Makefile.SH ; ");
				Make_file.putstring ("$(MAKE) ; cd ..%N%N");
				i := i + 1
			end
		end;

	remove_after_partial: BOOLEAN is
			-- Should the individual objects be removed
			-- after a partial linking?
		do
		end;

feature -- Generation, Tail
			
	generate_ending is
			-- Ends Makefile wrapping scheme
		do
			Make_file.putstring ("%
				%!NO!SUBS!%N%
				%chmod 644 Makefile%N%
				%$eunicefix Makefile%N");
		end;

feature -- Removal of empty classes

	record_empty_class_type (a_class_type: INTEGER) is
			-- add `a_class_type' to the set of class types that
			-- are not generated
		do
			empty_class_types.extend (a_class_type);
		end;

feature {NONE} -- Externals

	eif_packet_size: INTEGER is
			-- Maximum number of files in a single linking phase
		external
			"C"
		end;

end
