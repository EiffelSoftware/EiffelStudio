-- Makefile generator for precompiled C compilation

class PRECOMP_MAKER

inherit

	WBENCH_MAKER
		redefine
			generate_compilation_rule, system_name,
			remove_after_partial, generate_additional_rules,
			init_objects_baskets, add_eiffel_objects
		end;
		
creation

	make

feature

	init_objects_baskets is
			-- Create objects baskets.
		local
			basket_nb, i: INTEGER;
			basket: LINKED_LIST [STRING]
		do
			basket_nb := 1 +
					System.static_type_id_counter.current_count // Packet_number;
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
			!!feat_table_baskets.make (1, 0)
		end;

	generate_compilation_rule is
			-- Generates the .c -> .o compilation rule
		do
			Make_file.putstring ("%
				%%N.SUFFIXES: .cpp%N%N%
				%.c.o:%N%
				%%T$(CC) $(CFLAGS) -c $<%N%
				%%T$(RM) $<%N%N%
				%.cpp.o:%N%
				%%T$(CPP) $(CPPFLAGS) -c $<%N%
				%%T$(RM) $<%N%N");
		end;

	system_name: STRING is
			-- Name of executable
		do
			Result := Driver
		end;

	remove_after_partial: BOOLEAN is True;

	generate_additional_rules is
		do
			if
				not (object_baskets.count = 1 and then
				object_baskets.item (1).empty)
			then
					-- `object_baskets' may be empty when
					-- merging several precompilations.
				System.set_has_precompiled_preobj (True);
				Make_file.putstring ("%Tld -r -o preobj.o ");
				generate_C_object_macros;
				Make_file.putchar (' ');
				generate_D_object_macros;
				Make_file.new_line
			else
				System.set_has_precompiled_preobj (False)
			end;
			Make_file.putstring ("%T$(RM) ");
			generate_objects_macros;
			Make_file.putchar (' ');
			generate_system_objects_macros;
			Make_file.new_line;
			Make_file.putstring ("%T$(RM) melted.eif Makefile Makefile.SH config.sh");
			Make_file.new_line;
			Make_file.putstring ("%T$(RM) -r $(SUBDIRS)");
			Make_file.new_line
		end;

	add_eiffel_objects is
			-- Add Eiffel objects to the basket, i.e. C code for
			-- each class as well as descriptor tables.
		local
			a_class: CLASS_C;
			types: TYPE_LIST;
			cl_type: CLASS_TYPE;
			object_name, file_name: STRING;
			classes: CLASS_C_SERVER;
			class_array: ARRAY [CLASS_C];
			i, nb: INTEGER;
		do
			classes := System.classes;
			from classes.start until classes.after loop
				class_array := classes.item_for_iteration;
				nb := Class_counter.item (classes.key_for_iteration).count
				from i := 1 until i > nb loop
					a_class := class_array.item (i)
					if a_class /= Void then
						from
							types := a_class.types;
							types.start
						until
							types.after
						loop
							cl_type := types.item;
							if
								types.has_type (cl_type.type)
								and then types.found_item = cl_type
							then
									--| Do not generate twice the same type if it
									--| has been derived in two different merged
									--| precompiled libraries.
		
								if (not cl_type.is_precompiled) then
										-- C code
									object_name := cl_type.base_file_name;
									!!file_name.make (16);
									file_name.append (object_name);
									file_name.append (".o");
									object_baskets.item
										(cl_type.packet_number).extend (file_name);

										-- Descriptor file
									!!file_name.make (16);
									file_name.append (object_name);
									file_name.append_character (Descriptor_file_suffix);
									file_name.append (".o");
									descriptor_baskets.item (cl_type.packet_number).extend (file_name);
								end;

							end;
							types.forth
						end
					end
					i := i + 1
				end
				classes.forth
			end;
		end;

end
