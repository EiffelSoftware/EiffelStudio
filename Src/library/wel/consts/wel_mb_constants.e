indexing
	description: "MessageBox (MB) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_MB_CONSTANTS

feature -- Access

	Mb_ok: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MB_OK"
		end

	Mb_okcancel: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MB_OKCANCEL"
		end

	Mb_abortretryignore: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MB_ABORTRETRYIGNORE"
		end

	Mb_yesnocancel: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MB_YESNOCANCEL"
		end

	Mb_yesno: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MB_YESNO"
		end

	Mb_retrycancel: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MB_RETRYCANCEL"
		end

	Mb_typemask: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MB_TYPEMASK"
		end

	Mb_iconhand: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MB_ICONHAND"
		end

	Mb_iconerror: INTEGER is
			external
				"C [macro %"wel.h%"]"
			alias
				"MB_ICONERROR"
		end

	Mb_iconstop: INTEGER is
			external
				"C [macro %"wel.h%"]"
			alias
				"MB_ICONSTOP"
		end

	Mb_iconquestion: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MB_ICONQUESTION"
		end

	Mb_iconexclamation: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MB_ICONEXCLAMATION"
		end

	Mb_iconwarning: INTEGER is
		external
   			"C [macro %"wel.h%"]"
   		alias
   			"MB_ICONWARNING"
		end


	Mb_iconasterisk: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MB_ICONASTERISK"
		end

	Mb_iconmask: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MB_ICONMASK"
		end

	Mb_iconinformation: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MB_ICONINFORMATION"
		end

	Mb_defbutton1: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MB_DEFBUTTON1"
		end

	Mb_defbutton2: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MB_DEFBUTTON2"
		end

	Mb_defbutton3: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MB_DEFBUTTON3"
		end

	Mb_defmask: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MB_DEFMASK"
		end

	Mb_applmodal: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MB_APPLMODAL"
		end

	Mb_systemmodal: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MB_SYSTEMMODAL"
		end

	Mb_taskmodal: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MB_TASKMODAL"
		end

	Mb_default_desktop_only: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MB_DEFAULT_DESKTOP_ONLY"
		end

	Mb_help: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MB_HELP"
		end

	Mb_right: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MB_RIGHT"
		end

	Mb_rtlreading: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MB_RTLREADING"
		end

	Mb_setforeground: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MB_SETFOREGROUND"
		end

	Mb_topmost: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MB_TOPMOST"
		end

	
	Mb_nofocus: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MB_NOFOCUS"
		end

	Mb_usericon: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MB_USERICON"
		end

end -- class WEL_MB_CONSTANTS

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

