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

	object_basket: EXTEND_STACK [STRING];
			-- The entire set of class object files we have 
			-- to make

	system_basket: EXTEND_STACK [STRING];
			-- The entire set of system object files we have 
			-- to make

	cecil_rt_basket: EXTEND_STACK [STRING];
			-- Run-time object files to be put in the Cecil
			-- archive

	empty_class_types: SORTED_SET [INTEGER];
			-- Set of all the class types that have no used
			-- features (final mode), i.e. the C file would
			-- be empty.

	partial_objects: INTEGER;
			-- Number of partial objects files needed
			-- for class object files

	partial_system_objects: INTEGER;
			-- Number of partial object files needed
			-- for system object files

	Packet_number: INTEGER is 200;
			-- Maximum number of files in a single linking phase

feature -- Initialization

	make is
			-- Creation
		do
			!!object_basket.make;
			!!system_basket.make;
			!!cecil_rt_basket.make;
			!!empty_class_types.make
		end;

	clear is
			-- Forget the lists
		do
			object_basket := Void;
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

	add_common_objects is
			-- Add common objects file
		do
			system_basket.put ("Econform.o");
			system_basket.put ("Eplug.o");
			system_basket.put ("Eskelet.o");
			system_basket.put ("Evisib.o");
			system_basket.put ("Einit.o");
		end;

	compute_partial_objects is
			-- Compute number of partial objects needed.
		do
			partial_objects := object_basket.count // Packet_number;
			if (object_basket.count \\ Packet_number) /= 0 and
				partial_objects > 0
			then
				partial_objects := partial_objects + 1;
			end;
			if partial_objects = 1 then
				partial_objects := 0;
			end;

			partial_system_objects := system_basket.count // Packet_number;
			if (system_basket.count \\ Packet_number) /= 0 and
				partial_system_objects > 0
			then
				partial_system_objects := partial_system_objects + 1;
			end;
			if partial_system_objects = 1 then
				partial_system_objects := 0;
			end;
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
			generate_objects_macros (partial_objects, False);
			Make_file.putchar (' ');
			generate_objects_macros (partial_system_objects, True);
			Make_file.new_line;
			Make_file.putstring ("%Tar x ");
			Make_file.putstring (run_time);
			Make_file.new_line;
			Make_file.putstring ("%Tar cr ");
				!! libname.make (0);
				libname.append ("lib");
				libname.append (system_name);
				libname.append (".a");
			Make_file.putstring (libname);
			Make_file.putchar (' ');
			generate_objects_macros (partial_objects, False);
			Make_file.putchar (' ');
			generate_objects_macros (partial_system_objects, True);
			Make_file.putstring (" \%N");
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

	make_file: UNIX_FILE is
		do
			Result := System.make_file;
		end;

	generate is
			-- Generate make file
		do
			System.set_make_file (make_f (system.in_final_mode));
			Make_file.open_write;
				-- Generate main /bin/sh preamble
			generate_preamble;
				-- Customize main Makefile macros
			generate_customization;
				-- How to produce a .o from a .c file
			generate_compilation_rule;

				-- Add objects specific to Current compilation mode
			add_specific_objects;
				-- Add objects common to all compilation modes.
			add_common_objects;
				-- Insert all the class objects in the basket, so 
				-- that we may count them.
			add_eiffel_objects;

			add_cecil_objects;

				-- Compute number of partial objects needed
				-- and generate corresponding object lists.
			compute_partial_objects;
			generate_objects_lists;

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
			object_basket.wipe_out;
			system_basket.wipe_out;
			cecil_rt_basket.wipe_out;
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

	generate_customization is
			-- Customize generic Makefile
		do
			Make_file.putstring ("%
				%SHELL = /bin/sh%N%
				%CC = $cc%N%
				%CFLAGS = $optimize $ccflags $large ");
			generate_specific_defines;
			Make_file.putstring ("-I$(EIFFEL3)/bench/spec/$(PLATFORM)/include%N%
				%LDFLAGS = $ldflags%N%
				%LIBS = $libs%N%
				%MAKE = make%N%
				%MKDEP = $mkdep $(DPFLAGS) --%N%
				%MV = $mv%N%
				%RANLIB = $ranlib%N%
				%RM = $rm -f%N%N");
			Make_file.putstring ("%
				%!GROK!THIS!%N%
				%$spitshell >>Makefile <<'!NO!SUBS!'%N");
		end;

feature -- Generation, Object list(s)

	generate_objects_lists is
			-- Generate the OBJECTS/OBJ1,OBJ2,OBJ3... and
			-- EOBJECTS/EOBJ1,EOBJ2,EOBJ3... macros in Makefile
		local
			i: INTEGER;
			macro_name: STRING;
		do
			if partial_objects = 0 then
				generate_macro ("OBJECTS", object_basket);
			else
				from
					i := 1;
				until
					i > partial_objects
				loop
					!!macro_name.make (4);
					macro_name.append ("OBJ");
					macro_name.append_integer (i);
					generate_macro (macro_name, object_basket);
					i := i + 1;
				end;
			end;

			if partial_system_objects = 0 then
				generate_macro ("EOBJECTS", system_basket);
			else
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
					Make_file.putchar ('\');
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
					Make_file.putstring (" \%N%T");
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
			if (partial_objects /= 0) then
				generate_partial_linking (partial_objects, False)
			end;
			if (partial_system_objects /= 0) then
				generate_partial_linking (partial_system_objects, True)
			end;
			generate_simple_executable
		end;
	

	generate_simple_executable is
			-- Generate rule to produce simple executable, linked in
			-- with `run_time' archive.
		do
			Make_file.putstring (System.system_name);
			Make_file.putstring (": ");
			generate_objects_macros (partial_objects, False);
			Make_file.putchar (' ');
			generate_objects_macros (partial_system_objects, True);
			Make_file.putchar (' ');
			Make_file.putstring ("Emain.o");
			Make_file.new_line;
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
			generate_objects_macros (partial_objects, False);
			Make_file.putchar (' ');
			generate_objects_macros (partial_system_objects, True);
			Make_file.putchar (' ');
			Make_file.putstring ("Emain.o");
			Make_file.putchar (' ');
			Make_file.putchar ('\');
			Make_file.new_line;
			generate_other_objects;
			Make_file.putstring ("%T%T");
			if System.object_file_names /= Void then
				Make_file.putstring ("$(EXTERNALS) ");
			end;
			Make_file.putstring (run_time);
			Make_file.putstring (" $(LIBS)%N");

--
-- Commented out by Frederic Deramat 20/5/93.
-- Intermediate object files are kept.
--
--			if partial_objects > 0 then
--				Make_file.putstring ("%T$(RM) ");
--				generate_objects_macros;
--				Make_file.new_line;
--			end;

			generate_additional_rules;
			Make_file.new_line;
		end;

	generate_additional_rules is
		do
		end;

	generate_other_objects is
		do
		end;

	generate_objects_macros (nb: INTEGER; system_obj: BOOLEAN) is
			-- Generate the object macros (dependencies for final executable)
		local
			i: INTEGER;
		do
			if nb = 0 then
				if system_obj then
					Make_file.putstring ("$(EOBJECTS)");
				else
					Make_file.putstring ("$(OBJECTS)");
				end;
			else
				from
					i := 1;
				until
					i > nb
				loop
					if i > 1 then
						Make_file.putchar (' ');
					end;
					if system_obj then
						Make_file.putstring ("eobj");
					else
						Make_file.putstring ("obj");
					end;
					Make_file.putint (i);
					Make_file.putstring (".o");
					i := i + 1;
				end;
			end;
		end;

	generate_partial_linking (nb: INTEGER; system_obj: BOOLEAN) is
			-- Generate rules to produce partial linking and the
			-- final executable linked in with `run_time'.
		local
			i: INTEGER;
		do
			from
				i := 1;
			until
				i > nb
			loop
				if system_obj then
					Make_file.putstring ("e")
				end;
				Make_file.putstring ("obj");
				Make_file.putint (i);
				if system_obj then
					Make_file.putstring (".o: $(EOBJ")
				else
					Make_file.putstring (".o: $(OBJ");
				end;
				Make_file.putint (i);
				Make_file.putchar (')');
				Make_file.new_line;
					-- The following is not portable (if people want to use
					-- their own linker).
				Make_file.putstring ("%Tld -r -o ");
				if system_obj then
					Make_file.putstring ("e")
				end;
				Make_file.putstring ("obj");
				Make_file.putint (i);
				if system_obj then
					Make_file.putstring (".o $(EOBJ")
				else
					Make_file.putstring (".o $(OBJ");
				end;
				Make_file.putint (i);
				Make_file.putchar (')');

				if remove_after_partial then
					if system_obj then
						Make_file.putstring ("%N%T$(RM) $(EOBJ");
					else
						Make_file.putstring ("%N%T$(RM) $(OBJ");
					end;
					Make_file.putint (i);
					Make_file.putchar (')');
				end;

				Make_file.new_line;
				Make_file.new_line;
				i := i +1 ;
			end;
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
			empty_class_types.add (a_class_type);
		end;

end
