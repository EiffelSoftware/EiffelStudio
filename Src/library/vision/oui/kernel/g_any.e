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
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

