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
			"C [macro <wel.h>]"
		alias
			"RT_CURSOR"
		end

	Rt_bitmap: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"RT_BITMAP"
		end

	Rt_icon: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"RT_ICON"
		end

	Rt_menu: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"RT_MENU"
		end

	Rt_dialog: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"RT_DIALOG"
		end

	Rt_string: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"RT_STRING"
		end

	Rt_fontdir: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"RT_FONTDIR"
		end

	Rt_font: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"RT_FONT"
		end

	Rt_accelerator: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"RT_ACCELERATOR"
		end

	Rt_rcdata: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"RT_RCDATA"
		end

	Rt_group_cursor: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"RT_GROUP_CURSOR"
		end

	Rt_group_icon: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"RT_GROUP_ICON"
		end

end -- class WEL_RT_CONSTANTS

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1997, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
