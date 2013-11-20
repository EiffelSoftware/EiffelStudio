note
	description: "ComboBoxEx Notifications (CBEN) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CBEN_CONSTANTS

obsolete
	"Use WEL_COMBO_BOX_CONSTANTS instead."

feature -- Access

	Cben_getdispinfo: INTEGER = -807
			-- Sent to retrieve display information about a callback item.
			--
			-- Declared in Windows as CBEN_GETDISPINFO

	Cben_insertitem: INTEGER = -801
			-- Send when a new item has been inserted in the control.
			--
			-- Declared in Windows as CBEN_INSERTITEM

	Cben_deleteitem: INTEGER = -802
			-- Sent when an item has been deleted.
			--
			-- Declared in Windows as CBEN_DELETEITEM

	Cben_beginedit: INTEGER = -804
			-- Sent when the user activates the drop-down list in the
			-- control's edit box.
			--
			-- Declared in Windows as CBEN_BEGINEDIT

	Cben_endedit: INTEGER = -806
			-- Sent when the user has concluded an operation within
			-- the edit box or has selected an item from the control's
			-- drop-down list.
			--
			-- Declared in Windows as CBEN_ENDEDIT

feature -- Access : notification flags

	Cbenf_dropdown: INTEGER = 4
			-- The user activated the drop-down list.
			--
			-- Declared in Windows as CBENF_DROPDOWN

	Cbenf_escape: INTEGER = 3
			-- The user pressed the ESCAPE key.
			--
			-- Declared in Windows as CBENF_ESCAPE

	Cbenf_killfocus: INTEGER = 1
			-- The edit box lost the keyboard focus.
			--
			-- Declared in Windows as CBENF_KILLFOCUS

	Cbenf_return: INTEGER = 2;
			-- The user completed the edit operation by pressing
			-- the ENTER key.
			--
			-- Declared in Windows as CBENF_RETURN

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_CBEN_CONSTANTS

