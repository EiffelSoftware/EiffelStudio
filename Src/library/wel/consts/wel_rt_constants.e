indexing
	description: "Resource Type (RT) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	note: "Changed all Resource Types from INTEGER%
			%to POINTER"

class
	WEL_RT_CONSTANTS

feature -- Access

	Rt_cursor: POINTER is
		external
			"C [macro %"wel.h%"] : EIF_POINTER"
		alias
			"RT_CURSOR"
		end

	Rt_bitmap: POINTER is
		external
			"C [macro %"wel.h%"] : EIF_POINTER"
		alias
			"RT_BITMAP"
		end

	Rt_icon: POINTER is
		external
			"C [macro %"wel.h%"] : EIF_POINTER"
		alias
			"RT_ICON"
		end

	Rt_menu: POINTER is
		external
			"C [macro %"wel.h%"] : EIF_POINTER"
		alias
			"RT_MENU"
		end

	Rt_dialog: POINTER is
		external
			"C [macro %"wel.h%"] : EIF_POINTER"
		alias
			"RT_DIALOG"
		end

	Rt_string: POINTER is
		external
			"C [macro %"wel.h%"] : EIF_POINTER"
		alias
			"RT_STRING"
		end

	Rt_fontdir: POINTER is
		external
			"C [macro %"wel.h%"] : EIF_POINTER"
		alias
			"RT_FONTDIR"
		end

	Rt_font: POINTER is
		external
			"C [macro %"wel.h%"] : EIF_POINTER"
		alias
			"RT_FONT"
		end

	Rt_accelerator: POINTER is
		external
			"C [macro %"wel.h%"] : EIF_POINTER"
		alias
			"RT_ACCELERATOR"
		end

	Rt_rcdata: POINTER is
		external
			"C [macro %"wel.h%"] : EIF_POINTER"
		alias
			"RT_RCDATA"
		end

	Rt_group_cursor: POINTER is
		external
			"C [macro %"wel.h%"] : EIF_POINTER"
		alias
			"RT_GROUP_CURSOR"
		end

	Rt_group_icon: POINTER is
		external
			"C [macro %"wel.h%"] : EIF_POINTER"
		alias
			"RT_GROUP_ICON"
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




end -- class WEL_RT_CONSTANTS

