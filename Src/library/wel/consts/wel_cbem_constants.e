indexing
	description: "ComboBoxEx Message (CBEM) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CBEM_CONSTANTS

feature -- Access

	Cbem_insertitem: INTEGER is
			-- Inserts a new item in a ComboBoxEx.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"CBEM_INSERTITEM"
		end

	Cbem_setimagelist: INTEGER is
			-- Sets an image list for a ComboBoxEx control.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"CBEM_SETIMAGELIST"
		end

	Cbem_getimagelist: INTEGER is
			-- Retrieves the handle to an image list assigned
			-- to a ComboBoxEx control.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"CBEM_GETIMAGELIST"
		end

	Cbem_getitem: INTEGER is
			-- Retrieves item information for a given ComboBoxEx item.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"CBEM_GETITEM"
		end

	Cbem_setitem: INTEGER is
			-- Sets the attributes for an item in a ComboBoxEx control.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"CBEM_SETITEM"
		end

	Cbem_deleteitem: INTEGER is
			-- Removes an item from a ComboBoxEx control.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"CBEM_DELETEITEM"
		end

	Cbem_getcombocontrol: INTEGER is
			-- Retrieves the handle to the child combo box control.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"CBEM_GETCOMBOCONTROL"
		end

	Cbem_geteditcontrol: INTEGER is
			-- Retrieves the handke to the edit control portion of
			-- a ComboBoxEc control.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"CBEM_GETEDITCONTROL"
		end

	Cbem_setexstyle: INTEGER is
			-- Sets extended styles within a ComboBoxEx control.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"CBEM_SETEXSTYLE"
		end

	Cbem_getexstyle: INTEGER is
			-- Retrieves the extended styles of a ComboBoxEx control.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"CBEM_GETEXSTYLE"
		end

	Cbem_haseditchanged: INTEGER is
			-- Determines if the user has changed the contents of the
			-- ComboBoxEx edit control by typing.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"CBEM_HASEDITCHANGED"
		end

end -- class WEL_CBEM_CONSTANTS

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
