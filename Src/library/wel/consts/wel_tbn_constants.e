indexing
	description: "Toolbar notification (RBN) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TBN_CONSTANTS

feature -- Access

	Tbn_getbuttoninfo: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TBN_GETBUTTONINFO"
		end

	Tbn_begindrag: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TBN_BEGINDRAG"
		end

	Tbn_enddrag: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TBN_ENDDRAG"
		end

	Tbn_beginadjust: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TBN_BEGINADJUST"
		end

	Tbn_endadjust: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TBN_ENDADJUST"
		end

	Tbn_reset: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TBN_RESET"
		end

	Tbn_queryinsert: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TBN_QUERYINSERT"
		end

	Tbn_querydelete: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TBN_QUERYDELETE"
		end

	Tbn_toolbarchange: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TBN_TOOLBARCHANGE"
		end

	Tbn_custhelp: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TBN_CUSTHELP"
		end

	Tbn_dropdown: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TBN_DROPDOWN"
		end

	Tbn_closeup: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TBN_CLOSEUP"
		end

end -- class WEL_TBN_CONSTANTS

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
