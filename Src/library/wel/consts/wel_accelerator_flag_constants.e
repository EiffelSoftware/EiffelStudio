indexing
	description	: "Constants for defining accelerator keys %
				  %in WEL_ACCELERATOR."
	status		: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_ACCELERATOR_FLAG_CONSTANTS

feature -- Access

	Fcontrol: INTEGER is 8
			-- The CTRL key must be held down when the accelerator
			-- key is pressed.
			--
			-- Declared in Windows as FCONTROL

	Fnoinvert: INTEGER is 2
			-- Specifies that no top-level menu item is highlighted
			-- when the accelerator is used. If this flag is not
			-- specified, a top-level menu item will be
			-- highlighted, if possible, when the accelerator is
			-- used.
			--
			-- Declared in Windows as FNOINVERT

	Fshift: INTEGER is 4
			-- The SHIFT key must be held down when the accelerator
			-- key is pressed.
			--
			-- Declared in Windows as FSHIFT

	Fvirtkey: INTEGER is 1
			-- The key member specifies a virtual-key code. If this
			-- flag is not specified, key is assumed to specify an
			-- ASCII character code.
			--
			-- Declared in Windows as FVIRTKEY

	Falt: INTEGER is 16
			-- The ALT key must be held down when the accelerator
			-- key is pressed.
			--
			-- Declared in Windows as FALT

end -- class WEL_ACCELERATOR_FLAG_CONSTANTS


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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

