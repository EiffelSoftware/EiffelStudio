indexing
	description: "Images for default cursors (IDC) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_IDC_CONSTANTS

feature -- Access

	Idc_appstarting: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"IDC_APPSTARTING"
		end

	Idc_arrow: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"IDC_ARROW"
		end

	Idc_help: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"IDC_HELP"
		end

	Idc_ibeam: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"IDC_IBEAM"
		end

	Idc_no: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"IDC_NO"
		end

	Idc_wait: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"IDC_WAIT"
		end

	Idc_cross: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"IDC_CROSS"
		end

	Idc_uparrow: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"IDC_UPARROW"
		end

	Idc_sizeall: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"IDC_SIZEALL"
		end

	Idc_sizenwse: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"IDC_SIZENWSE"
		end

	Idc_sizenesw: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"IDC_SIZENESW"
		end

	Idc_sizewe: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"IDC_SIZEWE"
		end

	Idc_sizens: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"IDC_SIZENS"
		end

feature -- Obsolete

	Idc_size: INTEGER is obsolete "Use ``Idc_sizeall''"
		do
			Result := Idc_sizeall
		end

	Idc_icon: INTEGER is obsolete "Use ``Idc_arrow''"
		do
			Result := Idc_arrow
		end

end -- class WEL_IDC_CONSTANTS

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

