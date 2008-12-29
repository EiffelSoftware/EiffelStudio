note
	description: "Hit test (HT) code constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_HT_CONSTANTS

feature -- Access

	Hterror: INTEGER = -2
			-- Declared in Windows as HTERROR

	Httransparent: INTEGER = -1
			-- Declared in Windows as HTTRANSPARENT

	Htnowhere: INTEGER = 0
			-- Declared in Windows as HTNOWHERE

	Htclient: INTEGER = 1
			-- Declared in Windows as HTCLIENT

	Htcaption: INTEGER = 2
			-- Declared in Windows as HTCAPTION

	Htsysmenu: INTEGER = 3
			-- Declared in Windows as HTSYSMENU

	Htsize: INTEGER = 4
			-- Declared in Windows as HTSIZE

	Htmenu: INTEGER = 5
			-- Declared in Windows as HTMENU

	Hthscroll: INTEGER = 6
			-- Declared in Windows as HTHSCROLL

	Htvscroll: INTEGER = 7
			-- Declared in Windows as HTVSCROLL

	Htminbutton: INTEGER = 8
			-- Declared in Windows as HTMINBUTTON

	Htmaxbutton: INTEGER = 9
			-- Declared in Windows as HTMAXBUTTON

	Htleft: INTEGER = 10
			-- Declared in Windows as HTLEFT

	Htright: INTEGER = 11
			-- Declared in Windows as HTRIGHT

	Httop: INTEGER = 12
			-- Declared in Windows as HTTOP

	Httopleft: INTEGER = 13
			-- Declared in Windows as HTTOPLEFT

	Httopright: INTEGER = 14
			-- Declared in Windows as HTTOPRIGHT

	Htbottom: INTEGER = 15
			-- Declared in Windows as HTBOTTOM

	Htbottomleft: INTEGER = 16
			-- Declared in Windows as HTBOTTOMLEFT

	Htbottomright: INTEGER = 17
			-- Declared in Windows as HTBOTTOMRIGHT

	Htborder: INTEGER = 18
			-- Declared in Windows as HTBORDER

	Htgrowbox: INTEGER = 4
			-- Declared in Windows as HTGROWBOX

	Htreduce: INTEGER = 8
			-- Declared in Windows as HTREDUCE

	Htzoom: INTEGER = 9;
			-- Declared in Windows as HTZOOM

note
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

