indexing

	description:
		"Bounded data structures, with a notion of capacity.";

	status: "See notice at end of class";
	names: bounded, storage;
	date: "$Date$";
	revision: "$Revision$"

deferred class BOUNDED [G] inherit

	FINITE [G]

feature -- Measurement

	capacity: INTEGER is
			-- Number of items that may be stored
		deferred
		end;

feature -- Status report

	full: BOOLEAN is
			-- Is structure full?
		do
			Result := (count = capacity)
		end;

	resizable: BOOLEAN is
			-- May `capacity' be changed?
		deferred
		end;

invariant

	valid_count: count <= capacity;
	full_definition: full = (count = capacity)

end -- class BOUNDED


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
