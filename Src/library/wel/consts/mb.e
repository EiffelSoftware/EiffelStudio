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
			"C [macro <wel.h>]"
		alias
			"MB_OK"
		end

	Mb_okcancel: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"MB_OKCANCEL"
		end

	Mb_abortretryignore: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"MB_ABORTRETRYIGNORE"
		end

	Mb_yesnocancel: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"MB_YESNOCANCEL"
		end

	Mb_yesno: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"MB_YESNO"
		end

	Mb_retrycancel: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"MB_RETRYCANCEL"
		end

	Mb_typemask: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"MB_TYPEMASK"
		end

	Mb_iconhand: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"MB_ICONHAND"
		end

	Mb_iconquestion: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"MB_ICONQUESTION"
		end

	Mb_iconexclamation: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"MB_ICONEXCLAMATION"
		end

	Mb_iconasterisk: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"MB_ICONASTERISK"
		end

	Mb_iconmask: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"MB_ICONMASK"
		end

	Mb_iconinformation: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"MB_ICONINFORMATION"
		end

	Mb_iconstop: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"MB_ICONSTOP"
		end

	Mb_defbutton1: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"MB_DEFBUTTON1"
		end

	Mb_defbutton2: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"MB_DEFBUTTON2"
		end

	Mb_defbutton3: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"MB_DEFBUTTON3"
		end

	Mb_defmask: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"MB_DEFMASK"
		end

	Mb_applmodal: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"MB_APPLMODAL"
		end

	Mb_systemmodal: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"MB_SYSTEMMODAL"
		end

	Mb_taskmodal: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"MB_TASKMODAL"
		end

	Mb_nofocus: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"MB_NOFOCUS"
		end

end -- class WEL_MB_CONSTANTS

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
