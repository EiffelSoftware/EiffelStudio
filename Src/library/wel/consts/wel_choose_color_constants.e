indexing
	description: "Choose color (CC) dialog constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CHOOSE_COLOR_CONSTANTS

feature -- Access

	Cc_rgbinit: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"CC_RGBINIT"
		end

	Cc_fullopen: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"CC_FULLOPEN"
		end

	Cc_preventfullopen: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"CC_PREVENTFULLOPEN"
		end

	Cc_showhelp: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"CC_SHOWHELP"
		end

	Cc_enablehook: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"CC_ENABLEHOOK"
		end

	Cc_enabletemplate: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"CC_ENABLETEMPLATE"
		end

	Cc_enabletemplatehandle: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"CC_ENABLETEMPLATEHANDLE"
		end

	Cc_solidcolor: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"CC_SOLIDCOLOR"
		end

	Cc_anycolor: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"CC_ANYCOLOR"
		end

end -- class WEL_CHOOSE_COLOR_CONSTANTS

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

