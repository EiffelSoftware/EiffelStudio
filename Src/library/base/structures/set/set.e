
indexing

	description:
		"Sets, without commitment to a particular representation";

	copyright: "See notice at end of class";
	names: set;
	access: membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class SET [G] inherit

	UNIQUE_COLLECTION [G]

feature -- Basic operations

	intersect (other: like Current) is
			-- Remove all items not in `other'.
		require
			set_exists: other /= Void
			same_rule: object_comparison = other.object_comparison
		deferred
		end

	subtract (other: like Current) is
			-- Remove all items also in `other'
		require
			set_exists: other /= Void
			same_rule: object_comparison = other.object_comparison
		deferred
		end

end -- class SET


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
