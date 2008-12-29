note
	description: "MessageBox (MB) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_MB_CONSTANTS

feature -- Access

	Mb_ok: INTEGER = 0

	Mb_okcancel: INTEGER = 1

	Mb_abortretryignore: INTEGER = 2

	Mb_yesnocancel: INTEGER = 3

	Mb_yesno: INTEGER = 4

	Mb_retrycancel: INTEGER = 5

	Mb_typemask: INTEGER = 15

	Mb_iconhand: INTEGER = 16

	Mb_iconerror: INTEGER = 16
			-- Same as `Mb_iconhand'.

	Mb_iconstop: INTEGER = 16
			-- Same as `Mb_iconhand'.

	Mb_iconquestion: INTEGER = 32

	Mb_iconexclamation: INTEGER = 48

	Mb_iconwarning: INTEGER = 48
			-- Same as `Mb_iconexclamation'.

	Mb_iconasterisk: INTEGER = 64

	Mb_iconmask: INTEGER = 240

	Mb_iconinformation: INTEGER = 64
			-- Same as `Mb_iconasterisk'.

	Mb_defbutton1: INTEGER = 0

	Mb_defbutton2: INTEGER = 256

	Mb_defbutton3: INTEGER = 512

	Mb_defmask: INTEGER = 3840

	Mb_applmodal: INTEGER = 0

	Mb_systemmodal: INTEGER = 4096

	Mb_taskmodal: INTEGER = 8192

	Mb_default_desktop_only: INTEGER = 131072

	Mb_help: INTEGER = 16384

	Mb_right: INTEGER = 524288

	Mb_rtlreading: INTEGER = 1048576

	Mb_setforeground: INTEGER = 65536

	Mb_topmost: INTEGER = 262144
	
	Mb_nofocus: INTEGER = 32768

	Mb_usericon: INTEGER = 128;

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




end -- class WEL_MB_CONSTANTS

