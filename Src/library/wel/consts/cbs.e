indexing
	description: "ComboBox Style (CBS) messages."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CBS_CONSTANTS

feature -- Access

	Cbs_simple: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"CBS_SIMPLE"
		end

	Cbs_dropdown: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"CBS_DROPDOWN"
		end

	Cbs_dropdownlist: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"CBS_DROPDOWNLIST"
		end

	Cbs_ownerdrawfixed: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"CBS_OWNERDRAWFIXED"
		end

	Cbs_ownerdrawvariable: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"CBS_OWNERDRAWVARIABLE"
		end

	Cbs_autohscroll: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"CBS_AUTOHSCROLL"
		end

	Cbs_oemconvert: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"CBS_OEMCONVERT"
		end

	Cbs_sort: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"CBS_SORT"
		end

	Cbs_hasstrings: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"CBS_HASSTRINGS"
		end

	Cbs_nointegralheight: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"CBS_NOINTEGRALHEIGHT"
		end

	Cbs_disablenoscroll: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"CBS_DISABLENOSCROLL"
		end

end -- class WEL_CBS_CONSTANTS

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
