indexing
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

feature

	make (ct: CLASS_TYPE; s: INTEGER) is
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

	set_invariant_entry (e: ENTRY) is
		do
			invariant_entry ?= e
		end;

	invariant_entry: ROUT_ENTRY;

feature -- Generation

	generate is
			-- Generate descriptor table and initialization
			-- function of current class type.
		local
			descriptor_file: INDENT_FILE
			buffer: GENERATION_BUFFER
			class_id_string: STRING
			is_precompiling: BOOLEAN
		do
				-- Retrieve the buffer and clear it
			buffer := generation_buffer
			buffer.clear_all

			class_id_string := class_type.static_type_id.out
			class_id_string.prepend ("_")

			is_precompiling := Compilation_modes.is_precompiling
			buffer.put_string ("/*%N * Class ")
			class_type.type.dump (buffer)
			buffer.put_string ("%N */%N%N")
			buffer.put_string ("#include %"eif_macros.h%"%N");
			if is_precompiling then
				buffer.put_string ("#include %"eif_wbench.h%"")
			end
			buffer.start_c_specific_code
			if is_precompiling then
				buffer.put_new_line
				buffer.generate_static_declaration ("void", "build_desc" + class_id_string, <<>>);
				buffer.put_new_line
				descriptor_generate_generic (buffer, class_id_string)
				buffer.put_new_line
				descriptor_generate_precomp (buffer, class_id_string)
			else
				buffer.put_new_line
				descriptor_generate_generic (buffer, class_id_string)
				buffer.put_new_line
				descriptor_generate (buffer, class_id_string)
			end;

			generate_init_function (buffer, class_id_string)
			buffer.end_c_specific_code

			descriptor_file := class_type.open_descriptor_file
			buffer.put_in_file (descriptor_file)
			descriptor_file.close
		end;

	descriptor_generate (buffer: GENERATION_BUFFER; id_string: STRING) is
			-- C code of corresponding to run-time
			-- structure of Current descriptor
		require
			buffer_not_void: buffer /= Void
		local
			cnt : COUNTER
		do
			buffer.put_string ("static struct desc_info desc")
			buffer.put_string (id_string)
			buffer.put_string ("[] = {%N");

			buffer.put_string ("%T{(BODY_INDEX) ")
			if invariant_entry = Void then
				buffer.put_integer (Invalid_index)
			else
				buffer.put_real_body_index (invariant_entry.real_body_index)
			end
			buffer.put_string (", (BODY_INDEX) ")
			buffer.put_integer (Invalid_index)
			buffer.put_string (", INVALID_DTYPE, NULL},")

			from
				create cnt
				start
			until
				after
			loop
				item_for_iteration.generate (buffer, cnt, id_string)
				forth
			end

			buffer.put_string ("%N};%N")
		end;

	descriptor_generate_generic (buffer : GENERATION_BUFFER; id_string: STRING) is
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

	descriptor_generate_precomp (buffer: GENERATION_BUFFER; id_string: STRING) is
			-- C code of corresponding to run-time
			-- structure of Current precompiled descriptor
		require
			buffer_not_void: buffer /= Void
		local
			i: INTEGER
			cnt: COUNTER
			entry_name: STRING
		do
			entry_name := "desc" + id_string
			buffer.put_string ("static struct desc_info ")
			buffer.put_string (entry_name);
			buffer.put_string ("[")
			buffer.put_integer (table_size)
			buffer.put_string ("];%N%Nstatic void build_")
			buffer.put_string (entry_name)
			buffer.put_string ("(void) {%N%T")

			buffer.put_string (entry_name)
			buffer.put_string ("[0].body_index = (BODY_INDEX) (")
			if invariant_entry = Void then
				buffer.put_integer (Invalid_index)
			else
				buffer.put_real_body_index (invariant_entry.real_body_index)
			end
			buffer.put_string (");%N%T")
			buffer.put_string (entry_name)
			buffer.put_string ("[0].offset = (BODY_INDEX) (")
			buffer.put_integer (Invalid_index)
			buffer.put_string (");%N%T")
			buffer.put_string (entry_name)
			buffer.put_string ("[0].type = INVALID_DTYPE;%N%T")
			buffer.put_string (entry_name)
			buffer.put_string ("[0].gen_type = NULL;%N")

			from
				create cnt
				start
				i := 1
			until
				after
			loop
				item_for_iteration.generate_precomp (buffer,i,cnt, id_string)
				i := i + item_for_iteration.count
				forth
			end;
			buffer.put_string ("}%N");
		end;

	generate_init_function (buffer: GENERATION_BUFFER; id_string: STRING) is
			-- C code of initialization function of Current
			-- descriptor
		local
			i: INTEGER
			class_type_id: INTEGER
			init_name: STRING
			desc, rtud, init_macro, sep, plus: STRING
		do
			class_type_id := class_type.static_type_id;
			init_name := Encoder.init_name (class_type_id)
			init_macro := "%TIDSC("
			rtud := ", RTUD("
			rtud.append (Encoder.generate_type_id_name (class_type_id))
			rtud.append ("));%N")

			buffer.generate_extern_declaration ("void", init_name, <<>>);
			buffer.put_new_line
			buffer.put_string ("void ");
			buffer.put_string (init_name);
			buffer.put_string ("(void)%N{%N");
			if Compilation_modes.is_precompiling then
				buffer.put_string ("%Tif (desc_fill != 0)%N%T%Tbuild_desc")
				buffer.put_string (id_string)
				buffer.put_string ("();%N")
			end;

			desc := "desc" + id_string;

				-- Special descriptor unit (invariant)
			buffer.put_string (init_macro);
			buffer.put_string (desc)
			buffer.put_string (", 0")
			buffer.put_string (rtud)

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
				buffer.put_string (rtud);
				i := i + item_for_iteration.count;
				forth
			end;
			buffer.put_string ("}%N")
		end;

	table_size: INTEGER is
			-- Number of entries in the descriptor table
		do
			Result := 1;
			from start until after loop
				Result := Result + item_for_iteration.count;
				forth
			end
		end

feature -- Melting

	make_byte_code (ba: BYTE_ARRAY) is
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
				-- body index
			if (invariant_entry = Void) then
				ba.append_uint32_integer (-1)
			else
				ba.append_uint32_integer (invariant_entry.real_body_index - 1)
			end
				-- Offset.
			ba.append_uint32_integer (-1)

			-- No type
			ba.append_short_integer (-1);
			-- No generics
			ba.append_short_integer (-1);

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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
