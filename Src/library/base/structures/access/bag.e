indexing

	description:
		"Collections of items, where each item may occur zero %
		%or more times, and the number of occurrences is meaningful.";

	status: "See notice at end of class";
	names: bag, access;
	access: membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class BAG [G] inherit

	COLLECTION [G]
		redefine
			extend
		end

feature -- Measurement

	occurrences (v: G): INTEGER is
			-- Number of times `v' appears in structure
			-- (Reference or object equality,
			-- based on `object_comparison'.)
		deferred
		ensure
			non_negative_occurrences: Result >= 0
		end;

feature -- Element change

	extend (v: G) is
			-- Add a new occurrence of `v'.
		deferred
		ensure then
			one_more_occurrence: occurrences (v) = old (occurrences (v)) + 1
		end;

end -- class BAG


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
