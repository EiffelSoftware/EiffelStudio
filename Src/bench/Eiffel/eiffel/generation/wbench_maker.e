-- Makefile generator for workbench mode C compilation

class WBENCH_MAKER

inherit

	MAKEFILE_GENERATOR
		redefine
			generate_specific_defines, generate_other_objects
		end;

creation

	make

feature

	generate_compilation_rule is
			-- Generates the .c -> .o compilation rule
		do
			Make_file.putstring ("%
				%.c.o:%N%
				%%T$(CC) $(CFLAGS) -c $<%N%N");
		end;

	generate_specific_defines is
			-- Generate specific "-D" flags.
			-- In this case "-DWORKBENCH"
		do
			Make_file.putstring ("-DWORKBENCH ");
		end;

	add_specific_objects is
			-- Add workbench mode specific files to the object list
		do
			system_basket.put ("Eoption.o");
			system_basket.put ("Epattern.o");
			system_basket.put ("Efrozen.o");
			system_basket.put ("Edispatch.o");
			system_basket.put ("Ecall.o");
		end;

	add_eiffel_objects is
			-- Add Eiffel objects to the basket, i.e. C code for
			-- each class as well as feature tables and descriptor
			-- tables.
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
						types.offright
					loop
						cl_type := types.item;

						if (not cl_type.is_precompiled) then
								-- C code
							object_name := cl_type.base_file_name;
							!!file_name.make (16);
							file_name.append (object_name);
							file_name.append (".o");
							object_basket.put (file_name);

								-- Descriptor file
							!!file_name.make (16);
							file_name.append (object_name);
							file_name.append ("D.o");
							object_basket.put (file_name);
						end;

						types.forth;
					end;

					if (not a_class.is_precompiled) then
							-- Feature table
						object_name := a_class.base_file_name;
						!!file_name.make (16);
						file_name.append (object_name);
						file_name.append_integer (i);
						file_name.append ("F.o");
						object_basket.put (file_name);
					end;
				end;
				i := i + 1;
			end;
		end;

	run_time: STRING is
			-- Run time with which the application must be linked
		do
			Result := "$(RUN_TIME3)/libwkbench.a"
		end;

	generate_other_objects is
		do
			if System.uses_precompiled then
				Make_file.putstring ("%T%T");
				Make_file.putstring (Precompilation_directory.name);
				Make_file.putstring ("/C_code/preobj.o \");
				Make_file.new_line;
			end;
		end;
 
end
