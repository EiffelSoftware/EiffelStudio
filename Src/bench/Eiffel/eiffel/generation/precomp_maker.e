indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Makefile generator for precompiled C compilation

class PRECOMP_MAKER

inherit
	WBENCH_MAKER
		redefine
			system_name, add_eiffel_objects,
			generate_additional_rules
		end
		
create
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
				Make_file.put_string ("%Tld $(LDFLAGS) -r -o preobj.o ");
				generate_objects_macros;
				Make_file.put_new_line
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
						if (not cl_type.is_precompiled) then
								-- C code
							object_name := cl_type.base_file_name;
							create file_name.make (16);
							file_name.append (object_name);
							file_name.append (".o");
							object_baskets.item
								(cl_type.packet_number).extend (file_name);

								-- Descriptor file
							create file_name.make (16);
							file_name.append (object_name);
							file_name.append_character (Descriptor_file_suffix);
							file_name.append (".o");
							object_baskets.item (cl_type.packet_number).extend (file_name);
						end;
						types.forth
					end
				end
				i := i + 1
			end
		end;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
