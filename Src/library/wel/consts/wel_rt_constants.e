indexing
	description: "Resource Type (RT) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_RT_CONSTANTS

feature -- Access

	Rt_cursor: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"RT_CURSOR"
		end

	Rt_bitmap: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"RT_BITMAP"
		end

	Rt_icon: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"RT_ICON"
		end

	Rt_menu: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"RT_MENU"
		end

	Rt_dialog: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"RT_DIALOG"
		end

	Rt_string: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"RT_STRING"
		end

	Rt_fontdir: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"RT_FONTDIR"
		end

	Rt_font: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"RT_FONT"
		end

	Rt_accelerator: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"RT_ACCELERATOR"
		end

	Rt_rcdata: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"RT_RCDATA"
		end

	Rt_group_cursor: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"RT_GROUP_CURSOR"
		end

	Rt_group_icon: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"RT_GROUP_ICON"
		end

end -- class WEL_RT_CONSTANTS

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

