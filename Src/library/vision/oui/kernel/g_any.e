indexing

	description: "Parent of any oui graphic class";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	G_ANY

feature {NONE} -- Initialization

	init_toolkit: like toolkit is
			-- Init toolkit to desired implementation.
		do
		end;

feature -- Access

	toolkit: TOOLKIT is
			-- Toolkit of implementation in the environment desired
		once
			Result := init_toolkit
		ensure
			toolkit_exists: Result /= Void
		end 

end -- G_ANY

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------

