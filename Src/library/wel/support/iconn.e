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

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1997, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
