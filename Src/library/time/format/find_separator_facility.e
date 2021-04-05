note
	description: "Facility to find separators in date or time strings"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	FIND_SEPARATOR_FACILITY

inherit
	CODE_VALIDITY_CHECKER
		export
			{NONE} all
		end

	ANY

feature {NONE} -- Constants

	Separator_characters: STRING_8 = ":/-, ."

feature {NONE} -- Implementation

	find_separator (s: READABLE_STRING; i: INTEGER): INTEGER
			-- Position of the next separator in `s' starting at
			-- `i'-th character.
			-- ":", "/", "-", ",", " ", "."
		require
			s_exists: s /= Void
			i_in_range: 1 <= i and i <= s.count
		local
			j, pos: INTEGER
			ch: CHARACTER
			sep_found: BOOLEAN
		do
			Result := s.count + 1
			from
				j := 1
			invariant
				inside_bounds: Result >= i and Result <= s.count + 1
			until
				j > Separator_characters.count
			loop
				pos := s.index_of (Separator_characters [j], 1)
				if pos /= 0 then
					sep_found := True
					pos := s.index_of (Separator_characters [j], i)
					if pos /= 0 and pos < Result then
						Result := pos
					end
				end
				j := j + 1
			end
			if not sep_found then
				from
					j := i
					if s.substring (j, j + 2).same_string ("[0]") then
						j := j + 3
					end
					ch := s [j]
				until
					j > s.count or else s [j] /= ch
				loop
					j := j + 1
					if j <= s.count then
							-- Ensure the `mi' does not get seen to be a separator
						if ch = 'm' and then s [j] = 'i' then
							ch := s [j]
						elseif ch = 'h' and then s [j] = '1' and (s.valid_index (j + 1) and then s.item (j + 1) = '2') then
							j := j + 1
							ch := s [j]
						end
					end
				end
				Result := (j - 1) * -1
			end
		ensure
			not_zero: Result /= 0
		end

	extracted_substrings (s: READABLE_STRING; pos1, pos2: INTEGER): TUPLE [substrg, substrg2: READABLE_STRING]
			-- Extract `substrg' and `substrg2' from `s' and specified by the
			-- range `pos1'..`pos2'.
		require
			string_exists: s /= Void
			range_correct: pos1 <= pos2.abs
		local
			l_substrg, l_substrg2: READABLE_STRING
		do
			if pos2 > 0 then
				l_substrg := s.substring (pos1, pos2 - 1)
				l_substrg2 := s.substring (pos2, pos2)
			else
				l_substrg := s.substring (pos1, - pos2)
				create {IMMUTABLE_STRING} l_substrg2.make (0)
			end
			Result := [l_substrg, l_substrg2]
		ensure
			extracted_substrings_not_void: Result /= Void
			substrings_extracted: Result.substrg /= Void and Result.substrg2 /= Void
		end

	has_separators (s: READABLE_STRING): BOOLEAN
			-- Does date string `s' contain any separators?
		require
			string_exists: s /= Void
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > s.count or Result
			loop
				Result := is_separator (s.substring (i, i))
				i := i + 1
			end
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
