note
	description: "Images for default cursors (IDC) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_IDC_CONSTANTS

feature -- Access

	Idc_appstarting: POINTER
		external
			"C [macro %"wel.h%"] : EIF_POINTER"
		alias
			"IDC_APPSTARTING"
		end

	Idc_arrow: POINTER
		external
			"C [macro %"wel.h%"]: EIF_POINTER"
		alias
			"IDC_ARROW"
		end

	Idc_help: POINTER
		external
			"C [macro %"wel.h%"]: EIF_POINTER"
		alias
			"IDC_HELP"
		end

	Idc_hand: POINTER
		external
			"C [macro %"wel.h%"]: EIF_POINTER"
		alias
			"MAKEINTRESOURCE(32649)"
		end

	Idc_ibeam: POINTER
		external
			"C [macro %"wel.h%"]: EIF_POINTER"
		alias
			"IDC_IBEAM"
		end

	Idc_no: POINTER
		external
			"C [macro %"wel.h%"]: EIF_POINTER"
		alias
			"IDC_NO"
		end

	Idc_wait: POINTER
		external
			"C [macro %"wel.h%"]: EIF_POINTER"
		alias
			"IDC_WAIT"
		end

	Idc_cross: POINTER
		external
			"C [macro %"wel.h%"]: EIF_POINTER"
		alias
			"IDC_CROSS"
		end

	Idc_uparrow: POINTER
		external
			"C [macro %"wel.h%"]: EIF_POINTER"
		alias
			"IDC_UPARROW"
		end

	Idc_sizeall: POINTER
		external
			"C [macro %"wel.h%"]: EIF_POINTER"
		alias
			"IDC_SIZEALL"
		end

	Idc_sizenwse: POINTER
		external
			"C [macro %"wel.h%"]: EIF_POINTER"
		alias
			"IDC_SIZENWSE"
		end

	Idc_sizenesw: POINTER
		external
			"C [macro %"wel.h%"]: EIF_POINTER"
		alias
			"IDC_SIZENESW"
		end

	Idc_sizewe: POINTER
		external
			"C [macro %"wel.h%"]: EIF_POINTER"
		alias
			"IDC_SIZEWE"
		end

	Idc_sizens: POINTER
		external
			"C [macro %"wel.h%"]: EIF_POINTER"
		alias
			"IDC_SIZENS"
		end

feature -- Obsolete

	Idc_size: POINTER obsolete "Use `Idc_sizeall' [2017-05-31]"
		do
			Result := Idc_sizeall
		end

	Idc_icon: POINTER obsolete "Use `Idc_arrow' [2017-05-31]"
		do
			Result := Idc_arrow
		end

note
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

