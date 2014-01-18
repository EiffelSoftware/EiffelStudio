note
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Parent table to generate

class PARENT_TABLE

inherit
	HASH_TABLE [BOOLEAN, CL_TYPE_A]
		rename
			make as table_make
		redefine
			same_keys
		end

	REFACTORING_HELPER
		undefine
			copy,
			is_equal
		end

create
	make

create {PARENT_TABLE}
	table_make

feature

	type_id: INTEGER;
			-- Static type to which the table belongs

	generic_count : INTEGER;
			-- Number of formal generic parameters

	is_expanded : BOOLEAN;
			-- Is type expanded?

	make
		do
			table_make (Init_size)
		end

	init (tid, gcount : INTEGER; is_exp : BOOLEAN)
			-- Initialization for id `tid' with `gcount' generics;
			-- Classname is `cname', `is_exp' is expandedness status.
		require
			positive_id: tid >= 0;
			meaningful_count: gcount >= 0
		do
			type_id := tid;
			generic_count := gcount
			is_expanded := is_exp
			wipe_out
		ensure
			type_id_set: type_id = tid
			generic_count_set: generic_count = gcount
			expandedness_set: is_expanded = is_exp
		end;

	append_type (ptype : CL_TYPE_A)
			-- Append type `ptype' to list of parent types.
		require
			valid_type: ptype /= Void
		do
				-- We use the parent type without any annotations since inheritance
				-- is not bound to the annotations.
			put (True, ptype.as_attachment_mark_free)
		end;

	generate (buffer: GENERATION_BUFFER; final_mode : BOOLEAN; a_class_type: CLASS_TYPE)
			-- Generates the current parent table
		require
			valid_file: buffer /= Void
			a_class_type_not_void: a_class_type /= Void
		local
			j, n: INTEGER;
			l_type_id: INTEGER
		do
			l_type_id := type_id
			buffer.put_new_line
			buffer.put_three_character ('/', '*', ' ')
			buffer.put_string (a_class_type.type.dump)
			buffer.put_three_character (' ', '*', '/')
			buffer.put_new_line
			buffer.put_string ("static EIF_TYPE_INDEX ptf");
			buffer.put_integer (l_type_id);
			buffer.put_string ("[] = {");

			j := 1
			n := count
			across Current as l_table loop
				l_table.key.generate_cid (buffer, final_mode, False, a_class_type.type)
				if j < n then
						-- Add a separator between parents.
					buffer.put_hex_natural_16 ({SHARED_GEN_CONF_LEVEL}.parent_type_separator)
					buffer.put_character (',')
				end

				if (j \\ 16) = 0 then
					buffer.put_new_line
				end

				j := j + 1
			end;

			buffer.put_hex_natural_16 ({SHARED_GEN_CONF_LEVEL}.terminator_type);
			buffer.put_string ("};%Nstatic struct eif_par_types par");

			buffer.put_integer (l_type_id);

			buffer.put_string (" = {")
			buffer.put_integer (l_type_id)
			buffer.put_string (", ptf")

			buffer.put_integer (l_type_id);

			buffer.put_string (", (uint16) ")
			buffer.put_integer (count)
			buffer.put_string (", (uint16) ")
			buffer.put_integer (generic_count)
			buffer.put_string (", (char) ")

			if is_expanded then
				buffer.put_string ("1")
			else
				buffer.put_string ("0")
			end

			buffer.put_string ("};%N");
		end;

	make_byte_code (ba: BYTE_ARRAY; a_class_type: CLASS_TYPE)
			-- Generate byte code
		local
			i, n: INTEGER
		do
			-- Dynamic type associated to the table
			ba.append_short_integer (type_id);
			-- Number of parents
			ba.append_short_integer (count)
			-- Number of formal generics
			ba.append_short_integer (generic_count)
			-- Static type
			ba.append_short_integer (type_id)
			-- Expandedness
			if is_expanded then
				ba.append ('%/001/')
			else
				ba.append ('%U')
			end

			i := 1
			n := count
			across Current as l_table loop
				l_table.key.make_type_byte_code (ba, False, a_class_type.type);
				if i < n then
						-- Add a separator between parents.
					ba.append_natural_16 ({SHARED_GEN_CONF_LEVEL}.parent_type_separator)
				end
				i := i + 1
			end;

				-- End mark
			ba.append_natural_16 ({SHARED_GEN_CONF_LEVEL}.terminator_type)
		end

feature {NONE}  -- Implementation

	same_keys (a_search_key, a_key: CL_TYPE_A): BOOLEAN
			-- <Precursor>
		do
			Result := a_search_key.same_as (a_key)
		end

	Init_size : INTEGER = 5
				-- Initial size of array

	Increment : INTEGER = 5
				-- Size increment

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software"
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

end -- class PARENT_TABLE

