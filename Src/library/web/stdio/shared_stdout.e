indexing

	description:
		"Shared standard output";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	SHARED_STDOUT

feature -- Access

	stdout: STDOUT is
			-- Shared standard output (stdout).
		once
			!! Result.make
		end

end -- class SHARED_STDOUT

--|----------------------------------------------------------------
--| EiffelWeb: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1996, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|---------------------------------------------------------------

