indexing
	description: "Print dialog (PD) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_PD_CONSTANTS

feature -- Access

	Pd_allpages: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"PD_ALLPAGES"
		end

	Pd_selection: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"PD_SELECTION"
		end

	Pd_pagenums: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"PD_PAGENUMS"
		end

	Pd_noselection: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"PD_NOSELECTION"
		end

	Pd_nopagenums: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"PD_NOPAGENUMS"
		end

	Pd_collate: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"PD_COLLATE"
		end

	Pd_printtofile: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"PD_PRINTTOFILE"
		end

	Pd_printsetup: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"PD_PRINTSETUP"
		end

	Pd_nowarning: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"PD_NOWARNING"
		end

	Pd_returndc: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"PD_RETURNDC"
		end

	Pd_returnic: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"PD_RETURNIC"
		end

	Pd_returndefault: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"PD_RETURNDEFAULT"
		end

	Pd_showhelp: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"PD_SHOWHELP"
		end

	Pd_enableprinthook: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"PD_ENABLEPRINTHOOK"
		end

	Pd_enablesetuphook: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"PD_ENABLESETUPHOOK"
		end

	Pd_enableprinttemplate: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"PD_ENABLEPRINTTEMPLATE"
		end

	Pd_enablesetuptemplate: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"PD_ENABLESETUPTEMPLATE"
		end

	Pd_enableprinttemplatehandle: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"PD_ENABLEPRINTTEMPLATEHANDLE"
		end

	Pd_enablesetuptemplatehandle: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"PD_ENABLESETUPTEMPLATEHANDLE"
		end

	Pd_usedevmodecopies: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"PD_USEDEVMODECOPIES"
		end

	Pd_disableprinttofile: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"PD_DISABLEPRINTTOFILE"
		end

	Pd_hideprinttofile: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"PD_HIDEPRINTTOFILE"
		end

end -- class WEL_PD_CONSTANTS

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

