indexing
	description: "Hit test (HT) code constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_HT_CONSTANTS

feature -- Access

	Hterror: INTEGER is -2
			-- Declared in Windows as HTERROR

	Httransparent: INTEGER is -1
			-- Declared in Windows as HTTRANSPARENT

	Htnowhere: INTEGER is 0
			-- Declared in Windows as HTNOWHERE

	Htclient: INTEGER is 1
			-- Declared in Windows as HTCLIENT

	Htcaption: INTEGER is 2
			-- Declared in Windows as HTCAPTION

	Htsysmenu: INTEGER is 3
			-- Declared in Windows as HTSYSMENU

	Htsize: INTEGER is 4
			-- Declared in Windows as HTSIZE

	Htmenu: INTEGER is 5
			-- Declared in Windows as HTMENU

	Hthscroll: INTEGER is 6
			-- Declared in Windows as HTHSCROLL

	Htvscroll: INTEGER is 7
			-- Declared in Windows as HTVSCROLL

	Htminbutton: INTEGER is 8
			-- Declared in Windows as HTMINBUTTON

	Htmaxbutton: INTEGER is 9
			-- Declared in Windows as HTMAXBUTTON

	Htleft: INTEGER is 10
			-- Declared in Windows as HTLEFT

	Htright: INTEGER is 11
			-- Declared in Windows as HTRIGHT

	Httop: INTEGER is 12
			-- Declared in Windows as HTTOP

	Httopleft: INTEGER is 13
			-- Declared in Windows as HTTOPLEFT

	Httopright: INTEGER is 14
			-- Declared in Windows as HTTOPRIGHT

	Htbottom: INTEGER is 15
			-- Declared in Windows as HTBOTTOM

	Htbottomleft: INTEGER is 16
			-- Declared in Windows as HTBOTTOMLEFT

	Htbottomright: INTEGER is 17
			-- Declared in Windows as HTBOTTOMRIGHT

	Htborder: INTEGER is 18
			-- Declared in Windows as HTBORDER

	Htgrowbox: INTEGER is 4
			-- Declared in Windows as HTGROWBOX

	Htreduce: INTEGER is 8
			-- Declared in Windows as HTREDUCE

	Htzoom: INTEGER is 9;
			-- Declared in Windows as HTZOOM

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_HT_CONSTANTS

