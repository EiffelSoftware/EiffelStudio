-- Makefile generator for C compilation of the Dynamic Class Set
-- shared library ("libdle.so")

deferred class DLE_MAKER 

inherit

	MAKEFILE_GENERATOR
		undefine
			generate_specific_defines
		redefine
			init_objects_baskets, add_common_objects,
			generate_partial_system_objects_dependencies,
			generate_simple_executable, generate_system_makefile,
			generate_cecil, system_name
		end

feature -- Initialization

	init_objects_baskets is
			-- Create objects baskets.
		local
			basket_nb, i: INTEGER;
			basket: LINKED_LIST [STRING]
		do
			basket_nb := 1 + (System.static_type_id_counter.value - 
				System.dle_max_dr_static_type_id) // Packet_number;
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
				System.dle_max_dr_class_id) // Packet_number;
			!!feat_table_baskets.make (1, basket_nb);
			from i := 1 until i > basket_nb loop
				!!basket.make;
				feat_table_baskets.put (basket, i);
				i := i + 1
			end
		end;

feature -- Add objects in baskets

	add_common_objects is
			-- Add common objects file.
		do
			add_in_system_basket (Econform);
			add_in_system_basket (Eskelet);
			add_in_system_basket (Evisib)
			add_in_system_basket (Edle)
			add_in_system_basket (Eplug)
			add_in_system_basket (Ececil)
		end;

	add_cecil_objects is
		do
		end;

feature -- Makefile generation

	generate_system_makefile is
			-- Create makefile to build system objects.
		local
			new_makefile, old_makefile: INDENT_FILE;
			baskets_count, i: INTEGER;
			f_name: FILE_NAME
			subdir_name: STRING
		do
			old_makefile := System.make_file;
			if system.in_final_mode then
				!!f_name.make_from_string (Final_generation_path)
			else
				!!f_name.make_from_string (Workbench_generation_path)
			end;
			subdir_name := clone (System_object_prefix);
			subdir_name.append_integer (1);
			f_name.extend (subdir_name);
			f_name.set_file_name (Makefile_SH);
			!!new_makefile.make (f_name);
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
			Make_file.putstring ("all:");
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
				-- Generate cleaning rules
			generate_sub_cleaning;
				-- End production.
			generate_ending;
			Make_file.close;
			System.set_make_file (old_makefile)
		end;

	generate_simple_executable is
			-- Generate rule to produce simple executable, linked in
			-- with `run_time' archive.
		do
			Make_file.putstring (system_name);
			Make_file.putstring (": ");
			generate_objects_macros;
			Make_file.putchar (' ');
			generate_system_objects_macros;
			Make_file.putstring (" Makefile%N%T$(RM) ");
			Make_file.putstring (system_name);
			Make_file.new_line;
			if System.makefile_names /= Void then
				generate_makefile_names;
			end;
				-- Generate a shared library (".so").
			Make_file.putstring ("%T$(CC) -G -o ");
			Make_file.putstring (system_name);
			Make_file.putstring ("%
				% $(CFLAGS) $(LDFLAGS) ");
			generate_objects_macros;
			Make_file.putchar (' ');
			generate_system_objects_macros;
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
			Make_file.new_line
		end;

	generate_partial_system_objects_dependencies is
			-- Depencies to update partial system objects in subdirectories.
		local
			i: INTEGER
		do
			from i := 1 until i > partial_system_objects loop
				Make_file.putstring (System_object_prefix);
				Make_file.putint (1);
				Make_file.putchar ('/');
				Make_file.putstring (System_object_prefix);
				Make_file.putstring ("obj");
				Make_file.putint (i);
				Make_file.putstring (".o: Makefile%N%Tcd ");
				Make_file.putstring (System_object_prefix);
				Make_file.putint (1);
				Make_file.putstring (" ; $(SHELL) Makefile.SH ; $(MAKE) ")
				Make_file.putstring (System_object_prefix);
				Make_file.putstring ("obj");
				Make_file.putint (i);
				Make_file.putstring (".o%N%N");
				i := i + 1
			end
		end;

	generate_cecil is
		do
		end;

feature -- Access

	system_name: STRING is
			-- Name of the shared library
		do
			Result := "libdle.so"
		end;

invariant

	dynamic_system: System.is_dynamic

end -- class DLE_MAKER
