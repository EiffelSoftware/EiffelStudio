indexing
	description: "Choose font (CF) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CF_CONSTANTS

feature -- Access

	Cf_screenfonts: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"CF_SCREENFONTS"
		end

	Cf_printerfonts: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"CF_PRINTERFONTS"
		end

	Cf_both: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"CF_BOTH"
		end

	Cf_showhelp: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"CF_SHOWHELP"
		end

	Cf_enablehook: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"CF_ENABLEHOOK"
		end

	Cf_enabletemplate: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"CF_ENABLETEMPLATE"
		end

	Cf_enabletemplatehandle: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"CF_ENABLETEMPLATEHANDLE"
		end

	Cf_inittologfontstruct: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"CF_INITTOLOGFONTSTRUCT"
		end

	Cf_usestyle: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"CF_USESTYLE"
		end

	Cf_effects: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"CF_EFFECTS"
		end

	Cf_apply: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"CF_APPLY"
		end

	Cf_ansionly: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"CF_ANSIONLY"
		end

	Cf_novectorfonts: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"CF_NOVECTORFONTS"
		end

	Cf_nooemfonts: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"CF_NOOEMFONTS"
		end

	Cf_nosimulations: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"CF_NOSIMULATIONS"
		end

	Cf_limitsize: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"CF_LIMITSIZE"
		end

	Cf_fixedpitchonly: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"CF_FIXEDPITCHONLY"
		end

	Cf_wysiwyg: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"CF_WYSIWYG"
		end

	Cf_forcefontexist: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"CF_FORCEFONTEXIST"
		end

	Cf_scalableonly: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"CF_SCALABLEONLY"
		end

	Cf_ttonly: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"CF_TTONLY"
		end

	Cf_nofacesel: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"CF_NOFACESEL"
		end

	Cf_nostylesel: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"CF_NOSTYLESEL"
		end

	Cf_nosizesel: INTEGER is
		external
			"C [macro %"cdlg.h%"]"
		alias
			"CF_NOSIZESEL"
		end

end -- class WEL_CF_CONSTANTS

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

