indexing

	description:
		"Finite structures whose item count is not bounded";

	status: "See notice at end of class";
	names: unbounded, storage;
	date: "$Date$";
	revision: "$Revision$"

deferred class UNBOUNDED [G] inherit

	FINITE [G]

feature -- Status report

	--extendible: BOOLEAN is true;
		-- Can new items be added? (Answer: yes)

-- invariant

	-- extendible: extendible

end -- class UNBOUNDED


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

