indexing

	description:
		"Containers whose items are accessible through keys";

	status: "See notice at end of class";
	names: table, access;
	access: key, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class TABLE [G, H] inherit

	BAG [G]
		rename
			put as bag_put
		end;

feature -- Access

	item, infix "@" (k: H): G is
			-- Entry of key `k'.
		require
			valid_key: valid_key (k)
		deferred
		end;

feature -- Status report

	valid_key (k: H): BOOLEAN is
			-- Is `k' a valid key?
		deferred
		end;

feature -- Element change

	put (v: G; k: H) is
			-- Associate value `v' with key `k'.
		require
			valid_key: valid_key (k)
		deferred
		end;

feature {NONE} -- Inapplicable

	bag_put (v: G) is
		do
		end

end -- class TABLE


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

