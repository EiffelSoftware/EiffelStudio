indexing
	description	: "Combo-Box-Ex Item Flag (CBEIF) constants."
	status		: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_CBEIF_CONSTANTS

feature -- Access

	Cbeif_text: INTEGER is 1
			-- The `text' member is valid or must be filled in.
			--
			-- Declared in Windows as CBEIF_TEXT

	Cbeif_image: INTEGER is 2
			-- The `image' member is valid or must be filled in.
			--
			-- Declared in Windows as CBEIF_IMAGE

	Cbeif_selectedimage: INTEGER is 4
			-- The `selected_image' member is valid or must be
			-- filled in.
			--
			-- Declared in Windows as CBEIF_SELECTEDIMAGE

	Cbeif_overlay: INTEGER is 8
			-- The `overlay' member is valid or must be filled in.
			--
			-- Declared in Windows as CBEIF_OVERLAY

	Cbeif_indent: INTEGER is 16
			-- The `indent' member is valid or must be filled in.
			--
			-- Declared in Windows as CBEIF_INDENT

	Cbeif_di_setitem: INTEGER is 268435456
			-- The control should store the item data and not ask
			-- for it again. This flag is used only with the
			-- CBEN_GETDISPINFO notification message.
			--
			-- Declared in Windows as CBEIF_DI_SETITEM

	Cbeif_lparam: INTEGER is 32
			-- The `lparam' member is valid or must be filled in.
			--
			-- Declared in Windows as CBEIF_LPARAM

end -- class WEL_CBEIF_CONSTANTS


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

