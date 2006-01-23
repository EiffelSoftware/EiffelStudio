indexing
	description: "Images for default cursors (IDC) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_IDC_CONSTANTS

feature -- Access

	Idc_appstarting: POINTER is
		external
			"C [macro %"wel.h%"] : EIF_POINTER"
		alias
			"IDC_APPSTARTING"
		end

	Idc_arrow: POINTER is
		external
			"C [macro %"wel.h%"]: EIF_POINTER"
		alias
			"IDC_ARROW"
		end

	Idc_help: POINTER is
		external
			"C [macro %"wel.h%"]: EIF_POINTER"
		alias
			"IDC_HELP"
		end

	Idc_hand: POINTER is
		external
			"C [macro %"wel.h%"]: EIF_POINTER"
		alias
			"MAKEINTRESOURCE(32649)"
		end

	Idc_ibeam: POINTER is
		external
			"C [macro %"wel.h%"]: EIF_POINTER"
		alias
			"IDC_IBEAM"
		end

	Idc_no: POINTER is
		external
			"C [macro %"wel.h%"]: EIF_POINTER"
		alias
			"IDC_NO"
		end

	Idc_wait: POINTER is
		external
			"C [macro %"wel.h%"]: EIF_POINTER"
		alias
			"IDC_WAIT"
		end

	Idc_cross: POINTER is
		external
			"C [macro %"wel.h%"]: EIF_POINTER"
		alias
			"IDC_CROSS"
		end

	Idc_uparrow: POINTER is
		external
			"C [macro %"wel.h%"]: EIF_POINTER"
		alias
			"IDC_UPARROW"
		end

	Idc_sizeall: POINTER is
		external
			"C [macro %"wel.h%"]: EIF_POINTER"
		alias
			"IDC_SIZEALL"
		end

	Idc_sizenwse: POINTER is
		external
			"C [macro %"wel.h%"]: EIF_POINTER"
		alias
			"IDC_SIZENWSE"
		end

	Idc_sizenesw: POINTER is
		external
			"C [macro %"wel.h%"]: EIF_POINTER"
		alias
			"IDC_SIZENESW"
		end

	Idc_sizewe: POINTER is
		external
			"C [macro %"wel.h%"]: EIF_POINTER"
		alias
			"IDC_SIZEWE"
		end

	Idc_sizens: POINTER is
		external
			"C [macro %"wel.h%"]: EIF_POINTER"
		alias
			"IDC_SIZENS"
		end

feature -- Obsolete

	Idc_size: POINTER is obsolete "Use ``Idc_sizeall''"
		do
			Result := Idc_sizeall
		end

	Idc_icon: POINTER is obsolete "Use ``Idc_arrow''"
		do
			Result := Idc_arrow
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_IDC_CONSTANTS

