indexing
	description: "Print dialog (PD) constants."
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

	Pd_hideprinttofile: INTEGER is 1048576

end -- class WEL_PD_CONSTANTS

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

