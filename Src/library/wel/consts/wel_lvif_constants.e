indexing
	description	: "List view item flag (LVIF) constants."
	status		: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_LVIF_CONSTANTS

obsolete
	"use WEL_LIST_VIEW_CONSTANTS instead"

feature -- Access

	Lvif_text: INTEGER is 1
			-- The pszText member is valid.
			--
			-- Declared in Windows as LVIF_TEXT

	Lvif_image: INTEGER is 2
			-- The iImage member is valid.
			--
			-- Declared in Windows as LVIF_IMAGE

	Lvif_param: INTEGER is 4
			-- The lParam member is valid.
			--
			-- Declared in Windows as LVIF_PARAM

	Lvif_state: INTEGER is 8
			-- The state member is valid
			--
			-- Declared in Windows as LVIF_STATE

end -- class WEL_LVIF_CONSTANTS

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

