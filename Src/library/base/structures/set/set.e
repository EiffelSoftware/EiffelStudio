
indexing

	description:
		"Collection, where each element must be unique.";

	status: "See notice at end of class";
	names: set;
	access: membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class SET [G] inherit

	COLLECTION [G]
		redefine
			changeable_comparison_criterion
		end

feature -- Measurement

	count: INTEGER is
		-- Number of items
		deferred
		end

feature -- Element change

	extend, put (v: G) is
			-- Ensure that set includes `v'.
		deferred
		ensure then
			in_set_already: old has (v) implies (count = old count);
			added_to_set: not old has (v) implies (count = old count + 1)
		end;

feature -- Removal

	prune (v: G) is
			-- Remove `v' if present.
		deferred
		ensure then
			removed_count_change: old has (v) implies (count = old count - 1);
			not_removed_no_count_change: not old has (v) implies (count = old count);
			item_deleted: not has (v)
		end;

	changeable_comparison_criterion: BOOLEAN is
			-- May `object_comparison' be changed?
			-- (Answer: only if set empty; otherwise insertions might
			-- introduce duplicates, destroying the set property.)
		do
			Result := empty
		ensure then
			only_on_empty: Result = empty
		end

end -- class SET


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
