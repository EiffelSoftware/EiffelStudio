-- Makefile generator for final mode C compilation

class FINAL_MAKER

inherit

	MAKEFILE_GENERATOR
		redefine
			init_objects_baskets, generate_additional_rules
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
					System.static_type_id_counter.total_count // Packet_number;
			!!object_baskets.make (1, basket_nb);
			from i := 1 until i > basket_nb loop
				!!basket.make;
				object_baskets.put (basket, i);
				i := i + 1
			end;
			!!descriptor_baskets.make (1, 0);
			!!feat_table_baskets.make (1, 0)
		end;

	generate_compilation_rule is
			-- Generates the .c -> .o compilation rule
		do
			Make_file.putstring ("%
				%.SUFFIXES: .x%N%N%
				%.c.o:%N%
				%%T$(CC) $(CFLAGS) -c $<%N%N%
				%.x.o:%N%
				%%T$(EIFFEL4)/bench/spec/$(PLATFORM)/bin/x2c $< $*.c%N%
				%%T$(CC) $(CFLAGS) -c $*.c%N%
				%%T$(RM) $*.c%N%N");
		end;

	add_specific_objects is
			-- Add objects specific to final C code 
			-- generation
		local
			file_name: STRING;
			i, nb: INTEGER;
		do
			add_in_system_basket (Eref);
			add_in_system_basket (Esize);

				-- Routine tables.
			from
				i := 1;
				nb := Rout_generator.file_counter;
			until
				i > nb
			loop
				!!file_name.make (16);
				file_name.append (Erout);
				file_name.append_integer (i);
				add_in_system_basket(file_name);
				i := i + 1;
			end;
 
				-- Attribute tables.
			from
				i := 1;
				nb := Attr_generator.file_counter;
			until
				i > nb
			loop
				!!file_name.make (16);
				file_name.append (Eattr);
				file_name.append_integer (i);
				add_in_system_basket(file_name);
				i := i + 1;
			end;
		end;

	add_cecil_objects is
		do
			cecil_rt_basket.extend ("math.o");
			cecil_rt_basket.extend ("malloc.o");
			cecil_rt_basket.extend ("garcol.o");
			cecil_rt_basket.extend ("local.o");
			cecil_rt_basket.extend ("except.o");
			cecil_rt_basket.extend ("store.o");
			cecil_rt_basket.extend ("retrieve.o");
			cecil_rt_basket.extend ("hash.o");
			cecil_rt_basket.extend ("traverse.o");
			cecil_rt_basket.extend ("hashin.o");
			cecil_rt_basket.extend ("tools.o");
			cecil_rt_basket.extend ("internal.o");
			cecil_rt_basket.extend ("plug.o");
			cecil_rt_basket.extend ("copy.o");
			cecil_rt_basket.extend ("equal.o");
			cecil_rt_basket.extend ("lmalloc.o");
			cecil_rt_basket.extend ("out.o");
			cecil_rt_basket.extend ("timer.o");
			cecil_rt_basket.extend ("urgent.o");
			cecil_rt_basket.extend ("sig.o");
			cecil_rt_basket.extend ("hector.o");
			cecil_rt_basket.extend ("cecil.o");
			cecil_rt_basket.extend ("bits.o");
			cecil_rt_basket.extend ("file.o");
			cecil_rt_basket.extend ("dir.o");
			cecil_rt_basket.extend ("string.o");
			cecil_rt_basket.extend ("misc.o");
			cecil_rt_basket.extend ("pattern.o");
			cecil_rt_basket.extend ("error.o");
			cecil_rt_basket.extend ("umain.o");
			cecil_rt_basket.extend ("memory.o");
			cecil_rt_basket.extend ("argv.o");
			cecil_rt_basket.extend ("boolstr.o");
			cecil_rt_basket.extend ("search.o");
			cecil_rt_basket.extend ("main.o");
			cecil_rt_basket.extend ("run_idr.o");
			cecil_rt_basket.extend ("console.o");
			cecil_rt_basket.extend ("path_name.o");
			cecil_rt_basket.extend ("object_id.o");
			cecil_rt_basket.extend ("dle.o");
			cecil_rt_basket.extend ("option.o");
		end;

	add_eiffel_objects is
			-- Add class C code objects.
		local
			a_class: CLASS_C;
			types: TYPE_LIST;
			cl_type: CLASS_TYPE;
			object_name, file_name: STRING;
			classes: CLASS_C_SERVER;
			class_array: ARRAY [CLASS_C];
			i, nb: INTEGER;
			old_cursor: CURSOR
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
							old_cursor := types.cursor;
							types.search (cl_type.type);
							if types.item = cl_type then
								-- Do not generate twice the same type if it
								-- has been derived in two different merged
								-- precompiled libraries.

		
								if
									not empty_class_types.has (cl_type.id)
								then
										-- C code
									object_name := cl_type.base_file_name;
									!!file_name.make (16);
									file_name.append (object_name);
									file_name.append (".o");
									object_baskets.item (cl_type.packet_number).extend (file_name);
								end;

							end;

							types.go_to (old_cursor);
							types.forth;
						end;
					end
					i := i + 1
				end
				classes.forth
			end;
		end;

	run_time: STRING is
			-- Run time with which the application must be linked
		do
			if System.has_separate then
				Result := "%
					%$(EIFFEL4)/bench/spec/$(PLATFORM)/lib/libcruntime.a %
					%$(EIFFEL4)/library/net/spec/$(PLATFORM)/lib/libnet.a"
			else
				Result := "$(EIFFEL4)/bench/spec/$(PLATFORM)/lib/libruntime.a"
			end
		end;

	generate_additional_rules is
		do
			Make_file.putstring ("%T$(RM) ");
			generate_objects_macros;
			Make_file.putchar (' ');
			generate_system_objects_macros;
			Make_file.new_line;
		end;

end
