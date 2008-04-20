indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Table of patterns

class PATTERN_TABLE

inherit

	SEARCH_TABLE [PATTERN_INFO]
		rename
			make as search_table_make
		end
	SHARED_CODE_FILES
		undefine
			copy, is_equal
		end
	SHARED_WORKBENCH
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

	patterns: SEARCH_TABLE [PATTERN]
			-- Shared references on patterns

	info_array: HASH_TABLE [PATTERN_INFO, INTEGER]
			-- Table of pattern information in order to reference them
			-- through an index.

	last_pattern_id: INTEGER
			-- Pattern id processed after last insertion

	c_patterns: SEARCH_TABLE [C_PATTERN_INFO]
			-- Non formal patterns present already in the system

	c_patterns_by_ids: HASH_TABLE [C_PATTERN_INFO, INTEGER]
			-- Same as `c_patterns' but indexed by the `c_pattern_id'.

	pattern_id_counter: COMPILER_COUNTER
			-- Pattern id counter

	c_pattern_id_counter: COUNTER
			-- Counter of C patterns

	make is
			-- Table creation
		do
			search_table_make (Chunk)
			create patterns.make (Chunk)
			create info_array.make (Chunk)
			create c_pattern_id_counter
			create pattern_id_counter.make
			create c_patterns.make (Chunk)
			create c_patterns_by_ids.make (Chunk)
		end

	Chunk: INTEGER is 100
			-- Table chunk

	process is
			-- Process the table of C patterns
		local
			c_pattern: C_PATTERN
			types: TYPE_LIST
			info: PATTERN_INFO
			c_pattern_info: C_PATTERN_INFO
			assoc_class: CLASS_C
		do
			from
				info_array.start
			until
				info_array.after
			loop
				info := info_array.item_for_iteration
				assoc_class := info.associated_class
				if assoc_class /= Void and info.pattern.is_valid (assoc_class) then
					from
						types := info.associated_class.types
						types.start
					until
						types.after
					loop
						c_pattern := info.instantiation_in (types.item).c_pattern
						create c_pattern_info.make (c_pattern)
						if not c_patterns.has (c_pattern_info) then
							c_pattern_info.set_c_pattern_id (c_pattern_id_counter.next)
							c_patterns.put (c_pattern_info)
							c_patterns_by_ids.put (c_pattern_info, c_pattern_info.c_pattern_id)
						end
						types.forth
					end
					info_array.forth
				else
					info_array.remove (info_array.key_for_iteration)
				end
			end
		end

	insert (written_in: INTEGER; pattern: PATTERN) is
		require
			good_argument: pattern /= Void
		local
			other_pattern: PATTERN
			info, other_info: PATTERN_INFO
		do
			create info.make (written_in, pattern)
			other_info := item (info)
			if other_info = Void then
				other_pattern := patterns.item (pattern)
				if other_pattern = Void then
					patterns.put (pattern)
				else
					info.set_pattern (other_pattern)
				end
				put (info)

				last_pattern_id := pattern_id_counter.next_id
				info.set_pattern_id (last_pattern_id)
				info_array.put (info, last_pattern_id)
			else
				last_pattern_id := other_info.pattern_id
			end
		end

	pattern_of_id (i: INTEGER; type: CLASS_TYPE): PATTERN is
			-- Pattern information of id `i'.
		require
			valid_id: info_array.has (i)
		do
			Result := info_array.item (i).instantiation_in (type)
		end

	c_pattern_id (pattern_id: INTEGER; cl_type: CLASS_TYPE): INTEGER is
			-- Pattern id of C pattern `p'
		require
			good_type: cl_type /= Void
		local
			info: C_PATTERN_INFO
		do
			Marker.set_pattern (pattern_of_id (pattern_id, cl_type).c_pattern)
			info := c_patterns.item (Marker)
			if info /= Void then
				Result := info.c_pattern_id
			end
		end

	Marker: C_PATTERN_INFO is
			-- Marker for search in `c_patterns'
		local
			l_pattern: C_PATTERN
			l_shared_types: SHARED_TYPE_I
		once
			create l_shared_types
			create l_pattern.make (l_shared_types.Void_c_type)
			create Result.make (l_pattern)
		end

feature -- Generation

	generate is
			-- Generate patterns
		local
			i, nb: INTEGER
			pattern_file: INDENT_FILE
			buffer: GENERATION_BUFFER
		do
				-- Clear buffer for current generation
			buffer := generation_buffer
			buffer.clear_all

			buffer.put_string ("%
				%#include %"eif_macros.h%"%N%
				%#include %"eif_struct.h%"%N%
				%#include %"eif_interp.h%"")

			buffer.start_c_specific_code

			generate_pattern (buffer)

				-- Generate pattern table
			buffer.put_new_line_only
			buffer.put_string ("struct p_interface egc_fpattern_init[] = {%N")
			from
				i := 1
				nb := c_pattern_id_counter.value
			until
				i > nb
			loop
				buffer.put_string ("{(void (*)(fnptr)) toc")
				buffer.put_integer (i)
				buffer.put_string (", (fnptr) toi")
				buffer.put_integer (i)
				buffer.put_string ("},%N")
				i := i + 1
			end
			buffer.put_string ("};")

			buffer.end_c_specific_code

			create pattern_file.make_c_code_file (workbench_file_name (Epattern, Dot_c, 1));
			buffer.put_in_file (pattern_file)
			pattern_file.close
		end

	generate_pattern (buffer: GENERATION_BUFFER) is
			-- Generate pattern for interfacing C generated code and
			-- the interpreter
		do
			from
				c_patterns.start
			until
				c_patterns.after
			loop
				c_patterns.item_for_iteration.generate_pattern (buffer)
				c_patterns.forth
			end
		end

invariant

	patterns_exists: patterns /= Void
	info_array_exists: info_array /= Void

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
