indexing

	description:
		"Sets whose elements may be compared according to a total order relation";

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
			-- Minimum element
		require
			not_empty: not empty
		do
			Result := cs_min
		ensure
		--	is_minimum:
				-- for all elements: `Result <= element'
		end;

	max: G is
			-- Maximum element
		require
			not_empty: not empty
		do
			Result := cs_max
		ensure
		--	is_maximum:
				-- for all elements: `element <= Result'
		end;

end -- class COMPARABLE_SET


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
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
