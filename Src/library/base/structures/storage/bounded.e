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
--| EiffelBase: Library of reusable components for Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering (ISE).
--| For ISE customers the original versions are an ISE product
--| covered by the ISE Eiffel license and support agreements.
--| EiffelBase may now be used by anyone as FREE SOFTWARE to
--| develop any product, public-domain or commercial, without
--| payment to ISE, under the terms of the ISE Free Eiffel Library
--| License (IFELL) at http://eiffel.com/products/base/license.html.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------

