indexing
	description: "Menu Flags (MF) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_MF_CONSTANTS

feature -- Access

	Mf_insert: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MF_INSERT"
		end

	Mf_change: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MF_CHANGE"
		end

	Mf_append: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MF_APPEND"
		end

	Mf_delete: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MF_DELETE"
		end

	Mf_remove: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MF_REMOVE"
		end

	Mf_bycommand: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MF_BYCOMMAND"
		end

	Mf_byposition: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MF_BYPOSITION"
		end

	Mf_separator: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MF_SEPARATOR"
		end

	Mf_enabled: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MF_ENABLED"
		end

	Mf_grayed: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MF_GRAYED"
		end

	Mf_disabled: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MF_DISABLED"
		end

	Mf_unchecked: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MF_UNCHECKED"
		end

	Mf_checked: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MF_CHECKED"
		end

	Mf_usecheckbitmaps: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MF_USECHECKBITMAPS"
		end

	Mf_string: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MF_STRING"
		end

	Mf_bitmap: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MF_BITMAP"
		end

	Mf_ownerdraw: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MF_OWNERDRAW"
		end

	Mf_popup: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MF_POPUP"
		end

	Mf_menubarbreak: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MF_MENUBARBREAK"
		end

	Mf_menubreak: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MF_MENUBREAK"
		end

	Mf_unhilite: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MF_UNHILITE"
		end

	Mf_hilite: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MF_HILITE"
		end

	Mf_sysmenu: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MF_SYSMENU"
		end

	Mf_help: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MF_HELP"
		end

	Mf_mouseselect: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MF_MOUSESELECT"
		end

	Mf_end: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MF_END"
		end

end -- class WEL_MF_CONSTANTS

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

