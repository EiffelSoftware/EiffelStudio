indexing

	description:	"Pattern matcher through the Knuth Morris %
			%Pratt algorithm.";
	status:		"See notice at end of class";
	date:		"$Date$";
	revision:	"$Revision$"
	
class KMP_MATCHER 

inherit
	MATCHER

creation
	make, make_empty

feature -- Status setting

	set_pattern (new_pattern: STRING) is
			-- Set `pattern' to new `pattern'.
		do
			pattern := new_pattern;
			init_arrays
		end;

feature -- Search

	search_for_pattern: BOOLEAN is
			-- Search in the text to find the very next
			-- occurrence of `pattern'.
		local
			text_count, pattern_count, i: INTEGER;
			difference, pattern_index: INTEGER;
			text_area, pattern_area: SPECIAL [CHARACTER];
			table_area: SPECIAL [INTEGER]
			j: INTEGER

		do
			from
				pattern_area := pattern.area
				pattern_count := pattern.count - 1
				table_area := table.area
				text_area := text.area
				text_count := text.count
				i := index
				j := 0
				if text_count = 0 then
					index := 0
					found := true
				else
					found := false
				end
			until
				found or else i > text_count
			loop
				if (j = -1) or else (pattern_area.item (j) = text_area.item (i)) then
					i := i + 1
					j := j + 1
					if j > pattern_count then
						index := i
						found := true
					end
				else
					j := table_area.item (j)
				end
			end
			Result := found
		end

feature {NONE} -- Initialization

	init_arrays is
			-- Initializes the arrays for the pattern.
		local
			table_area: SPECIAL [INTEGER];
			pattern_area: SPECIAL [CHARACTER];
			i, pattern_count: INTEGER
			l,k: INTEGER

		do
			from 
				pattern_area := pattern.area
				pattern_count := pattern.count
				!! table.make (0, pattern_count)
				table_area := table.area
				l := 0
				k := -1
				table_area.put (-1, 0)
			until
				l > pattern_count

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

	table: ARRAY [INTEGER]

end -- class KMP_MATCHER

--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1986, 1990, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
