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

	search_for_pattern is
			-- Search in the text to find the very next
			-- occurrence of `pattern'.
		local
			text_count, pattern_count, i: INTEGER;
			difference, pattern_index: INTEGER;
			text_area, pattern_area: SPECIAL [CHARACTER];
			table_area: SPECIAL [INTEGER]
		do
			from
				text_count := text.count;
				pattern_count := pattern.count;
				i := index;
				table_area := table.area;
				text_area := text.area;
				pattern_area := pattern.area;
				difference := text_count - pattern_count;
				pattern_index := 0
			until
				pattern_index >= pattern_count or else
				i > difference and then pattern_index = 0
			loop
				if text_area.item (i) /= pattern_area.item (pattern_index) then
debug("KMP")
	print ("Before index update statement%NInfo:%N-----%N");
	print ("i: ")
	print (i);
	print ("%Ndifference: ");
	print (difference);
	print ("%Npattern_count: ");
	print (pattern_count);
	print ("%Ntext_count: ");
	print (text_count);
	print ("%Ntext_area.item (i + pattern_count).code: ");
	print (text_area.item (i + pattern_count).code);
	print ("%Ntable_area.count: ");
	print (table_area.count);
	print ("%N")
end;
					i := i + table_area.item (text_area.item (i + pattern_count).code);
					pattern_index := 0
				else
					pattern_index := pattern_index + 1;
					i := i + 1
				end
			end;
			index := i;
			found := pattern_index >= pattern_count
		end

feature {NONE} -- Initialization

	init_arrays is
			-- Initializes the arrays for the pattern.
		local
			table_area: SPECIAL [INTEGER];
			pattern_area: SPECIAL [CHARACTER];
			i, pattern_count: INTEGER
		do
			from
				!! table.make (0, 128);
				table_area := table.area;
				pattern_area := pattern.area;
				i := 0;
				pattern_count := pattern.count
			until
				i = 128
			loop
				table_area.put (pattern_count, i);
				i := i + 1
			end;

			from
				i := 1
			until
				i = pattern_count
			loop
				table_area.put (pattern_count - i, pattern_area.item (i).code);
				i := i + 1
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
