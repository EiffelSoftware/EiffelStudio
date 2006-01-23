indexing
	description: "Print dialog (PD) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_PD_CONSTANTS

feature -- Access

	Pd_allpages: INTEGER is 0

	Pd_selection: INTEGER is 1

	Pd_pagenums: INTEGER is 2

	Pd_noselection: INTEGER is 4

	Pd_nopagenums: INTEGER is 8

	Pd_collate: INTEGER is 16

	Pd_printtofile: INTEGER is 32

	Pd_printsetup: INTEGER is 64

	Pd_nowarning: INTEGER is 128

	Pd_returndc: INTEGER is 256

	Pd_returnic: INTEGER is 512

	Pd_returndefault: INTEGER is 1024

	Pd_showhelp: INTEGER is 2048

	Pd_enableprinthook: INTEGER is 4096

	Pd_enablesetuphook: INTEGER is 8192

	Pd_enableprinttemplate: INTEGER is 16384

	Pd_enablesetuptemplate: INTEGER is 32768

	Pd_enableprinttemplatehandle: INTEGER is 65536

	Pd_enablesetuptemplatehandle: INTEGER is 131072

	Pd_usedevmodecopies: INTEGER is 262144

	Pd_disableprinttofile: INTEGER is 524288

	Pd_hideprinttofile: INTEGER is 1048576;

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




end -- class WEL_PD_CONSTANTS

