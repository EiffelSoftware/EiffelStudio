indexing
	description: "GetWindowLong (GWL) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GWL_CONSTANTS

feature -- Access

	Gwl_exstyle: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"GWL_EXSTYLE"
		end

	Gwl_style: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"GWL_STYLE"
		end

	Gwl_wndproc: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"GWL_WNDPROC"
		end

	Gwl_hinstance: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"GWL_HINSTANCE"
		end

	Gwl_hwndparent: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"GWL_HWNDPARENT"
		end

	Gwl_id: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"GWL_ID"
		end

	Gwl_userdata: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"GWL_USERDATA"
		end

	Dwl_dlgproc: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"DWL_DLGPROC"
		end

	Dwl_msgresult: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"DWL_MSGRESULT"
		end

	Dwl_user: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"DWL_USER"
		end

end -- class WEL_GWL_CONSTANTS

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

