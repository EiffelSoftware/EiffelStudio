indexing
	description: "Special icon used for creating a WEL_WND_CLASS%
		% structure when an application must explicitly draw an icon%
		% whenever the user minimizes the window."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_NULL_ICON

inherit
	WEL_ICON
		redefine
			exists,
			destroy_item
		end

feature -- Status report

	exists: BOOLEAN is True
			-- A null icon always exists.

feature {NONE} -- Removal

	destroy_item is
			-- Nothing to destroy.
		do
		end

invariant
	exists: exists
	no_item: item = default_pointer

end -- class WEL_NULL_ICON

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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

