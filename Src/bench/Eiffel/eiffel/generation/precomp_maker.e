-- Makefile generator for precompiled C compilation

class PRECOMP_MAKER

inherit
	WBENCH_MAKER
		redefine
			system_name, add_eiffel_objects,
			generate_additional_rules
		end
		
creation
	make

feature

	system_name: STRING is
			-- Name of executable
		do
			Result := Platform_constants.Driver
		end;

	generate_additional_rules is
		do
			if
				not (object_baskets.count = 1 and then
				object_baskets.item (1).is_empty)
			then
					-- `object_baskets' may be empty when
					-- merging several precompilations.
				System.set_has_precompiled_preobj (True);
				Make_file.putstring ("%Tld -r -o preobj.o ");
				generate_objects_macros;
				Make_file.new_line
			else
				System.set_has_precompiled_preobj (False)
			end;
		end;

	add_eiffel_objects is
			-- Add Eiffel objects to the basket, i.e. C code for
			-- each class as well as descriptor tables.
		local
			a_class: CLASS_C;
			types: TYPE_LIST;
			cl_type: CLASS_TYPE;
			object_name, file_name: STRING;
			class_array: ARRAY [CLASS_C];
			i, nb: INTEGER;
		do
			from
				class_array := System.classes
				nb := Class_counter.count
				i := 1
			until
				i > nb
			loop
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
								object_baskets.item (cl_type.packet_number).extend (file_name);
							end;

						end;
						types.forth
					end
				end
				i := i + 1
			end
		end;

end
