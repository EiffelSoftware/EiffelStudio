indexing
	description	: "ComboBoxEx Notifications (CBEN) constants."
	status		: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_CBEN_CONSTANTS

feature -- Access

	Cben_getdispinfo: INTEGER is -800
			-- Sent to retrieve display information about a callback item. 
			--
			-- Declared in Windows as CBEN_GETDISPINFO

	Cben_insertitem: INTEGER is -801
			-- Send when a new item has been inserted in the control.
			--
			-- Declared in Windows as CBEN_INSERTITEM

	Cben_deleteitem: INTEGER is -802
			-- Sent when an item has been deleted.
			--
			-- Declared in Windows as CBEN_DELETEITEM

	Cben_beginedit: INTEGER is -804
			-- Sent when the user activates the drop-down list in the
			-- control's edit box.
			--
			-- Declared in Windows as CBEN_BEGINEDIT

	Cben_endedit: INTEGER is -805
			-- Sent when the user has concluded an operation within
			-- the edit box or has selected an item from the control's
			-- drop-down list.
			--
			-- Declared in Windows as CBEN_ENDEDIT

feature -- Access : notification flags

	Cbenf_dropdown: INTEGER is 4
			-- The user activated the drop-down list.
			--
			-- Declared in Windows as CBENF_DROPDOWN

	Cbenf_escape: INTEGER is 3
			-- The user pressed the ESCAPE key.
			--
			-- Declared in Windows as CBENF_ESCAPE

	Cbenf_killfocus: INTEGER is 1
			-- The edit box lost the keyboard focus.
			--
			-- Declared in Windows as CBENF_KILLFOCUS

	Cbenf_return: INTEGER is 2
			-- The user completed the edit operation by pressing
			-- the ENTER key.
			--
			-- Declared in Windows as CBENF_RETURN

end -- class WEL_CBEN_CONSTANTS


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

