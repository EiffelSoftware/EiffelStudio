indexing
	description: "Tab control item flag (TCIF) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TCIF_CONSTANTS

feature -- Access

	Tcif_text: INTEGER is
			-- The pszText member is valid.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TCIF_TEXT"
		end

	Tcif_image: INTEGER is
			-- The iImage member is valid.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TCIF_IMAGE"
		end

	Tcif_rtlreading: INTEGER is
			-- Windows 95 only: Displays the text of pszText
			-- using right-to-left reading order on Hebrew or
			-- Arabic systems.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TCIF_RTLREADING"
		end

	Tcif_param: INTEGER is
			-- The lParam member is valid.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TCIF_PARAM"
		end

	Tcif_state: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TCIF_STATE"
		end

end -- class WEL_TCIF_CONSTANTS

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

