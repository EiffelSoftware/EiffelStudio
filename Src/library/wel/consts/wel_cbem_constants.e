indexing
	description	: "ComboBoxEx Message (CBEM) constants."
	status		: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_CBEM_CONSTANTS

feature -- Access

	Cbem_insertitem: INTEGER is 1025
			-- Inserts a new item in a ComboBoxEx.
			--
			-- Declared in Windows as CBEM_INSERTITEM

	Cbem_setimagelist: INTEGER is 1026
			-- Sets an image list for a ComboBoxEx control.
			--
			-- Declared in Windows as CBEM_SETIMAGELIST

	Cbem_getimagelist: INTEGER is 1027
			-- Retrieves the handle to an image list assigned
			-- to a ComboBoxEx control.
			--
			-- Declared in Windows as CBEM_GETIMAGELIST

	Cbem_getitem: INTEGER is 1028
			-- Retrieves item information for a given ComboBoxEx item.
			--
			-- Declared in Windows as CBEM_GETITEM

	Cbem_setitem: INTEGER is 1029
			-- Sets the attributes for an item in a ComboBoxEx control.
			--
			-- Declared in Windows as CBEM_SETITEM

	Cbem_deleteitem: INTEGER is 324
			-- Removes an item from a ComboBoxEx control.
			--
			-- Declared in Windows as CBEM_DELETEITEM

	Cbem_getcombocontrol: INTEGER is 1030
			-- Retrieves the handle to the child combo box control.
			--
			-- Declared in Windows as CBEM_GETCOMBOCONTROL

	Cbem_geteditcontrol: INTEGER is 1031
			-- Retrieves the handke to the edit control portion of
			-- a ComboBoxEc control.
			--
			-- Declared in Windows as CBEM_GETEDITCONTROL

	Cbem_setexstyle: INTEGER is 1032
			-- Sets extended styles within a ComboBoxEx control.
			--
			-- Declared in Windows as CBEM_SETEXSTYLE

	Cbem_getexstyle: INTEGER is 1033
			-- Retrieves the extended styles of a ComboBoxEx control.
			--
			-- Declared in Windows as CBEM_GETEXSTYLE

	Cbem_haseditchanged: INTEGER is 1034
			-- Determines if the user has changed the contents of the
			-- ComboBoxEx edit control by typing.
			--
			-- Declared in Windows as CBEM_HASEDITCHANGED

end -- class WEL_CBEM_CONSTANTS


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

