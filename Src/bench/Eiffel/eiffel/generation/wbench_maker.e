-- Makefile generator for workbench mode C compilation

class WBENCH_MAKER

inherit

	MAKEFILE_GENERATOR
		redefine
			generate_specific_defines, generate_other_objects,
			generate_additional_rules
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
			add_in_system_basket (Eoption);
			add_in_system_basket (Epattern);
			add_in_system_basket (Efrozen);
			add_in_system_basket (Edispatch);
			add_in_system_basket (Ecall);
		end;

	add_cecil_objects is
		do
			cecil_rt_basket.put ("network.o");
			cecil_rt_basket.put ("wmath.o");
			cecil_rt_basket.put ("wmalloc.o");
			cecil_rt_basket.put ("wgarcol.o");
			cecil_rt_basket.put ("wlocal.o");
			cecil_rt_basket.put ("wexcept.o");
			cecil_rt_basket.put ("wstore.o");
			cecil_rt_basket.put ("wretrieve.o");
			cecil_rt_basket.put ("whash.o");
			cecil_rt_basket.put ("wtraverse.o");
			cecil_rt_basket.put ("whashin.o");
			cecil_rt_basket.put ("wtools.o");
			cecil_rt_basket.put ("winternal.o");
			cecil_rt_basket.put ("wplug.o");
			cecil_rt_basket.put ("wcopy.o");
			cecil_rt_basket.put ("wequal.o");
			cecil_rt_basket.put ("wlmalloc.o");
			cecil_rt_basket.put ("wout.o");
			cecil_rt_basket.put ("wtimer.o");
			cecil_rt_basket.put ("wurgent.o");
			cecil_rt_basket.put ("wsig.o");
			cecil_rt_basket.put ("whector.o");
			cecil_rt_basket.put ("wcecil.o");
			cecil_rt_basket.put ("wbits.o");
			cecil_rt_basket.put ("wfile.o");
			cecil_rt_basket.put ("wdir.o");
			cecil_rt_basket.put ("wstring.o");
			cecil_rt_basket.put ("wmisc.o");
			cecil_rt_basket.put ("wpattern.o");
			cecil_rt_basket.put ("werror.o");
			cecil_rt_basket.put ("wumain.o");
			cecil_rt_basket.put ("wmemory.o");
			cecil_rt_basket.put ("wargv.o");
			cecil_rt_basket.put ("wboolstr.o");
			cecil_rt_basket.put ("wsearch.o");
			cecil_rt_basket.put ("wmain.o");
			cecil_rt_basket.put ("debug.o");
			cecil_rt_basket.put ("interp.o");
			cecil_rt_basket.put ("option.o");
			cecil_rt_basket.put ("update.o");
			cecil_rt_basket.put ("wbench.o");
			cecil_rt_basket.put ("wrun_idr.o");
			cecil_rt_basket.put ("console.o");
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
			object_name, file_name: STRING
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

						if (not cl_type.is_precompiled) then
								-- C code
							object_name := cl_type.base_file_name;
							!!file_name.make (16);
							file_name.append (object_name);
							file_name.append (Dot_o);
							object_baskets.item (cl_type.packet_number).put (file_name);

								-- Descriptor file
							!!file_name.make (16);
							file_name.append (object_name);
							file_name.append_character (Descriptor_file_suffix);
							file_name.append (Dot_o);
							descriptor_baskets.item (cl_type.packet_number).put (file_name);
						end;

						types.forth;
					end;

					if (not a_class.is_precompiled) then
							-- Feature table
						object_name := a_class.base_file_name;
						!!file_name.make (16);
						file_name.append (object_name);
						file_name.append_integer (i);
						file_name.append_character (Feature_table_file_suffix);
						file_name.append (Dot_o);
						feat_table_baskets.item (a_class.packet_number).put (file_name);
					end;
				end;
				i := i + 1;
			end;
		end;

	run_time: STRING is
			-- Run time with which the application must be linked
		do
			Result := "$(EIFFEL3)/bench/spec/$(PLATFORM)/lib/libwkbench.a"
		end;

	generate_other_objects is
		do
			if System.uses_precompiled then
				Make_file.putstring ("%T%T");
				Make_file.putstring (Precompilation_preobj);
				Make_file.putchar (' ');
				Make_file.putchar (Continuation);
				Make_file.new_line;
			end;
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
