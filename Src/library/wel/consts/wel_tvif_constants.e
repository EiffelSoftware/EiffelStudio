indexing
	description: "Tree view item flag (TVIF) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TVIF_CONSTANTS

feature -- Access

	Tvif_children: INTEGER is 64
			-- The cChildren member is valid.
			--
			-- Declared in Windows as TVIF_CHILDREN

	Tvif_image: INTEGER is 2
			-- The iImage member is valid.
			--
			-- Declared in Windows as TVIF_IMAGE

	Tvif_param: INTEGER is 4
			-- The lParam member is valid.
			--
			-- Declared in Windows as TVIF_PARAM

	Tvif_selectedimage: INTEGER is 32
			-- The iSelectedImage member is valid.
			--
			-- Declared in Windows as TVIF_SELECTEDIMAGE

	Tvif_state: INTEGER is 8
			-- The state and stateMask members are valid.
			--
			-- Declared in Windows as TVIF_STATE

	Tvif_text: INTEGER is 1
			-- The pszText and cchTextMax members are valid.
			--
			-- Declared in Windows as TVIF_TEXT

	Tvif_handle: INTEGER is 16
			-- The hitem member is valid.
			--
			-- Declared in Windows as TVIF_HANDLE

end -- class WEL_TVIF_CONSTANTS


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

