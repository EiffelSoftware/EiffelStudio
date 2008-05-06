indexing
	description: "[
		Record all the possible signatures that an Eiffel system may have. We have 2 kinds of patterns:
		1 - pattern taken directly from source code possibly instantiated in generic derivations: PATTERN
		2 - associated C signature of the patterns obtained by (1): C_PATTERN
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."

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

feature {NONE} -- Implementation

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

feature -- Access

	last_pattern_id: INTEGER
			-- Pattern id processed after last insertion

	pattern_of_id (i: INTEGER; type: CLASS_TYPE): PATTERN is
			-- Pattern information of id `i'.
		require
			i_positive: i > 0
			valid_id: has_pattern_of_id (i)
			type_not_void: type /= Void
		do
			Result := info_array.item (i).instantiation_in (type)
		end

	c_pattern_id_in (pattern_id: INTEGER; cl_type: CLASS_TYPE): INTEGER is
			-- C pattern ID of pattern `pattern_id' instantiated in `cl_type'.
		require
			pattern_id_positive: pattern_id > 0
			has_pattern_id: has_pattern_of_id (pattern_id)
			good_type: cl_type /= Void
		do
			Result := c_pattern_id (pattern_of_id (pattern_id, cl_type).c_pattern)
		ensure
			c_pattern_id_in_positive: Result > 0
		end

	c_pattern_id (a_c_pattern: C_PATTERN): INTEGER is
			-- C pattern ID from `a_c_pattern'.
			-- Side effect: Update `c_patterns' and `c_patterns_by_ids' if not present.
		require
			a_c_pattern_not_void: a_c_pattern /= Void
		do
			marker.set_pattern (a_c_pattern)
			c_patterns.search (marker)
			if c_patterns.found then
				Result := c_patterns.found_item.c_pattern_id
			else
				insert_c_pattern (a_c_pattern)
					-- Optimization to avoid searching again
				Result := c_pattern_id_counter.value
				check
					optimization_ok: Result = c_pattern_id (a_c_pattern)
				end
			end
		ensure
			c_pattern_id_positive: Result > 0
		end

	c_pattern_of_id (a_pattern_id: INTEGER): C_PATTERN is
			-- C pattern of ID `a_pattern_id'.
		require
			a_pattern_id_positive: a_pattern_id > 0
		do
			Result := c_patterns_by_ids.item (a_pattern_id).pattern
		end

feature -- Status report

	has_c_pattern (a_c_pattern: C_PATTERN): BOOLEAN is
			-- Is `a_c_pattern' present in Current?
		require
			a_c_pattern_not_void: a_c_pattern /= Void
		do
			marker.set_pattern (a_c_pattern)
			Result := c_patterns.has (marker)
		end

	has_pattern_of_id (a_pattern_id: INTEGER): BOOLEAN is
			-- Is pattern of Id `a_pattern_id' present?
		require
			a_pattern_id_positive: a_pattern_id > 0
		do
			Result := info_array.has (a_pattern_id)
		end

feature -- Processing

	process is
			-- Process the table of C patterns
		local
			c_pattern: C_PATTERN
			types: TYPE_LIST
			info: PATTERN_INFO
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
						if not has_c_pattern (c_pattern) then
							insert_c_pattern (c_pattern)
						end
						types.forth
					end
					info_array.forth
				else
					info_array.remove (info_array.key_for_iteration)
				end
			end
		end

feature -- Element change

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

	insert_c_pattern (a_c_pattern: C_PATTERN) is
			-- Insert `a_c_pattern' in Current and gives it a new C pattern ID.
		require
			a_c_pattern_not_void: a_c_pattern /= Void
			not_has_c_pattern: not has_c_pattern (a_c_pattern)
		local
			l_c_pattern_info: C_PATTERN_INFO
			l_c_pattern_id: INTEGER
		do
			create l_c_pattern_info.make (a_c_pattern)
			l_c_pattern_id := c_pattern_id_counter.next
			l_c_pattern_info.set_c_pattern_id (l_c_pattern_id)
			c_patterns.put (l_c_pattern_info)
			c_patterns_by_ids.put (l_c_pattern_info, l_c_pattern_id)
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
				buffer.put_string (once "{(void (*)(fnptr)) toc")
				buffer.put_integer (i)
				buffer.put_string (once ", (fnptr) toi")
				buffer.put_integer (i)
				buffer.put_string (once "},%N")
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

feature {NONE} -- Impementation: Access

	patterns: SEARCH_TABLE [PATTERN]
			-- Shared references on patterns

	info_array: HASH_TABLE [PATTERN_INFO, INTEGER]
			-- Table of pattern information in order to reference them
			-- through an index.

	c_patterns: SEARCH_TABLE [C_PATTERN_INFO]
			-- Non formal patterns present already in the system

	c_patterns_by_ids: HASH_TABLE [C_PATTERN_INFO, INTEGER]
			-- Same as `c_patterns' but indexed by the `c_pattern_id'.

	pattern_id_counter: COMPILER_COUNTER
			-- Pattern id counter

	c_pattern_id_counter: COUNTER
			-- Counter of C patterns

	Chunk: INTEGER is 100
			-- Table chunk

	Marker: C_PATTERN_INFO is
			-- Marker for search in `c_patterns'
		local
			l_pattern: C_PATTERN
			l_shared_types: SHARED_TYPE_I
		once
			create l_shared_types
			create l_pattern.make (l_shared_types.Void_c_type, Void)
			create Result.make (l_pattern)
		ensure
			marker_not_void: Result /= Void
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
