indexing
	description: "Tab control item flag (TCIF) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TCIF_CONSTANTS

feature -- Access

	Tcif_text: INTEGER is 1
			-- The pszText member is valid.
			--
			-- Declared in Windows as TCIF_TEXT

	Tcif_image: INTEGER is 2
			-- The iImage member is valid.
			--
			-- Declared in Windows as TCIF_IMAGE

	Tcif_rtlreading: INTEGER is 4
			-- Windows 95 only: Displays the text of pszText
			-- using right-to-left reading order on Hebrew or
			-- Arabic systems.
			--
			-- Declared in Windows as TCIF_RTLREADING

	Tcif_param: INTEGER is 8
			-- The lParam member is valid.
			--
			-- Declared in Windows as TCIF_PARAM

	Tcif_state: INTEGER is 16
			-- Declared in Windows as TCIF_STATE

end -- class WEL_TCIF_CONSTANTS

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

