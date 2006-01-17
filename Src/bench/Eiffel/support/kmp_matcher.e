indexing
	description:	"Pattern matcher through the Knuth Morris Pratt algorithm. See details at the end"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date:		"$Date$";
	revision:	"$Revision$"
	
class KMP_MATCHER 

inherit
	MATCHER

create
	make, make_empty

feature -- Access

	found_pattern_length: INTEGER is
			-- length of the found pattern in text
		do
			Result := pattern.count
		end

	matching_indices: ARRAYED_LIST [INTEGER]
			-- indices of found pattern in text

	lengths: ARRAYED_LIST [INTEGER] is
			-- lengths of found patterns in text
		local
			i, fpl: INTEGER
		do
			if matching_indices /= Void then
				create Result.make (matching_indices.count)
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

	set_pattern (new_pattern: STRING) is
			-- Set `pattern' to new `pattern'.
		do
			pattern := new_pattern;
			-- init_arrays -- to add case sensitivity
		end;

	enable_case_sensitive is
			-- Set `is_not_case_sensitive' to False
		do	
			is_not_case_sensitive := False
		end

	disable_case_sensitive is
			-- Set `is_not_case_sensitive' to True
		do	
			is_not_case_sensitive := True
		end


feature -- Search

	search_for_pattern: BOOLEAN is
			-- Search in `text' to find very next
			-- occurrence of `pattern'.
		local
			text_count, pattern_count, i: INTEGER
			old_pattern, old_text: STRING
			text_area, pattern_area: SPECIAL [CHARACTER]
			table_area: SPECIAL [INTEGER]
			j: INTEGER
		do
			from
				if is_not_case_sensitive then
					old_text := text
					old_pattern := pattern
					pattern := pattern.as_lower
					text := text.as_lower
				end
				init_arrays 
				pattern_area := pattern.area
				table_area := table.area
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
					j := table_area.item (j)
				end
			end
			found := Result
			if is_not_case_sensitive then
				text := old_text
				pattern := old_pattern
			end
		end


	find_matching_indices is
			-- All indices in `text' which matches the
			-- very next occurrence of `pattern'.
		local
			text_count, pattern_count, i: INTEGER
			text_area, pattern_area: SPECIAL [CHARACTER]
			table_area: SPECIAL [INTEGER]
			old_pattern, old_text: STRING
			j: INTEGER
			finished: BOOLEAN
			t: ARRAYED_LIST [INTEGER]
		do
			from
				if is_not_case_sensitive then
					old_text := text
					old_pattern := pattern
					pattern := pattern.as_lower
					text := text.as_lower
				end
				init_arrays 
				create t.make (10)
				pattern_area := pattern.area
				pattern_count := pattern.count
				table_area := table.area
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
						j := table_area.item (j)
					end
				else
					j := table_area.item (j)
				end
			end
			matching_indices := t
			if is_not_case_sensitive then
				text := old_text
				pattern := old_pattern
			end
		ensure
			found_or_not_found: not matching_indices.is_empty = search_for_pattern	
		end
	
feature {NONE} -- Initialization

	init_arrays is
			-- Initializes arrays for pattern.
		local
			table_area: SPECIAL [INTEGER]
			pattern_area: SPECIAL [CHARACTER]
			pattern_count: INTEGER
			l,k: INTEGER
		do
			from 
				pattern_area := pattern.area
				pattern_count := pattern.count
				create table.make (0, pattern_count)
				table_area := table.area
				l := 0
				k := -1
				table_area.put (-1, 0)
			until
				l >= pattern_count
			loop
				if (k = -1) or (pattern_area.item (l) = pattern_area.item (k)) then
					l := l + 1
					k := k + 1
					if (pattern_area.item (k) = pattern_area.item (l)) then
						table_area.put (table_area.item (k), l)
					else
						table_area.put (k, l)
					end
				else
					k := table_area.item (k)
				end
			end

		end;
	
feature {NONE} -- Attributes

	table: ARRAY [INTEGER];
		-- Pattern automaton
		
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


end -- class KMP_MATCHER

