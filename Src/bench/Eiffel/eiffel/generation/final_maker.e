-- Makefile generator for final mode C compilation

class FINAL_MAKER

inherit

	MAKEFILE_GENERATOR

creation

	make

feature

	generate_compilation_rule is
			-- Generates the .c -> .o compilation rule
		do
			Make_file.putstring ("%
				%.SUFFIXES: .x%N%N%
				%.c.o:%N%
				%%T$(CC) $(CFLAGS) -c $<%N%N%
				%.x.c:%N%
				%%T$(EIFFEL3)/bench/spec/$(PLATFORM)/bin/x2c < $< > $@%N%N%
				%.x.o:%N%
				%%T$(EIFFEL3)/bench/spec/$(PLATFORM)/bin/x2c < $< > $*.c%N%
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
			cecil_rt_basket.put ("math.o");
			cecil_rt_basket.put ("malloc.o");
			cecil_rt_basket.put ("garcol.o");
			cecil_rt_basket.put ("local.o");
			cecil_rt_basket.put ("except.o");
			cecil_rt_basket.put ("store.o");
			cecil_rt_basket.put ("retrieve.o");
			cecil_rt_basket.put ("hash.o");
			cecil_rt_basket.put ("traverse.o");
			cecil_rt_basket.put ("hashin.o");
			cecil_rt_basket.put ("tools.o");
			cecil_rt_basket.put ("internal.o");
			cecil_rt_basket.put ("plug.o");
			cecil_rt_basket.put ("copy.o");
			cecil_rt_basket.put ("equal.o");
			cecil_rt_basket.put ("lmalloc.o");
			cecil_rt_basket.put ("out.o");
			cecil_rt_basket.put ("timer.o");
			cecil_rt_basket.put ("urgent.o");
			cecil_rt_basket.put ("sig.o");
			cecil_rt_basket.put ("hector.o");
			cecil_rt_basket.put ("cecil.o");
			cecil_rt_basket.put ("bits.o");
			cecil_rt_basket.put ("file.o");
			cecil_rt_basket.put ("dir.o");
			cecil_rt_basket.put ("string.o");
			cecil_rt_basket.put ("misc.o");
			cecil_rt_basket.put ("pattern.o");
			cecil_rt_basket.put ("error.o");
			cecil_rt_basket.put ("umain.o");
			cecil_rt_basket.put ("memory.o");
			cecil_rt_basket.put ("argv.o");
			cecil_rt_basket.put ("boolstr.o");
			cecil_rt_basket.put ("search.o");
			cecil_rt_basket.put ("main.o");
		end;

	add_eiffel_objects is
			-- Add class C code objects.
		local
			i, nb: INTEGER;
			a_class: CLASS_C;
			types: TYPE_LIST;
			cl_type: CLASS_TYPE;
			object_name, file_name: STRING;
		do
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
						types.after
					loop
						cl_type := types.item;

						if
							not empty_class_types.has (cl_type.id)
						then
								-- C code
							object_name := cl_type.base_file_name;
							!!file_name.make (16);
							file_name.append (object_name);
							file_name.append (Dot_o);
							object_basket.put (file_name);
						end;

						types.forth;
					end;
				end;
				i := i + 1;
			end;
		end;

	run_time: STRING is
			-- Run time with which the application must be linked
		do
			Result := "$(EIFFEL3)/bench/spec/$(PLATFORM)/lib/libruntime.a"
		end;


end
