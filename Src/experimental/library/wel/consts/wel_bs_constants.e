note
	description: "Button style (BS) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_BS_CONSTANTS

feature -- Access

	Bs_pushbutton: INTEGER = 0

	Bs_defpushbutton: INTEGER = 1

	Bs_checkbox: INTEGER = 2

	Bs_autocheckbox: INTEGER = 3

	Bs_radiobutton: INTEGER = 4

	Bs_3state: INTEGER = 5

	Bs_auto3state: INTEGER = 6

	Bs_groupbox: INTEGER = 7

	Bs_userbutton: INTEGER = 8

	Bs_autoradiobutton: INTEGER = 9

	Bs_ownerdraw: INTEGER = 11

	Bs_lefttext: INTEGER = 32

	Bs_text: INTEGER = 0

	Bs_icon: INTEGER = 64

	Bs_bitmap: INTEGER = 128

	Bs_left: INTEGER = 256

	Bs_right: INTEGER = 512

	Bs_center: INTEGER = 768

	Bs_top: INTEGER = 1024

	Bs_bottom: INTEGER = 2048

	Bs_vcenter: INTEGER = 3072

	Bs_pushlike: INTEGER = 4096

	Bs_multiline: INTEGER = 8192

	Bs_notify: INTEGER = 16384

	Bs_flat: INTEGER = 32768

	Bs_rightbutton: INTEGER = 32;
			-- Same as `Bs_lefttext'.

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




end -- class WEL_BS_CONSTANTS

