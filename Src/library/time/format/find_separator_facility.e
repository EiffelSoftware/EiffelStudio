indexing
	description: "Facility to find seperators in date or time strings" 
	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

class FIND_SEPARATOR_FACILITY inherit

	BASIC_ROUTINES
		export
			{NONE} all
		end

	CODE_VALIDITY_CHECKER
		export
			{NONE} all
		end

feature {NONE} -- Constants

	Separator_characters: STRING is ":/-, ."

feature {NONE} -- Implementation

	substrg, substrg2: STRING
	
	find_separator (s: STRING; i: INTEGER): INTEGER is
			-- Position of the next separator in `s' starting at 
			-- `i'-th character.
			-- ":", "/", "-", ",", " ", "."
		require
			s_exists: s /= Void
			i_in_range: 1 <= i and i <= s.count
		local
			j, pos: INTEGER
			ch: CHARACTER
			tmp_strg: STRING
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
				pos := s.index_of (Separator_characters @ j, 1)
				if pos /= 0 then
					sep_found := True
					pos := s.index_of (Separator_characters @ j, i)
					if pos /= 0 and pos < Result then
						Result := pos
					end
				end
				j := j + 1
			end
			if not sep_found then
				from
					j := i
					tmp_strg := s.substring (j, j + 2)
					if equal (tmp_strg, "[0]") then
						j := j + 3
					end
					ch := s @ j
				until
					j > s.count or else (s @ j) /= ch
				loop
					j := j + 1
					if ch = 'm' and then (s @ j) = 'i' then
						ch := s @ j
					end
				end
				Result := (j - 1) * -1
			end
		ensure
			not_zero: Result /= 0
		end
		
	extract_substrings (s: STRING; pos1, pos2: INTEGER) is
			-- Extract `substrg' and `substrg2' from `s' and specified by the
			-- range `pos1'..`pos2'.
		require
			string_exists: s /= Void
			range_correct: pos1 <= abs (pos2)
		local
			upper: INTEGER
		do
			if pos2 > 0 then
				substrg := s.substring (pos1, pos2 - 1)
				substrg2 := s.substring (pos2, pos2)
			else
				upper := abs (pos2)
				substrg := s.substring (pos1, upper)
				create substrg2.make (0)
			end
		ensure
			substrings_extracted: substrg /= Void and substrg2 /= Void
		end

	has_separators (s: STRING): BOOLEAN is
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

end -- class FIND_SEPARATOR_FACILITY

--|----------------------------------------------------------------
--| EiffelTime: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
