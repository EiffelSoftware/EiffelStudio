indexing
	description: "ListBox Style constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_LBS_CONSTANTS

feature -- Access

	Lbs_notify: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"LBS_NOTIFY"
		end

	Lbs_sort: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"LBS_SORT"
		end

	Lbs_noredraw: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"LBS_NOREDRAW"
		end

	Lbs_multiplesel: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"LBS_MULTIPLESEL"
		end

	Lbs_ownerdrawfixed: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"LBS_OWNERDRAWFIXED"
		end

	Lbs_ownerdrawvariable: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"LBS_OWNERDRAWVARIABLE"
		end

	Lbs_hasstrings: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"LBS_HASSTRINGS"
		end

	Lbs_usetabstops: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"LBS_USETABSTOPS"
		end

	Lbs_nointegralheight: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"LBS_NOINTEGRALHEIGHT"
		end

	Lbs_multicolumn: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"LBS_MULTICOLUMN"
		end

	Lbs_wantkeyboardinput: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"LBS_WANTKEYBOARDINPUT"
		end

	Lbs_extendedsel: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"LBS_EXTENDEDSEL"
		end

	Lbs_disablenoscroll: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"LBS_DISABLENOSCROLL"
		end

	Lbs_standard: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"LBS_STANDARD"
		end

end -- class WEL_LBS_CONSTANTS

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
