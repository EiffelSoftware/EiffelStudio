note
	description: "Print dialog (PD) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_PD_CONSTANTS

feature -- Access

	Pd_allpages: INTEGER = 0

	Pd_selection: INTEGER = 1

	Pd_pagenums: INTEGER = 2

	Pd_noselection: INTEGER = 4

	Pd_nopagenums: INTEGER = 8

	Pd_collate: INTEGER = 16

	Pd_printtofile: INTEGER = 32

	Pd_printsetup: INTEGER = 64

	Pd_nowarning: INTEGER = 128

	Pd_returndc: INTEGER = 256

	Pd_returnic: INTEGER = 512

	Pd_returndefault: INTEGER = 1024

	Pd_showhelp: INTEGER = 2048

	Pd_enableprinthook: INTEGER = 4096

	Pd_enablesetuphook: INTEGER = 8192

	Pd_enableprinttemplate: INTEGER = 16384

	Pd_enablesetuptemplate: INTEGER = 32768

	Pd_enableprinttemplatehandle: INTEGER = 65536

	Pd_enablesetuptemplatehandle: INTEGER = 131072

	Pd_usedevmodecopies: INTEGER = 262144

	Pd_disableprinttofile: INTEGER = 524288

	Pd_hideprinttofile: INTEGER = 1048576;

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




end -- class WEL_PD_CONSTANTS

