indexing
	description: "ComboBoxEx Style (CBES) messages."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CBES_CONSTANTS

feature -- Access

	Cbes_ex_noeditimage: INTEGER is
			-- The edit box will not display an item image.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"CBES_EX_NOEDITIMAGE"
		end

	Cbes_ex_noeditimageindent: INTEGER is
			-- The edit box will not indend text to make room
			-- for an item image.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"CBES_EX_NOEDITIMAGEINDENT"
		end

end -- class WEL_CBES_CONSTANTS

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
