indexing
	description: "ComboBoxEx Notifications (CBEN) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CBEN_CONSTANTS

feature -- Access

	Cben_getdispinfo: INTEGER is
			-- Sent to retrieve display information about a callback item. 
		external
			"C [macro %"cctrl.h%"]"
		alias
			"CBEN_GETDISPINFO"	
		end

	Cben_insertitem: INTEGER is
			-- Send when a new item has been inserted in the control.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"CBEN_INSERTITEM"
		end

	Cben_deleteitem: INTEGER is
			-- Sent when an item has been deleted.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"CBEN_DELETEITEM"
		end

	Cben_beginedit: INTEGER is
			-- Sent when the user activates the drop-down list in the
			-- control's edit box.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"CBEN_BEGINEDIT"
		end

	Cben_endedit: INTEGER is
			-- Sent when the user has concluded an operation within
			-- the edit box or has selected an item from the control's
			-- drop-down list.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"CBEN_ENDEDIT"
		end

feature -- Access : notification flags

	Cbenf_dropdown: INTEGER is
			-- The user activated the drop-down list.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"CBENF_DROPDOWN"
		end

	Cbenf_escape: INTEGER is
			-- The user pressed the ESCAPE key.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"CBENF_ESCAPE"
		end

	Cbenf_killfocus: INTEGER is
			-- The edit box lost the keyboard focus.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"CBENF_KILLFOCUS"
		end

	Cbenf_return: INTEGER is
			-- The user completed the edit operation by pressing
			-- the ENTER key.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"CBENF_RETURN"
		end

end -- class WEL_CBEN_CONSTANTS

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
