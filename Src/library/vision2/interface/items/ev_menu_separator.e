indexing
	description:
		"Horizontal scored line separator for use in EV_MENU."
	status: "See notice at end of class."
	keywords: "menu, item, separator"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MENU_SEPARATOR

inherit
	EV_MENU_ITEM
		export
			{NONE} all
		redefine
			implementation,
			create_implementation
		end

create
	default_create

feature {EV_ANY_I} -- Implementation

	implementation: EV_MENU_SEPARATOR_I
		-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_MENU_SEPARATOR_IMP} implementation.make (Current)
		end

end -- class EV_MENU_SEPARATOR

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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

