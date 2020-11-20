note
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

create {PATTERN_TABLE}
	make_with_key_tester

feature {NONE} -- Implementation

	make
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

	c_pattern_id_in (pattern_id: INTEGER; cl_type: CLASS_TYPE): INTEGER
			-- C pattern ID of pattern `pattern_id' instantiated in `cl_type'.
		require
			pattern_id_positive: pattern_id > 0
			has_pattern_id: has_pattern_of_id (pattern_id)
			good_type: cl_type /= Void
		local
			l_c_pattern: C_PATTERN
			l_c_pattern_marker: like c_pattern_marker
			l_c_patterns: like c_patterns
		do
				-- Reuse pattern marker pattern to avoid creating any unnecessary objects.
			l_c_pattern_marker := c_pattern_marker
			l_c_pattern := l_c_pattern_marker.pattern
			l_c_patterns := c_patterns

			info_array.item (pattern_id).pattern.update_c_pattern_with_instantiation_in (l_c_pattern, cl_type)

			l_c_patterns.search (l_c_pattern_marker)
			if l_c_patterns.found then
				Result := l_c_patterns.found_item.c_pattern_id
			else
				insert_c_pattern (l_c_pattern.duplicate)
					-- Optimization to avoid searching again
				Result := c_pattern_id_counter.value
				check
					optimization_ok: Result = c_pattern_id (l_c_pattern)
				end
			end
		ensure
			c_pattern_id_in_positive: Result > 0
		end

	c_pattern_id (a_c_pattern: C_PATTERN): INTEGER
			-- C pattern ID from `a_c_pattern'.
			-- Side effect: Update `c_patterns' and `c_patterns_by_ids' if not present.
		require
			a_c_pattern_not_void: a_c_pattern /= Void
		do
			c_pattern_marker.set_pattern (a_c_pattern)
			c_patterns.search (c_pattern_marker)
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

	c_pattern_of_id (a_pattern_id: INTEGER): C_PATTERN
			-- C pattern of ID `a_pattern_id'.
		require
			a_pattern_id_positive: a_pattern_id > 0
		do
			Result := c_patterns_by_ids.item (a_pattern_id).pattern
		end

feature -- Status report

	has_c_pattern (a_c_pattern: C_PATTERN): BOOLEAN
			-- Is `a_c_pattern' present in Current?
		require
			a_c_pattern_not_void: a_c_pattern /= Void
		do
			c_pattern_marker.set_pattern (a_c_pattern)
			Result := c_patterns.has (c_pattern_marker)
		end

	has_pattern_of_id (a_pattern_id: INTEGER): BOOLEAN
			-- Is pattern of Id `a_pattern_id' present?
		require
			a_pattern_id_positive: a_pattern_id > 0
		do
			Result := info_array.has (a_pattern_id)
		end

feature -- Processing

	process
			-- Process the table of C patterns
		local
			c_pattern: C_PATTERN
			types: TYPE_LIST
			info: PATTERN_INFO
			assoc_class: CLASS_C
		do
			from
				info_array.start
				c_pattern := c_pattern_marker.pattern
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
						info.pattern.update_c_pattern_with_instantiation_in (c_pattern, types.item)
						if not has_c_pattern (c_pattern) then
							insert_c_pattern (c_pattern.duplicate)
						end
						types.forth
					end
					info_array.forth
				else
					info_array.remove (info_array.key_for_iteration)
					remove (info)
				end
			end
		end

feature -- Element change

	reusable_arguments_array: SPECIAL [TYPE_A]
		once
			create Result.make_empty (10)
		end

	insert_pattern_from_feature_i (a_feature_i: FEATURE_I)
			-- Insert new pattern using `a_feature_i'.
		local
			pattern: PATTERN
			info: PATTERN_INFO
			new_pattern: PATTERN
			new_info: PATTERN_INFO
			l_arguments_array: SPECIAL [TYPE_A]
			l_feature_args: SPECIAL [TYPE_A]
			l_arguments_count: INTEGER
			i: INTEGER
		do
				-- Set pattern marker for search.
			info := pattern_marker
			pattern := info.pattern
			l_arguments_count := a_feature_i.argument_count
			if l_arguments_count > 0 then
				l_arguments_array := reusable_arguments_array
				l_arguments_array.keep_head (0)
				if l_arguments_array.capacity < l_arguments_count then
					l_arguments_array := l_arguments_array.aliased_resized_area (l_arguments_count)
				end
				from
					i := 0
					l_feature_args := a_feature_i.arguments.area_v2
				until
					i = l_arguments_count
				loop
					l_arguments_array.extend (l_feature_args [i].meta_type)
					i := i + 1
				end
			end
			pattern.update (a_feature_i.pattern_type, l_arguments_array)
			info.set_pattern (pattern)
			info.set_written_in (a_feature_i.generation_class_id)

				-- Set pattern marker for search.
			new_info := item (info)
			if new_info = Void then
				new_pattern := patterns.item (info.pattern)
				if new_pattern = Void then
						-- This is a brand new pattern so we add it to the patterns search table.
					new_pattern := info.pattern.duplicate
					patterns.put (new_pattern)
				end
				create new_info.make (info.written_in, new_pattern)
				put (new_info)
				last_pattern_id := pattern_id_counter.next_id
				new_info.set_pattern_id (last_pattern_id)
				info_array.put (new_info, last_pattern_id)
			else
				last_pattern_id := new_info.pattern_id
			end
		ensure
			inserted: has_pattern_of_id (last_pattern_id)
		end

	insert_c_pattern (a_c_pattern: C_PATTERN)
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

	generate
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

	generate_pattern (buffer: GENERATION_BUFFER)
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

	Chunk: INTEGER = 100
			-- Table chunk

	pattern_marker: PATTERN_INFO
			-- Marker for search in `Current'.
		local
			l_pattern: PATTERN
			l_shared_types: SHARED_TYPES
		once
				-- Create reusable pattern for use in searching.
			create l_shared_types
			create l_pattern.make (l_shared_types.void_type, Void)
			create Result.make (0, l_pattern)
		end

	c_pattern_marker: C_PATTERN_INFO
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

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
