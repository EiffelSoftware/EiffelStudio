indexing
	description: "Hit test (HT) code constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_HT_CONSTANTS

feature -- Access

	Hterror: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"HTERROR"
		end

	Httransparent: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"HTTRANSPARENT"
		end

	Htnowhere: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"HTNOWHERE"
		end

	Htclient: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"HTCLIENT"
		end

	Htcaption: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"HTCAPTION"
		end

	Htsysmenu: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"HTSYSMENU"
		end

	Htsize: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"HTSIZE"
		end

	Htmenu: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"HTMENU"
		end

	Hthscroll: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"HTHSCROLL"
		end

	Htvscroll: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"HTVSCROLL"
		end

	Htminbutton: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"HTMINBUTTON"
		end

	Htmaxbutton: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"HTMAXBUTTON"
		end

	Htleft: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"HTLEFT"
		end

	Htright: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"HTRIGHT"
		end

	Httop: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"HTTOP"
		end

	Httopleft: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"HTTOPLEFT"
		end

	Httopright: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"HTTOPRIGHT"
		end

	Htbottom: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"HTBOTTOM"
		end

	Htbottomleft: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"HTBOTTOMLEFT"
		end

	Htbottomright: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"HTBOTTOMRIGHT"
		end

	Htborder: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"HTBORDER"
		end

	Htgrowbox: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"HTGROWBOX"
		end

	Htreduce: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"HTREDUCE"
		end

	Htzoom: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"HTZOOM"
		end

end -- class WEL_HT_CONSTANTS

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
