indexing
	description: "Rich edit messages."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_RICH_EDIT_MESSAGE_CONSTANTS

feature -- Access

	Em_getcharformat: INTEGER is
		external
			"C [macro %"redit.h%"]"
		alias
			"EM_GETCHARFORMAT"
		end

	Em_getparaformat: INTEGER is
		external
			"C [macro %"redit.h%"]"
		alias
			"EM_GETPARAFORMAT"
		end

	Em_setbkgndcolor: INTEGER is
		external
			"C [macro %"redit.h%"]"
		alias
			"EM_SETBKGNDCOLOR"
		end

	Em_setcharformat: INTEGER is
		external
			"C [macro %"redit.h%"]"
		alias
			"EM_SETCHARFORMAT"
		end

	Em_seteventmask: INTEGER is
		external
			"C [macro %"redit.h%"]"
		alias
			"EM_SETEVENTMASK"
		end

	Em_setparaformat: INTEGER is
		external
			"C [macro %"redit.h%"]"
		alias
			"EM_SETPARAFORMAT"
		end

	Em_charfrompos: INTEGER is
		external
			"C [macro %"redit.h%"]"
		alias
			"EM_CHARFROMPOS"
		end

	Em_exgetsel: INTEGER is
		external
			"C [macro %"redit.h%"]"
		alias
			"EM_EXGETSEL"
		end

	Em_exsetsel: INTEGER is
		external
			"C [macro %"redit.h%"]"
		alias
			"EM_EXSETSEL"
		end

	Em_hideselection: INTEGER is
		external
			"C [macro %"redit.h%"]"
		alias
			"EM_HIDESELECTION"
		end

	Em_posfromchar: INTEGER is
		external
			"C [macro %"redit.h%"]"
		alias
			"EM_POSFROMCHAR"
		end

	Em_selectiontype: INTEGER is
		external
			"C [macro %"redit.h%"]"
		alias
			"EM_SELECTIONTYPE"
		end

	En_selchange: INTEGER is
		external
			"C [macro %"redit.h%"]"
		alias
			"EN_SELCHANGE"
		end

	Em_exlimittext: INTEGER is
		external
			"C [macro %"redit.h%"]"
		alias
			"EM_EXLIMITTEXT"
		end

	Em_findtext: INTEGER is
		external
			"C [macro %"redit.h%"]"
		alias
			"EM_FINDTEXT"
		end

	Em_findtextex: INTEGER is
		external
			"C [macro %"redit.h%"]"
		alias
			"EM_FINDTEXTEX"
		end

	Em_getseltext: INTEGER is
		external
			"C [macro %"redit.h%"]"
		alias
			"EM_GETSELTEXT"
		end

	Em_gettextrange: INTEGER is
		external
			"C [macro %"redit.h%"]"
		alias
			"EM_GETTEXTRANGE"
		end

	Em_setlimittext: INTEGER is
		external
			"C [macro %"redit.h%"]"
		alias
			"EM_SETLIMITTEXT"
		end

	Em_exlinefromchar: INTEGER is
		external
			"C [macro %"redit.h%"]"
		alias
			"EM_EXLINEFROMCHAR"
		end

	Em_findwordbreak: INTEGER is
		external
			"C [macro %"redit.h%"]"
		alias
			"EM_FINDWORDBREAK"
		end

	Em_getwordbreakprocex: INTEGER is
		external
			"C [macro %"redit.h%"]"
		alias
			"EM_GETWORDBREAKPROCEX"
		end

	Em_setwordbreakprocex: INTEGER is
		external
			"C [macro %"redit.h%"]"
		alias
			"EM_SETWORDBREAKPROCEX"
		end

	Em_canpaste: INTEGER is
		external
			"C [macro %"redit.h%"]"
		alias
			"EM_CANPASTE"
		end

	Em_pastespecial: INTEGER is
		external
			"C [macro %"redit.h%"]"
		alias
			"EM_PASTESPECIAL"
		end

	Em_streamin: INTEGER is
		external
			"C [macro %"redit.h%"]"
		alias
			"EM_STREAMIN"
		end

	Em_streamout: INTEGER is
		external
			"C [macro %"redit.h%"]"
		alias
			"EM_STREAMOUT"
		end

	Em_displayband: INTEGER is
		external
			"C [macro %"redit.h%"]"
		alias
			"EM_DISPLAYBAND"
		end

	Em_formatrange: INTEGER is
		external
			"C [macro %"redit.h%"]"
		alias
			"EM_FORMATRANGE"
		end

	Em_settargetdevice: INTEGER is
		external
			"C [macro %"redit.h%"]"
		alias
			"EM_SETTARGETDEVICE"
		end

	Em_requestresize: INTEGER is
		external
			"C [macro %"redit.h%"]"
		alias
			"EM_REQUESTRESIZE"
		end

	Em_geteventmask: INTEGER is
		external
			"C [macro %"redit.h%"]"
		alias
			"EM_GETEVENTMASK"
		end

	Em_getimecolor: INTEGER is
		external
			"C [macro %"redit.h%"]"
		alias
			"EM_GETIMECOLOR"
		end

	Em_getimeoptions: INTEGER is
		external
			"C [macro %"redit.h%"]"
		alias
			"EM_GETIMEOPTIONS"
		end

	Em_getoptions: INTEGER is
		external
			"C [macro %"redit.h%"]"
		alias
			"EM_GETOPTIONS"
		end

	Em_getpunctuation: INTEGER is
		external
			"C [macro %"redit.h%"]"
		alias
			"EM_GETPUNCTUATION"
		end

	Em_getwordwrapmode: INTEGER is
		external
			"C [macro %"redit.h%"]"
		alias
			"EM_GETWORDWRAPMODE"
		end

	Em_setimecolor: INTEGER is
		external
			"C [macro %"redit.h%"]"
		alias
			"EM_SETIMECOLOR"
		end

	Em_setimeoptions: INTEGER is
		external
			"C [macro %"redit.h%"]"
		alias
			"EM_SETIMEOPTIONS"
		end

	Em_setoptions: INTEGER is
		external
			"C [macro %"redit.h%"]"
		alias
			"EM_SETOPTIONS"
		end

	Em_setpunctuation: INTEGER is
		external
			"C [macro %"redit.h%"]"
		alias
			"EM_SETPUNCTUATION"
		end

	Em_setwordwrapmode: INTEGER is
		external
			"C [macro %"redit.h%"]"
		alias
			"EM_SETWORDWRAPMODE"
		end

end -- class WEL_RICH_EDIT_MESSAGE_CONSTANTS

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

