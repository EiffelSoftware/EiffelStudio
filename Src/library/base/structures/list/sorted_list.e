indexing

	description:
		"Sequential lists where the cells are sorted in ascending order %
		%according to the relational operators of PART_COMPARABLE";

	status: "See notice at end of class";
	names: sorted_list, sorted_struct, sequence;
	access: index, cursor, membership, min, max;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class SORTED_LIST [G -> COMPARABLE] inherit

	PART_SORTED_LIST [G]

feature -- Measurement

	min: like item is
			-- Minimum item
		require
			not_empty: not empty
		do
			Result := first
		ensure
			min_is_first: Result = first;
			-- smallest: For every item `it' in list, `Result' <= `it'
		end;

	max: like item is
			-- Maximum item
		require
			not_empty: not empty
		do
			Result := last
		ensure
			max_is_last: Result = last;
			-- largest: For every item `it' in list, `it' <= `Result'
		end;

	median: like item is
			-- Median item
		require
			not_empty: not empty
		do
			Result := i_th ((count + 1) // 2)
		ensure
			median_definition: Result = i_th ((count + 1) // 2)
		end;


end -- class SORTED_LIST


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
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

