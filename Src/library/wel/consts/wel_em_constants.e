indexing
	description: "Edit control message (EM) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_EM_CONSTANTS

feature -- Access

	Em_getsel: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"EM_GETSEL"
		end

	Em_setsel: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"EM_SETSEL"
		end

	Em_getrect: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"EM_GETRECT"
		end

	Em_setrect: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"EM_SETRECT"
		end

	Em_setrectnp: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"EM_SETRECTNP"
		end

	Em_linescroll: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"EM_LINESCROLL"
		end

	Em_getmodify: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"EM_GETMODIFY"
		end

	Em_setmodify: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"EM_SETMODIFY"
		end

	Em_getlinecount: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"EM_GETLINECOUNT"
		end

	Em_lineindex: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"EM_LINEINDEX"
		end

	Em_sethandle: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"EM_SETHANDLE"
		end

	Em_gethandle: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"EM_GETHANDLE"
		end

	Em_linelength: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"EM_LINELENGTH"
		end

	Em_replacesel: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"EM_REPLACESEL"
		end

	Em_getline: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"EM_GETLINE"
		end

	Em_limittext: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"EM_LIMITTEXT"
		end

	Em_canundo: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"EM_CANUNDO"
		end

	Em_undo: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"EM_UNDO"
		end

	Em_fmtlines: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"EM_FMTLINES"
		end

	Em_linefromchar: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"EM_LINEFROMCHAR"
		end

	Em_settabstops: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"EM_SETTABSTOPS"
		end

	Em_setpasswordchar: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"EM_SETPASSWORDCHAR"
		end

	Em_emptyundobuffer: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"EM_EMPTYUNDOBUFFER"
		end

	Em_getfirstvisibleline: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"EM_GETFIRSTVISIBLELINE"
		end

	Em_setreadonly: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"EM_SETREADONLY"
		end

	Em_setwordbreakproc: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"EM_SETWORDBREAKPROC"
		end

	Em_getwordbreakproc: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"EM_GETWORDBREAKPROC"
		end

	Em_getpasswordchar: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"EM_GETPASSWORDCHAR"
		end

	Em_scrollcaret: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"EM_SCROLLCARET"
		end

end -- class WEL_EM_CONSTANTS

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

