indexing

	description:
		"Sets whose items may be compared according to a total order relation";

	status: "See notice at end of class";
	names: comparable_set, comparable_struct;
	access: membership, min, max;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class COMPARABLE_SET [G -> COMPARABLE] inherit

	SUBSET [G];

	COMPARABLE_STRUCT [G]
		rename
			min as cs_min,
			max as cs_max
		export
			{NONE}
				all
		undefine
			changeable_comparison_criterion
		end

feature -- Measurement

	min: G is
			-- Minimum item
		require
			not_empty: not empty
		do
			Result := cs_min
		ensure
			-- smallest: For every item `it' in set, `Result' <= `it'
		end;

	max: G is
			-- Maximum item
		require
			not_empty: not empty
		do
			Result := cs_max
		ensure
			-- largest: For every item `it' in set, `element' <= `it'
		end;

end -- class COMPARABLE_SET


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1997 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
