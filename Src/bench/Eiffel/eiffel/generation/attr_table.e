indexing
	description: "Representation of a table of attribute offsets for the final Eiffel executable."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class ATTR_TABLE

inherit
	POLY_TABLE [ATTR_ENTRY]
		rename
			writer as Attr_generator
		redefine
			final_table_size, tmp_poly_table
		end;

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

feature

	final_table_size: INTEGER is
			-- Table size
		do
			Result := max_type_id - min_type_id + 1;
		end;

	is_polymorphic (type_id: INTEGER): BOOLEAN is
			-- Is the table polymorphic from entry indexed by `type_id' to
			-- the maximum entry id ?
		local
			current_type_id: INTEGER;
			entry: ATTR_ENTRY;
			cl_type: CLASS_TYPE;
			first_type: CLASS_TYPE
			i, nb, old_position: INTEGER
			system_i: SYSTEM_I
			offset: INTEGER
		do
			nb := max_position

			if nb > 1 then
				old_position := position
				system_i := System

					-- If it is not a poofter finalization
					-- we have a quicker algorithm handy.
				if not system_i.poofter_finalization then	
					goto_used (type_id);
					i := position
					if i <= nb then
						from
							first_type := system_i.class_type_of_id (type_id);
							offset := first_type.skeleton.offset (array_item (i).feature_id)
							i := i + 1
						until
							Result or else i > nb
						loop
							entry := array_item (i)
							cl_type := system_i.class_type_of_id (entry.type_id);
							Result := cl_type.conform_to (first_type)
									and then not (cl_type.skeleton.offset (entry.feature_id) = offset)
							i := i + 1
						end;
					end
				else
					from
						goto_used (type_id)
						i := lower
						first_type := system_i.class_type_of_id (type_id);
						offset := first_type.skeleton.offset (array_item (position).feature_id)
					until
						Result or else i > nb
					loop
						entry := array_item (i)
						current_type_id := entry.type_id;
						if current_type_id /= type_id then
							cl_type := system_i.class_type_of_id (current_type_id);
							Result := cl_type.conform_to (first_type)
									and then not (cl_type.skeleton.offset (entry.feature_id) = offset) 
						end;
						i := i + 1
					end;
				end
				position := old_position
			end
		end;

	generate (buffer: GENERATION_BUFFER) is
			-- Generation of the attribute table in buffer "eattr*.x".
		local
			i, j, nb, index, l_start, l_end: INTEGER
			entry: ATTR_ENTRY
			l_offset, l_attr_offset: STRING
			l_buf: GENERATION_BUFFER
			l_table_name: STRING
			l_generate_entry: BOOLEAN
			l_class_type: CLASS_TYPE
		do
				-- We generate a compact table initialization, that is to say if two or more
				-- consecutives rows are identical we will generate a loop to fill the rows
			from
					-- Private table
				buffer.put_string ("long ")
				l_table_name := Encoder.table_name (rout_id)
				buffer.put_string (l_table_name)
				buffer.put_string ("[")
				buffer.put_integer (final_table_size)
				buffer.put_string ("];")
				buffer.put_new_line
				buffer.put_string ("void ")
				buffer.put_string (l_table_name)
				buffer.put_string ("_init () {")
				buffer.put_new_line
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
			buffer.put_string ("}%N%N")
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
			if a_lower = a_upper then
				buffer.put_string (a_table_name)
				buffer.put_character ('[')
				buffer.put_integer (a_lower)
				buffer.put_string ("] = ")
				buffer.put_string (a_offset)
				buffer.put_character (';')
				buffer.put_new_line
			else
				buffer.put_string ("{long i; for (i = ")
				buffer.put_integer (a_lower)
				buffer.put_string ("; i < ")
				buffer.put_integer (a_upper + 1)
				buffer.put_string ("; i++) ")
				buffer.put_string (a_table_name)
				buffer.put_string ("[i] = ")
				buffer.put_string (a_offset)
				buffer.put_character (';')
				buffer.put_character ('}')
				buffer.put_new_line
			end
		end

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
