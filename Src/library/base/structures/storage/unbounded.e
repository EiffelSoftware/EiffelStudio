indexing

	description:
		"Finite structures whose item count is not bounded";

	copyright: "See notice at end of class";
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
