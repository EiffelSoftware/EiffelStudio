-- Makefile generation control. The generated Makefile.SH is to be ran through
-- /bin/sh to get properly instantiated for a given platform. A partial linking
-- of `Packet_number' files is done, as needed to avoid kernel internal argument
-- space overflow.

class MAKEFILE_GENERATOR 

inherit

	SHARED_CODE_FILES;
	SHARED_WORKBENCH;
	SHARED_GENERATOR;
	SHARED_BYTE_CONTEXT
		rename
			context as byte_context
		end;

creation

	make

	
feature

	object_basket: EXTEND_STACK [STRING];
			-- The entire set of object files we have to make

	partial_objects: INTEGER;
			-- Number of partial objects files needed

	Packet_number: INTEGER is 300;
			-- Maximum number of files in a single linking phase

	make is
			-- Creation
		do
			!!object_basket.make;
		end;

	generate is
			-- Generate make file
		local
			i, nb: INTEGER;
			run_time_name: STRING;
			final_mode: BOOLEAN;
		do
			Make_file.open_write;
				-- Generate main /bin/sh preamble
			generate_preamble;
				-- Customize main Makefile macros
			generate_customization;
				-- How to produce a .o from a .c file
			generate_compilation_rule;
			final_mode := byte_context.final_mode;
			if final_mode then
				add_final_mode_objects;
			else
				add_workbench_mode_objects;
			end;
			add_table_objects;
			add_common_objects;
				-- Insert all the objects in the basket, so that we may
				-- count them.
			add_eiffel_objects;
				-- Compute number of partial objects needed.
			partial_objects := object_basket.count // Packet_number;
			if (object_basket.count \\ Packet_number) /= 0 and
				partial_objects > 0
			then
				partial_objects := partial_objects + 1;
			end;
			if partial_objects = 1 then
				partial_objects := 0;
			end;
				-- Now genrate the objects lists
			generate_objects_lists;
				-- Generate external objects
			generate_externals;
				-- Generate executable
			generate_executable;
				-- End production
			generate_ending;
			Make_file.close;
			object_basket.wipe_out;
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
			if byte_context.workbench_mode then
				Make_file.putstring ("-DWORKBENCH ");
			end;
			Make_file.putstring ("-I$(RUN_TIME3)%N%
				%LDFLAGS = $ldflags%N%
				%LIBS = $libs%N%
				%MAKE = make%N%
				%MKDEP = $mkdep $(DPFLAGS) --%N%
				%MV = $mv%N%
				%RM = $rm -f%N%N");
			Make_file.putstring ("%
				%!GROK!THIS!%N%
				%$spitshell >>Makefile <<'!NO!SUBS!'%N");
		end;

	add_eiffel_objects is
			-- Insert objects file in basket
		local
			i, nb: INTEGER;
			a_class: CLASS_C;
			types: TYPE_LIST;
			cl_type: CLASS_TYPE;
			workbench_mode: BOOLEAN;
			object_name, file_name: STRING;
		do
			workbench_mode := byte_context.workbench_mode;
			from
				i := 1;
				nb := System.class_counter.value;
			until
				i > nb
			loop
				a_class := System.class_of_id (i);
				if a_class /= Void then
					from
						types := a_class.types;
						types.start
					until
						types.offright
					loop
						cl_type := types.item;
						object_name := cl_type.base_file_name;
						!!file_name.make (16);
						file_name.append (object_name);
						file_name.append (".o");
						object_basket.put (file_name);
						types.forth;
					end;
					if workbench_mode then
						object_name := a_class.base_file_name;
						!!file_name.make (16);
						file_name.append (object_name);
						file_name.append ("T");
						file_name.append_integer (i);
						file_name.append (".o");
						object_basket.put (file_name);
					end;
				end;
				i := i + 1;
			end;
		end;

	add_table_objects is
			-- Add table objects to the object list.
		local
			file_name: STRING;
			i, nb: INTEGER;
		do
			from
				i := 1;
				nb := Rout_generator.file_counter;
			until
				i > nb
			loop
				!!file_name.make (16);
				file_name.append ("Erout");
				file_name.append_integer (i);
				file_name.append (".o");
				object_basket.put(file_name);
				i := i + 1;
			end;

			from
				i := 1;
				nb := Attr_generator.file_counter;
			until
				i > nb
			loop
				!!file_name.make (16);
				file_name.append ("Eattr");
				file_name.append_integer (i);
				file_name.append (".o");
				object_basket.put(file_name);
				i := i + 1;
			end;
		end;

	add_final_mode_objects is
			-- Add final mode specific files to the object list
		do
			object_basket.put ("Eref.o");
			object_basket.put ("Esize.o");
		end;

	add_workbench_mode_objects is
			-- Add workbench mode specific files to the object list
		do
			object_basket.put ("Eoption.o");
			object_basket.put ("Epattern.o");
			object_basket.put ("Efrozen.o");
			object_basket.put ("Edispatch.o");
			object_basket.put ("Ehisto.o");
		end;

	add_common_objects is
			-- Add common objects file
		do
			object_basket.put ("Econform.o");
			object_basket.put ("Eplug.o");
			object_basket.put ("Eskelet.o");
			object_basket.put ("Evisib.o");
			object_basket.put ("Emain.o");
		end;

	generate_compilation_rule is
			-- Generates the .c -> .o compilation rule
		do
			if byte_context.final_mode then
				Make_file.putstring ("%
					%.SUFFIXES: .x%N%N%
					%.c.o:%N%
					%%T$(CC) $(CFLAGS) -c $<%N%N%
					%.x.c:%N%
					%%T$(RUN_TIME3)/x2c < $< > $@%N%N%
					%.x.o:%N%
					%%T$(RUN_TIME3)/x2c < $< > $*.c%N%
					%%T$(CC) $(CFLAGS) -c $*.c%N%
					%%T$(RM) $*.c%N%N");
			else
				Make_file.putstring ("%
					%.c.o:%N%
					%%T$(CC) $(CFLAGS) -c $<%N%N");
			end
		end;

	generate_objects_lists is
			-- Generate the OBJECTS macros in Makefile
		local
			i: INTEGER;
			macro_name: STRING;
		do
			if partial_objects = 0 then
				generate_macro ("OBJECTS");
			else
				from
					i := 1;
				until
					i > partial_objects
				loop
					!!macro_name.make (4);
					macro_name.append ("OBJ");
					macro_name.append_integer (i);
					generate_macro (macro_name);
					i := i + 1;
				end;
			end;
		end;
	
	generate_externals is
			-- Generate declration fo the external variable
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
			
	generate_macro (mname: STRING) is
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
				amount >= Packet_number or object_basket.empty
			loop
				file_name := object_basket.item;
				object_basket.remove;
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

	generate_ending is
			-- Ends Makefile wrapping scheme
		do
			Make_file.putstring ("%
				%!NO!SUBS!%N%
				%chmod 644 Makefile%N%
				%$eunicefix Makefile%N");
		end;

	generate_executable is
			-- Generate rules to produce executable
		local
			run_time: STRING;
		do
			Make_file.putstring ("all: ");
			Make_file.putstring (System.system_name);
			Make_file.new_line;
			Make_file.new_line;
			if byte_context.final_mode then
				run_time := "$(RUN_TIME3)/libruntime.a";
			else
				run_time := "$(RUN_TIME3)/libwkbench.a";
			end;
			if partial_objects = 0 then
				generate_simple_executable (run_time);
			else
				generate_partial_linking (run_time);
			end;
		end;
	
	generate_objects_macros is
			-- Generate the object macros (dependencies for final executable)
		local
			i: INTEGER;
		do
			if partial_objects = 0 then
				Make_file.putstring ("$(OBJECTS)");
			else
				from
					i := 1;
				until
					i > partial_objects
				loop
					if i > 1 then
						Make_file.putchar (' ');
					end;
					Make_file.putstring ("obj");
					Make_file.putint (i);
					Make_file.putstring (".o");
					i := i + 1;
				end;
			end;
		end;

	generate_simple_executable (run_time: STRING) is
			-- Generate rule to produce simple executable, linked in
			-- with `run_time' archive.
		do
			Make_file.putstring (System.system_name);
			Make_file.putstring (": ");
			generate_objects_macros;
			Make_file.new_line;
			Make_file.putstring ("%T$(CC) -o ");
			Make_file.putstring (System.system_name);
			Make_file.putstring ("%
				% $(CFLAGS) $(LDFLAGS) ");
			generate_objects_macros;
			Make_file.putchar (' ');
			Make_file.putchar ('\');
			Make_file.new_line;
			Make_file.putstring ("%T%T");
			if System.object_file_names /= Void then
				Make_file.putstring ("$(EXTERNALS) ");
			end;
			Make_file.putstring (run_time);
			Make_file.putstring (" $(LIBS)%N");
			if partial_objects > 0 then
				Make_file.putstring ("%T$(RM) ");
				generate_objects_macros;
				Make_file.new_line;
			end;
			Make_file.new_line;
		end;

	generate_partial_linking (run_time: STRING) is
			-- Generate rules to produce partial linking and the
			-- final executable linked in with `run_time'.
		local
			i: INTEGER;
		do
			from
				i := 1;
			until
				i > partial_objects
			loop
				Make_file.putstring ("obj");
				Make_file.putint (i);
				Make_file.putstring (".o: $(OBJ");
				Make_file.putint (i);
				Make_file.putchar (')');
				Make_file.new_line;
					-- The following is not portable (if people want to use
					-- their own linker).
				Make_file.putstring ("%Tld -r -o ");
				Make_file.putstring ("obj");
				Make_file.putint (i);
				Make_file.putstring (".o $(OBJ");
				Make_file.putint (i);
				Make_file.putchar (')');
				Make_file.new_line;
				Make_file.new_line;
				i := i +1 ;
			end;
			generate_simple_executable (run_time);
		end;

end
