indexing
	description: "OpenFile common dialog (OFN) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_OFN_CONSTANTS

feature -- Access

	Ofn_readonly: INTEGER is 1

	Ofn_overwriteprompt: INTEGER is 2

	Ofn_hidereadonly: INTEGER is 4

	Ofn_nochangedir: INTEGER is 8

	Ofn_showhelp: INTEGER is 16

	Ofn_enablehook: INTEGER is 32

	Ofn_enabletemplate: INTEGER is 64

	Ofn_enabletemplatehandle: INTEGER is 128

	Ofn_novalidate: INTEGER is 256

	Ofn_allowmultiselect: INTEGER is 512

	Ofn_extensiondifferent: INTEGER is 1024

	Ofn_pathmustexist: INTEGER is 2048

	Ofn_filemustexist: INTEGER is 4096

	Ofn_createprompt: INTEGER is 8192

	Ofn_shareaware: INTEGER is 16384

	Ofn_noreadonlyreturn: INTEGER is 32768

	Ofn_notestfilecreate: INTEGER is 65536

	Ofn_nonetworkbutton: INTEGER is 131072

	Ofn_nolongnames: INTEGER is 262144

	Ofn_sharefallthrough: INTEGER is 2

	Ofn_sharenowarn: INTEGER is 1

	Ofn_sharewarn: INTEGER is 0

	Ofn_explorer: INTEGER is 524288

end -- class WEL_OFN_CONSTANTS

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

