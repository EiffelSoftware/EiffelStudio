note
	description: "General notion of class descriptor indexed by class id.%
				%A descriptor is associated with one class type,%
				%is keyed by the class id's of the origin parent%
				%classes (parent classes which introduce actual routines)."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class DESCRIPTOR

inherit
	HASH_TABLE [DESC_UNIT, INTEGER]
		rename
			put as table_put,
			item as table_item,
			make as table_make
		end;
	SHARED_COUNTER
		undefine
			copy, is_equal
		end;
	COMPILER_EXPORTER
		undefine
			copy, is_equal
		end
	SHARED_GENERATION
		undefine
			copy, is_equal
		end

create
	make

create {DESCRIPTOR}
	table_make

feature

	make (ct: CLASS_TYPE; s: INTEGER)
			-- Create a descriptor of size `s'.
		do
			class_type := ct;
			table_make (s)
		end

feature

	class_type: CLASS_TYPE;
			-- Class type (instantiated) associated with
			-- Current descriptor

feature

	set_invariant_entry (e: ENTRY)
		do
			invariant_entry ?= e
		end;

	invariant_entry: ROUT_ENTRY;

feature -- Generation

	generate
			-- Generate descriptor table and initialization
			-- function of current class type.
		local
			descriptor_file: INDENT_FILE
			buffer: GENERATION_BUFFER
			class_id_string: STRING
		do
				-- Retrieve the buffer and clear it
			buffer := generation_buffer
			buffer.clear_all

			class_id_string := class_type.static_type_id.out
			class_id_string.prepend_character ('_')

			buffer.put_string ("/*%N * Class ")
			buffer.put_string (class_type.type.dump)
			buffer.put_string ("%N */%N%N")
			buffer.put_string ("#include %"eif_macros.h%"%N");
			buffer.start_c_specific_code
			buffer.put_new_line
			descriptor_generate_generic (buffer, class_id_string)
			buffer.put_new_line
			descriptor_generate (buffer, class_id_string)

			generate_init_function (buffer, class_id_string)
			buffer.end_c_specific_code

			descriptor_file := class_type.open_descriptor_file
			buffer.put_in_file (descriptor_file)
			descriptor_file.close
		end;

	descriptor_generate (buffer: GENERATION_BUFFER; id_string: STRING)
			-- C code of corresponding to run-time
			-- structure of Current descriptor
		require
			buffer_not_void: buffer /= Void
		local
			cnt : COUNTER
		do
			buffer.put_string (once "static const struct desc_info desc")
			buffer.put_string (id_string)
			buffer.put_string (once "[] = {%N");

			buffer.put_string (once "%T{EIF_GENERIC(NULL), ")
			if invariant_entry = Void then
					-- No body.
				buffer.put_hex_integer_32 (-1)
			else
				buffer.put_real_body_index (invariant_entry.real_body_index)
			end
			buffer.put_two_character (',', ' ')
				-- No offset
			buffer.put_hex_integer_32 (-1)
			buffer.put_two_character ('}', ',')

			from
				create cnt
				start
			until
				after
			loop
				item_for_iteration.generate (buffer, cnt, id_string)
				forth
			end

			buffer.put_string (once "%N};%N")
		end;

	descriptor_generate_generic (buffer : GENERATION_BUFFER; id_string: STRING)
			-- C code for generic type arrays.
		require
			buffer_not_void: buffer /= Void
		local
			cnt : COUNTER
		do
			from
				create cnt
				start
			until
				after
			loop
				item_for_iteration.generate_generic (buffer, cnt, id_string);
				forth
			end;
			buffer.put_string ("%N")
		end;

	generate_init_function (buffer: GENERATION_BUFFER; id_string: STRING)
			-- C code of initialization function of Current
			-- descriptor
		local
			i: INTEGER
			class_type_id: INTEGER
			init_name: STRING
			desc, type_id_name, init_macro, sep, plus: STRING
		do
			class_type_id := class_type.static_type_id;
			init_name := Encoder.init_name (class_type_id)
			init_macro := "%TIDSC("
			create type_id_name.make (12)
			type_id_name.append (Encoder.generate_type_id_name (class_type_id))
			type_id_name.append (");%N")

			buffer.put_string ("void ");
			buffer.put_string (init_name);
			buffer.put_string ("(void)%N{%N");

			desc := "desc" + id_string;

				-- Special descriptor unit (invariant)
			buffer.put_string (init_macro);
			buffer.put_string (desc)
			buffer.put_string (", 0, ")
			buffer.put_string (type_id_name)

				-- Descriptor units for origin classes
			from
				sep := ", "
				plus := " + "
				start
				i := 1
			until
				after
			loop
				buffer.put_string (init_macro);
				buffer.put_string (desc);
				buffer.put_string (plus);
				buffer.put_integer (i);
				buffer.put_string (sep);
				buffer.put_class_id (key_for_iteration);
				buffer.put_string (sep);
				buffer.put_string (type_id_name);
				i := i + item_for_iteration.count;
				forth
			end;
			buffer.put_string ("}%N")
		end;

	table_size: INTEGER
			-- Number of entries in the descriptor table
		do
			Result := 1;
			from start until after loop
				Result := Result + item_for_iteration.count;
				forth
			end
		end

feature -- Melting

	make_byte_code (ba: BYTE_ARRAY)
			-- Append byte code of Current descriptor
			-- Format:
			--    1) Id of class type (short)
			--    2) Number of descriptor units (short)
			--    3) Sequence of descriptor units
		do
				-- Write the id of the class type
			ba.append_short_integer (class_type.static_type_id);
				-- Write the number of descriptor units
				-- +1, for the special routines (invariant...)
			ba.append_short_integer (count + 1);

				-- Byte code for invariant entry
				-- Origin class.
			ba.append_short_integer (0);
				-- Number of elements.
			ba.append_short_integer (1);
				-- No type
			ba.append_boolean (True)
			ba.append_short_integer (-1);
				-- body index
			if (invariant_entry = Void) then
					-- No body
				ba.append_uint32_integer (-1)
			else
				ba.append_uint32_integer (invariant_entry.real_body_index - 1)
			end
				-- No offset.
			ba.append_uint32_integer (-1)

				-- Append the individual descriptor units
			from
				start
			until
				after
			loop
				item_for_iteration.make_byte_code (ba);
				forth
			end;
		end;

note
	copyright:	"Copyright (c) 1984-2015, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
