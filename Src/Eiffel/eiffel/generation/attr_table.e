indexing
	description: "Representation of a table of attribute offsets for the final Eiffel executable."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class ATTR_TABLE [G -> ATTR_ENTRY]

inherit

	POLY_TABLE [G]
		redefine
			is_attribute_table, tmp_poly_table
		end

	SHARED_GENERATOR
		undefine
			copy, is_equal
		end

	SHARED_GENERATION
		undefine
			copy, is_equal
		end

create
	make

feature -- Status report

	is_attribute_table: BOOLEAN is
			-- Is the current table an attribute table ?
		do
			Result := True
		end

feature

	new_entry (f: FEATURE_I; c: INTEGER): ENTRY is
			-- New entry corresponding to `f' in class of class ID `c'
		do
			Result := f.new_attr_entry
			Result.set_class_id (c)
		end

	is_polymorphic (type_id: INTEGER): BOOLEAN is
			-- Is the table polymorphic from entry indexed by `type_id' to
			-- the maximum entry id ?
		local
			entry: ATTR_ENTRY;
			cl_type: CLASS_TYPE;
			first_type: CLASS_TYPE
			i, nb, old_position: INTEGER
			system_i: SYSTEM_I
			l_offset: STRING
			l_buffer: GENERATION_BUFFER
		do
			nb := max_position

			if nb > 1 then
				old_position := position
				system_i := System
				goto_used (type_id);
				i := position
				if i <= nb then
					from
						first_type := system_i.class_type_of_id (type_id);
						create l_buffer.make (50)
						first_type.skeleton.generate_offset (l_buffer, array_item (i).feature_id, False)
						l_offset := l_buffer.as_string
							-- We have computed the first element, we go directly to the next one.
						i := i + 1
					until
						Result or else i > nb
					loop
						entry := array_item (i)
						cl_type := system_i.class_type_of_id (entry.type_id);
						if cl_type.conform_to (first_type) then
							l_buffer.clear_all
							cl_type.skeleton.generate_offset (l_buffer, entry.feature_id, False)
							Result := not l_buffer.as_string.is_equal (l_offset)
						end
						i := i + 1
					end;
				end
				position := old_position
			end
		end;

	generate (writer: TABLE_GENERATOR) is
			-- Generation of the attribute table in buffer "eattr*.x".
		require
			writer_attached: writer /= Void
		local
			i, j, nb, index, l_start, l_end: INTEGER
			entry: ATTR_ENTRY
			l_offset, l_attr_offset: STRING
			l_buf: GENERATION_BUFFER
			l_table_name: STRING
			l_generate_entry: BOOLEAN
			l_class_type: CLASS_TYPE
			buffer: GENERATION_BUFFER
			final_table_size: INTEGER
		do
			final_table_size := max_type_id - min_type_id + 1
			writer.update_size (final_table_size)
			buffer := writer.current_buffer
				-- We generate a compact table initialization, that is to say if two or more
				-- consecutives rows are identical we will generate a loop to fill the rows
			from
					-- Private table
				buffer.put_new_line
				buffer.put_string ("long ")
				l_table_name := Encoder.attribute_table_name (rout_id)
				buffer.put_string (l_table_name)
				buffer.put_string ("[")
				buffer.put_integer (final_table_size)
				buffer.put_string ("];")
				buffer.put_new_line
				buffer.put_string ("void ")
				buffer.put_string (l_table_name)
				buffer.put_string ("_init () {")
				buffer.indent

				create l_buf.make (24)
				i := min_type_id
				nb := max_type_id
				goto (i)
				index := position
			until
				i > nb
			loop
				entry := array_item (index)
				if i = entry.type_id then
					l_class_type := System.class_type_of_id (entry.type_id)
					if l_attr_offset = Void then
						l_buf.clear_all
							--| In this instruction, we put `True' as second arguments.
							--| This means we will generate something if there is nothing to
							--| generate (ie `0'). Remember that `False' is used in all other case
						l_class_type.skeleton.generate_offset (l_buf, entry.feature_id, True)
						l_attr_offset := l_buf.as_string
						l_start := j
						l_end := j
					else
						l_buf.clear_all
							--| In this instruction, we put `True' as second arguments.
							--| This means we will generate something if there is nothing to
							--| generate (ie `0'). Remember that `False' is used in all other case
						l_class_type.skeleton.generate_offset (l_buf, entry.feature_id, True)
						l_offset := l_buf.as_string
						if l_attr_offset.is_equal (l_offset) then
							l_end := j
						else
							l_generate_entry := True
						end
					end
					index := index + 1
				else
					l_generate_entry := True
					l_offset := Void
				end

				if l_generate_entry then
					l_generate_entry := False
					if l_attr_offset /= Void then
						generate_loop_initialization (buffer, l_table_name, l_attr_offset,
							l_start, l_end)
						l_attr_offset := l_offset
						l_start := j
						l_end := j
					end
				end
				i := i + 1
				j := j + 1
			end
			if l_attr_offset /= Void then
				generate_loop_initialization (buffer, l_table_name, l_attr_offset, l_start, l_end)
			end

			buffer.exdent
			buffer.put_three_character ('%N', '}', '%N')
		end

feature {POLY_TABLE} -- Special data

	tmp_poly_table: ARRAY [ATTR_ENTRY] is
			-- Contain a copy of Current during a merge
		once
			create Result.make (1, Block_size)
		end

feature {NONE} -- Implementation

	generate_loop_initialization (buffer: GENERATION_BUFFER; a_table_name, a_offset: STRING; a_lower, a_upper: INTEGER) is
			-- Generate code to initialize current array with `a_routine_name'. Generate a
			-- loop if `a_lower' is different from `a_upper'.
		require
			buffer_not_void: buffer /= Void
			a_table_name_not_void: a_table_name /= Void
			a_offset_not_void: a_offset /= Void
			a_lower_non_negative: a_lower >= 0
			a_upper_non_negative: a_upper >= 0
			a_upper_greater_or_equal_than_a_lower: a_upper >= a_lower
		do
			buffer.put_new_line
			if a_lower = a_upper then
				buffer.put_string (a_table_name)
				buffer.put_character ('[')
				buffer.put_integer (a_lower)
				buffer.put_string ("] = ")
				buffer.put_string (a_offset)
				buffer.put_character (';')
			else
				buffer.put_string ("{long i; for (i = ")
				buffer.put_integer (a_lower)
				buffer.put_string ("; i < ")
				buffer.put_integer (a_upper + 1)
				buffer.put_string ("; i++) ")
				buffer.put_string (a_table_name)
				buffer.put_string ("[i] = ")
				buffer.put_string (a_offset)
				buffer.put_two_character (';', '}')
			end
		end

	write is
			-- Generate table using writer.
		do
			generate (Attr_generator)
		end

	write_for_type
			-- <Precursor>
		do
			generate_type_table (Attr_generator)
		end

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
