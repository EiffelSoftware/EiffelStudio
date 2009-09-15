note
	description:	"Pattern matcher through the Knuth Morris Pratt algorithm. See details at the end"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date:		"$Date$";
	revision:	"$Revision$"

class KMP_MATCHER

inherit
	MATCHER
		redefine
			make_empty
		end

create
	make, make_empty

feature -- Creation

	make_empty
			-- <Precursor>
		do
			create table.make_filled (0, 0) -- Empty
			Precursor {MATCHER}
		end

feature -- Access

	found_pattern_length: INTEGER
			-- length of the found pattern in text
		do
			Result := pattern.count
		end

	matching_indices: detachable ARRAYED_LIST [INTEGER]
			-- indices of found pattern in text

	lengths: detachable ARRAYED_LIST [INTEGER]
			-- lengths of found patterns in text
		local
			i, fpl: INTEGER
		do
			if attached  matching_indices as l_indices then
				create Result.make (l_indices.count)
				from
					i := 1
					fpl := found_pattern_length
				until
					i > Result.capacity
				loop
					Result.extend (fpl)
					i := i + 1
				end
			end
		end

feature -- Status Report

	is_not_case_sensitive: BOOLEAN
			-- Is the search case insensitive ?

feature -- Status setting

	set_pattern (new_pattern: STRING)
			-- Set `pattern' to new `pattern'.
		do
			pattern := new_pattern;
			-- init_arrays -- to add case sensitivity
		end;

	enable_case_sensitive
			-- Set `is_not_case_sensitive' to False
		do
			is_not_case_sensitive := False
		end

	disable_case_sensitive
			-- Set `is_not_case_sensitive' to True
		do
			is_not_case_sensitive := True
		end

feature -- Search

	search_for_pattern: BOOLEAN
			-- Search in `text' to find very next
			-- occurrence of `pattern'.
		local
			text_count, pattern_count, i: INTEGER
			old_pattern: like pattern
			old_text: like text
			text_area, pattern_area: SPECIAL [CHARACTER]
			l_table: SPECIAL [INTEGER]
			j: INTEGER
		do
			old_text := text
			old_pattern := pattern
			from
				if is_not_case_sensitive then
					pattern := pattern.as_lower
					text := text.as_lower
				end
				init_arrays
				pattern_area := pattern.area
				l_table := table
				text_area := text.area
				pattern_count := pattern.count
				text_count := text.count
				i := index - 1
				j := 0
			until
				Result or else i >= text_count
			loop
				if (j = -1) or else (pattern_area.item (j) = text_area.item (i)) then
					i := i + 1
					j := j + 1
					if j >= pattern_count then
						Result := True
						index := i
					end
				else
					j := l_table.item (j)
				end
			end
			found := Result
			if is_not_case_sensitive then
				text := old_text
				pattern := old_pattern
			end
		end

	find_matching_indices
			-- All indices in `text' which matches the
			-- very next occurrence of `pattern'.
		local
			text_count, pattern_count, i: INTEGER
			text_area, pattern_area: SPECIAL [CHARACTER]
			l_table: SPECIAL [INTEGER]
			old_pattern: like pattern
			old_text: like text
			j: INTEGER
			finished: BOOLEAN
			t: ARRAYED_LIST [INTEGER]
		do
			old_text := text
			old_pattern := pattern
			from
				if is_not_case_sensitive then
					pattern := pattern.as_lower
					text := text.as_lower
				end
				init_arrays
				create t.make (10)
				pattern_area := pattern.area
				pattern_count := pattern.count
				l_table := table
				text_area := text.area
				text_count := text.count
				i := index - 1
				j := 0
			until
				finished or else i >= text_count
			loop
				if (j = -1) or else (pattern_area.item (j) = text_area.item (i)) then
					i := i + 1
					j := j + 1
					if j >= pattern_count then
						t.extend (i - pattern_count + 1)
						j := l_table.item (j)
					end
				else
					j := l_table.item (j)
				end
			end
			matching_indices := t
			if is_not_case_sensitive then
				text := old_text
				pattern := old_pattern
			end
		ensure
			found_or_not_found: attached matching_indices as le_indices and then
				not le_indices.is_empty = search_for_pattern
		end

feature {NONE} -- Initialization

	init_arrays
			-- Initializes arrays for pattern.
		local
			l_table: SPECIAL [INTEGER]
			pattern_area: SPECIAL [CHARACTER]
			pattern_count: INTEGER
			l,k: INTEGER
		do
			from
				pattern_area := pattern.area
				pattern_count := pattern.count
				table := table.aliased_resized_area_with_default (0, pattern_count + 1)
				l_table := table
				l := 0
				k := -1
				l_table.put (-1, 0)
			until
				l >= pattern_count
			loop
				if (k = -1) or (pattern_area.item (l) = pattern_area.item (k)) then
					l := l + 1
					k := k + 1
					if (pattern_area.item (k) = pattern_area.item (l)) then
						l_table.put (l_table.item (k), l)
					else
						l_table.put (k, l)
					end
				else
					k := l_table.item (k)
				end
			end
		end

feature {NONE} -- Attributes

	table: SPECIAL [INTEGER];
		-- Pattern automaton

note
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

end -- class KMP_MATCHER

