indexing
	description: "Window constants for WM_MENUCHAR message."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_MNC_CONSTANTS

feature -- Access

	Mnc_ignore: INTEGER is 0
			-- Informs the system that it should discard the character the user
			-- pressed and create a short beep on the system speaker. 
			--
			-- Declared in Windows as MNC_IGNORE

	Mnc_close: INTEGER is 1
			-- Informs the system that it should close the active menu.
			--
			-- Declared in Windows as MNC_CLOSE

	Mnc_execute: INTEGER is 2
			-- Informs the system that it should choose the item specified in
			-- the low-order word of the return value. The owner window
			-- receives a WM_COMMAND message. 
			--
			-- Declared in Windows as MNC_EXECUTE

	Mnc_select: INTEGER is 3
			-- Informs the system that it should select the item specified in
			-- the low-order word of the return value.  
			--
			-- Declared in Windows as MNC_SELECT
	
end -- class WEL_MNC_CONSTANTS

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

