indexing

	description:
		"Data structures whose items may be compared %
		%according to a partial order relation";

	copyright: "See notice at end of class";
	names: comparable_struct;
	access: min, max;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class COMPARABLE_STRUCT [G -> COMPARABLE] inherit

	BILINEAR [G]

feature -- Measurement

	min: like item is
			-- Minimum element
		require
			min_max_available

		do
			from
				start;
				Result := item;
				forth
			until
				off
			loop
				if item < Result then
					Result := item
				end;
				forth
			end
		ensure
		--	is_minimum:
		--		for all elements: `Result <= element'
		end;
			
	max: like item is
			-- Maximum element
		require
			min_max_available

		do
			from
				start;
				Result := item;
				forth
			until
				off
			loop
				if item > Result then
					Result := item
				end;
				forth
			end
		ensure
		--	is_maximum:
		--		for all elements: `element <= Result'
		end;

	min_max_available: BOOLEAN is
			-- Can min and max be computed?
		do
			Result := not empty
		end;

feature {NONE} -- Inapplicable

	index: INTEGER is
		do
		end

invariant
	
	empty_constraint: min_max_available implies not empty

end -- class COMPARABLE_STRUCT


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1986, 1990, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
