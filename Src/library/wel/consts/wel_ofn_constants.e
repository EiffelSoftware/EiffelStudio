indexing
	description: "OpenFile common dialog (OFN) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_OFN_CONSTANTS

feature -- Access

	Ofn_readonly: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"OFN_READONLY"
		end

	Ofn_overwriteprompt: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"OFN_OVERWRITEPROMPT"
		end

	Ofn_hidereadonly: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"OFN_HIDEREADONLY"
		end

	Ofn_nochangedir: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"OFN_NOCHANGEDIR"
		end

	Ofn_showhelp: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"OFN_SHOWHELP"
		end

	Ofn_enablehook: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"OFN_ENABLEHOOK"
		end

	Ofn_enabletemplate: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"OFN_ENABLETEMPLATE"
		end

	Ofn_enabletemplatehandle: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"OFN_ENABLETEMPLATEHANDLE"
		end

	Ofn_novalidate: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"OFN_NOVALIDATE"
		end

	Ofn_allowmultiselect: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"OFN_ALLOWMULTISELECT"
		end

	Ofn_extensiondifferent: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"OFN_EXTENSIONDIFFERENT"
		end

	Ofn_pathmustexist: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"OFN_PATHMUSTEXIST"
		end

	Ofn_filemustexist: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"OFN_FILEMUSTEXIST"
		end

	Ofn_createprompt: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"OFN_CREATEPROMPT"
		end

	Ofn_shareaware: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"OFN_SHAREAWARE"
		end

	Ofn_noreadonlyreturn: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"OFN_NOREADONLYRETURN"
		end

	Ofn_notestfilecreate: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"OFN_NOTESTFILECREATE"
		end

	Ofn_nonetworkbutton: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"OFN_NONETWORKBUTTON"
		end

	Ofn_nolongnames: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"OFN_NOLONGNAMES"
		end

	Ofn_sharefallthrough: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"OFN_SHAREFALLTHROUGH"
		end

	Ofn_sharenowarn: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"OFN_SHARENOWARN"
		end

	Ofn_sharewarn: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"OFN_SHAREWARN"
		end

end -- class WEL_OFN_CONSTANTS

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

