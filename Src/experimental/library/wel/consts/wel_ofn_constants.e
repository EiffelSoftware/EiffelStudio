note
	description: "OpenFile common dialog (OFN) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_OFN_CONSTANTS

feature -- Access

	Ofn_readonly: INTEGER = 1

	Ofn_overwriteprompt: INTEGER = 2

	Ofn_hidereadonly: INTEGER = 4

	Ofn_nochangedir: INTEGER = 8

	Ofn_showhelp: INTEGER = 16

	Ofn_enablehook: INTEGER = 32

	Ofn_enabletemplate: INTEGER = 64

	Ofn_enabletemplatehandle: INTEGER = 128

	Ofn_novalidate: INTEGER = 256

	Ofn_allowmultiselect: INTEGER = 512

	Ofn_extensiondifferent: INTEGER = 1024

	Ofn_pathmustexist: INTEGER = 2048

	Ofn_filemustexist: INTEGER = 4096

	Ofn_createprompt: INTEGER = 8192

	Ofn_shareaware: INTEGER = 16384

	Ofn_noreadonlyreturn: INTEGER = 32768

	Ofn_notestfilecreate: INTEGER = 65536

	Ofn_nonetworkbutton: INTEGER = 131072

	Ofn_nolongnames: INTEGER = 262144

	Ofn_sharefallthrough: INTEGER = 2

	Ofn_sharenowarn: INTEGER = 1

	Ofn_sharewarn: INTEGER = 0

	Ofn_explorer: INTEGER = 524288;

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




end -- class WEL_OFN_CONSTANTS

