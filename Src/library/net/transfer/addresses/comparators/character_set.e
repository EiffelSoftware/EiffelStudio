indexing
	description:
		"Comparator for character sets"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"
	usage: "The features 'define', 'add' and 'remove' accept a string as%
		   %argument that represents a set of single character (like 'a')%
		   %or character ranges (like 'a-z'). To use a character with a%
		   %special meaning (like '-') as single character, it can be quoted%
		   %using the character '\'"

class CHARACTER_SET inherit
	
	TO_SPECIAL [BOOLEAN]
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create is
			-- Initialize `Current'.
		do
			make_area (feature {CHARACTER}.Max_value + 1)
		end

feature -- Access

	contains_string (s: STRING): BOOLEAN is
			-- Does character set contain string `s'?
		require
			not_empty: not is_empty
			string_exists: s /= Void
		local
			i, cnt: INTEGER
			str: SPECIAL [CHARACTER]
		do
			from
				str := s.area
				cnt := s.count
				Result := True
			until
				i = cnt or not Result
			loop
				Result := area.item (str.item (i).code)
				i := i + 1
			end
		end

	contains_character (c: CHARACTER): BOOLEAN is
			-- Does character set contain character `c'?
		require
			not_empty: not is_empty
		do
			Result := area.item (c.code)
		end

feature -- Status report

	is_empty: BOOLEAN is
			-- Is character set empty?
		local
			i, cnt: INTEGER
		do
			from
				cnt := area.count
			until
				i = cnt or Result
			loop
				Result := area.item (i)
				i := i + 1
			end
			Result := not Result
		end
		
feature -- Status setting

	define (s: STRING) is
			-- Define character set.
		require
			string_exists: s /= Void
			not_open_set: (s.item (1) /= '-') and (s.item (s.count) /= '-')
		local
			i, cnt: INTEGER
		do
				-- First reinitialize the set to an empty set.
			from
				cnt := area.count
			until
				i = cnt
			loop
				area.put (False, i)
				i := i + 1
			end
			if not s.is_empty then
				process_string (s, True)
			end
		end

feature -- Element change

	add (s: STRING) is
			-- Add `s' to character set.
		require
			non_empty_string: s /= Void and then not s.is_empty
			not_open_set: (s.item (1) /= '-') and (s.item (s.count) /= '-')
		do
			process_string (s, True)
		end
		
feature -- Removal

	remove (s: STRING) is
			-- Remove `s' from character set.
		require
			non_empty_string: s /= Void and then not s.is_empty
			not_open_set: (s.item (1) /= '-') and (s.item (s.count) /= '-')
		do
			process_string (s, False)
		end
		
feature {NONE} -- Implementation

	process_string (s: STRING; for_addition: BOOLEAN) is
			-- Add or remove (depending on `for_addition') the characters that `s' defines to/from the set.
		require
			valid_string: s /= Void and not s.is_empty
			not_open_set: (s.item (1) /= '-') and (s.item (s.count) /= '-')
		local
			escape: BOOLEAN
			lastc, curc: CHARACTER
			i, cnt: INTEGER
		do
			from
				i := 1
				lastc := s.item (i)
				escape := lastc = '\'
				cnt := s.count
			until
				i = cnt
			loop
				i := i + 1
				curc := s.item (i)
				if escape then
					escape := False
				else
					if curc = '-' then
						i := i + 1
						curc := s.item (i)
						set_characters (lastc, curc, for_addition)
					elseif curc = '\' then
						area.put (for_addition, lastc.code)
						escape := True
					else
						area.put (for_addition, lastc.code)
					end
				end
				lastc := curc
			end
			if not escape then
				area.put (for_addition, lastc.code)
			end
		end

	set_characters (c1, c2: CHARACTER; for_addition: BOOLEAN) is
			-- Set or unset (depending on `for_addition') the characters
			-- between `c1' and `c2' to the set (bounds included).
			-- Do nothing if c2 is before c1.
		local
			i1, i2: INTEGER
		do
			from
				i1 := c1.code
				i2 := c2.code
			until
				i1 > i2
			loop
				area.put (for_addition, i1)
				i1 := i1 + 1
			end
		ensure
			bounds_set: (c1.code >= c2.code) implies ((area.item (c1.code) = for_addition) and
														(area.item (c2.code) = for_addition))
		end

end -- class CHARACTER_SET


--|----------------------------------------------------------------
--| EiffelNet: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

