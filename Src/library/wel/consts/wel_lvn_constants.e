indexing
	description: "List view selection type constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_LVN_CONSTANTS

feature -- Access

	Lvn_begindrag: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVN_BEGINDRAG"
		end

	Lvn_beginlabeledit: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVN_BEGINLABELEDIT"
		end

	Lvn_beginrdrag: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVN_BEGINRDRAG"
		end

	Lvn_columnclick: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVN_COLUMNCLICK"
		end

	Lvn_deleteallitems: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVN_DELETEALLITEMS"
		end

	Lvn_deleteitem: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVN_DELETEITEM"
		end

	Lvn_endlabeledit: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVN_ENDLABELEDIT"
		end

	Lvn_getdispinfo: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVN_GETDISPINFO"
		end

	Lvn_insertitem: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVN_INSERTITEM"
		end

	Lvn_itemchanged: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVN_ITEMCHANGED"
		end

	Lvn_itemchanging: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVN_ITEMCHANGING"
		end

	Lvn_keydown: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVN_KEYDOWN"
		end

	Lvn_setdispinfo: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVN_SETDISPINFO"
		end

end -- class WEL_LVN_CONSTANTS

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
