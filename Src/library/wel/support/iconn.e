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

creation
	make

feature -- Initialization

	make is
			-- Make a null icon.
		do
			exists := True
		ensure
			exists: exists
		end

feature -- Status report

	exists: BOOLEAN
			-- Does the `item' exist?

feature {NONE} -- Removal

	destroy_item is
			-- `item' does not need to be garbage collected.
		do
			exists := False
		end

invariant
	no_item: item = default_pointer

end -- class WEL_NULL_ICON

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
