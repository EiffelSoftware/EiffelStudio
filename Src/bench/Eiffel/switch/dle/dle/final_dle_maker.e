-- Makefile generator for final mode C compilation
-- of the Dynamic Class Set shared library ("libdle.so")

class FINAL_DLE_MAKER

inherit

	DLE_MAKER
		rename
			descriptor_baskets as static_baskets,
			Descriptor_suffix as Static_suffix
		undefine
			generate_additional_rules
		redefine
			init_objects_baskets, record_dle_class_type, make, clear
		end;

	FINAL_MAKER
		rename
			descriptor_baskets as static_baskets,
			Descriptor_suffix as Static_suffix
		undefine
			add_common_objects, system_name,
			generate_partial_system_objects_dependencies,
			generate_simple_executable, generate_system_makefile,
			generate_cecil, add_cecil_objects
		redefine
			init_objects_baskets, add_specific_objects,
			add_eiffel_objects, make, clear, record_dle_class_type
		end

creation

	make

feature -- Initialization

	make is
			-- Creation.
		do
			!! system_basket.make;
			!! cecil_rt_basket.make;
			!! empty_class_types.make;
			!! dle_class_types.make
		end;

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
			basket_nb := 1 + System.dle_max_dr_static_type_id // Packet_number;
			!!static_baskets.make (1, basket_nb);
			from i := 1 until i > basket_nb loop
				!!basket.make;
				static_baskets.put (basket, i);
				i := i + 1
			end;
			!!feat_table_baskets.make (1, 0)
		end;

	clear is
			-- Forget the lists.
		do
			object_baskets := Void;
			static_baskets := Void;
			feat_table_baskets := Void;
			system_basket := Void;
			cecil_rt_basket := Void;
			empty_class_types := Void;
			dle_class_types := Void
		end;

feature -- Add objects in baskets

	add_specific_objects is
			-- Add objects specific to final C code generation.
		local
			file_name: STRING;
			i, nb: INTEGER
		do
			add_in_system_basket (Eref);
			add_in_system_basket (Esize)

				-- Routine tables.
			from
				i := 1;
				nb := Rout_generator.file_counter
			until
				i > nb
			loop
				!!file_name.make (16);
				file_name.append (Erout);
				file_name.append_integer (i);
				add_in_system_basket(file_name);
				i := i + 1
			end;
 
				-- Attribute tables.
			from
				i := 1;
				nb := Attr_generator.file_counter
			until
				i > nb
			loop
				!!file_name.make (16);
				file_name.append (Eattr);
				file_name.append_integer (i);
				add_in_system_basket(file_name);
				i := i + 1
			end
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
						if cl_type.is_dynamic then
							if not empty_class_types.has (cl_type.id) then
									-- C code
								object_name := cl_type.base_file_name;
								!!file_name.make (16);
								file_name.append (object_name);
								file_name.append (".o");
								object_baskets.item
									(cl_type.packet_number).extend (file_name)
							end
						else
							if dle_class_types.has (cl_type.id) then
									-- C code of previously removed features
								object_name := cl_type.base_file_name;
								!!file_name.make (16);
								file_name.append (object_name);
								file_name.append (".o");
								static_baskets.item
									(cl_type.packet_number).extend (file_name)
							end
						end;
						types.forth
					end
				end;
				i := i + 1
			end
		end;

feature -- DLE

	record_dle_class_type (a_class_type: INTEGER) is
			-- Add `a_class_type' to the set of static class types that
			-- need to be regenerated (they are containing removed
			-- features which are used by the dynamic system).
		do
			dle_class_types.extend (a_class_type)
		end;

	dle_class_types: TWO_WAY_SORTED_SET [INTEGER];
			-- Set of all static class types that need to be regenerated
			-- (they are containing removed features which are used by
			-- the dynamic system)

end -- class FINAL_DLE_MAKER
