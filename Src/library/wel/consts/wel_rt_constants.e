indexing
	description: "Resource Type (RT) constants."
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

end -- class WEL_RT_CONSTANTS

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

