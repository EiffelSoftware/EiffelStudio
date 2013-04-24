note
	description: "ListBox Style constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_LBS_CONSTANTS

feature -- Access

	Lbs_notify: INTEGER = 1

	Lbs_sort: INTEGER = 2

	Lbs_noredraw: INTEGER = 4

	Lbs_multiplesel: INTEGER = 8

	Lbs_ownerdrawfixed: INTEGER = 16

	Lbs_ownerdrawvariable: INTEGER = 32

	Lbs_hasstrings: INTEGER = 64

	Lbs_usetabstops: INTEGER = 128

	Lbs_nointegralheight: INTEGER = 256

	Lbs_multicolumn: INTEGER = 512

	Lbs_wantkeyboardinput: INTEGER = 1024

	Lbs_extendedsel: INTEGER = 2048

	Lbs_disablenoscroll: INTEGER = 4096

	Lbs_standard: INTEGER = 10485763;
			-- `Lbs_notify' | `Lbs_sort' | `Ws_vscroll' | `Ws_border'.

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




end -- class WEL_LBS_CONSTANTS

