-- Makefile generator for workbench mode C compilation
-- of the Dynamic Class Set shared library ("libdle.so")

class WBENCH_DLE_MAKER

inherit

	DLE_MAKER
		undefine
			generate_other_objects, generate_additional_rules
		end;

	WBENCH_MAKER
		undefine
			init_objects_baskets, add_common_objects,
			generate_partial_system_objects_dependencies,
			generate_simple_executable, generate_system_makefile,
			generate_cecil, add_cecil_objects, system_name
		redefine
			add_specific_objects, add_eiffel_objects, run_time
		end

creation

	make

feature -- Add objects in baskets

	add_specific_objects is
			-- Add workbench mode specific files to the object list
		do
			add_in_system_basket (Eoption);
			add_in_system_basket (Epattern);
			add_in_system_basket (Efrozen);
			add_in_system_basket (Edispatch);
			add_in_system_basket (Ecall);
			add_in_system_basket (Einit)
		end;

	add_eiffel_objects is
			-- Add class C code objects.
		local
			i, nb: INTEGER;
			a_class: CLASS_C;
			types: TYPE_LIST;
			cl_type: CLASS_TYPE;
			object_name, file_name: STRING
		do
			from
				i := 1;
				nb := System.class_counter.value
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
						if cl_type.is_dynamic then

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
							descriptor_baskets.item
								(cl_type.packet_number).extend (file_name)
						end;
						types.forth
					end;
					if a_class.is_dynamic then
							-- Feature table
						object_name := a_class.base_file_name;
						!!file_name.make (16);
						file_name.append (object_name);
						file_name.append_integer (i);
						file_name.append_character (Feature_table_file_suffix);
						file_name.append (".o");
						feat_table_baskets.item
							(a_class.packet_number).extend (file_name);
					end
				end;
				i := i + 1
			end
		end;

feature -- Access

	 run_time: STRING is
			-- No run-time needs to be linked
		do
			Result := ""
		end;

end -- class WBENCH_DLE_MAKER
