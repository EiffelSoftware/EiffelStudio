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
				%%T$(RUN_TIME3)/x2c < $< > $@%N%N%
				%.x.o:%N%
				%%T$(RUN_TIME3)/x2c < $< > $*.c%N%
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
            system_basket.put ("Eref.o");
            system_basket.put ("Esize.o");

				-- Routine tables.
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
				system_basket.put(file_name);
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
				file_name.append ("Eattr");
				file_name.append_integer (i);
				file_name.append (".o");
				system_basket.put(file_name);
				i := i + 1;
			end;
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
							file_name.append (".o");
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
			Result := "$(RUN_TIME3)/libruntime.a"
		end;


end
