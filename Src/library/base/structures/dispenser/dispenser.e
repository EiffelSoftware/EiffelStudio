indexing

	description:
			"Dispensers: containers for which clients have no say %
			%as to what item they can access at a given time. %
			%Examples include stacks and queues."

	status: "See notice at end of class";
	names: dispenser, active;
	access: fixed, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class DISPENSER [G] inherit

	ACTIVE [G];

	FINITE [G]

feature -- Status report

	readable: BOOLEAN is
			-- Is there a current item that may be read?
		do
			Result := not empty
		end;

	writable: BOOLEAN is
			-- Is there a current item that may be modified?
		do
			Result := not empty
		end;

feature -- Element change

	append (s: SEQUENCE [G]) is
			-- Append a copy of `s'.
			-- (Synonym for `fill')
		do
			fill (s)
		end;

	extend, force, put (v: like item) is
			-- Add item `v'.
		deferred
		end;

invariant

	readable_definition: readable = not empty;
	writable_definition: writable = not empty;

end -- class DISPENSER


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
