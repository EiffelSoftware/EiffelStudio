indexing
	description: "MessageBox (MB) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_MB_CONSTANTS

feature -- Access

	Mb_ok: INTEGER is 0

	Mb_okcancel: INTEGER is 1

	Mb_abortretryignore: INTEGER is 2

	Mb_yesnocancel: INTEGER is 3

	Mb_yesno: INTEGER is 4

	Mb_retrycancel: INTEGER is 5

	Mb_typemask: INTEGER is 15

	Mb_iconhand: INTEGER is 16

	Mb_iconerror: INTEGER is 16
			-- Same as `Mb_iconhand'.

	Mb_iconstop: INTEGER is 16
			-- Same as `Mb_iconhand'.

	Mb_iconquestion: INTEGER is 32

	Mb_iconexclamation: INTEGER is 48

	Mb_iconwarning: INTEGER is 48
			-- Same as `Mb_iconexclamation'.

	Mb_iconasterisk: INTEGER is 64

	Mb_iconmask: INTEGER is 240

	Mb_iconinformation: INTEGER is 64
			-- Same as `Mb_iconasterisk'.

	Mb_defbutton1: INTEGER is 0

	Mb_defbutton2: INTEGER is 256

	Mb_defbutton3: INTEGER is 512

	Mb_defmask: INTEGER is 3840

	Mb_applmodal: INTEGER is 0

	Mb_systemmodal: INTEGER is 4096

	Mb_taskmodal: INTEGER is 8192

	Mb_default_desktop_only: INTEGER is 131072

	Mb_help: INTEGER is 16384

	Mb_right: INTEGER is 524288

	Mb_rtlreading: INTEGER is 1048576

	Mb_setforeground: INTEGER is 65536

	Mb_topmost: INTEGER is 262144
	
	Mb_nofocus: INTEGER is 32768

	Mb_usericon: INTEGER is 128;

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




end -- class WEL_MB_CONSTANTS

