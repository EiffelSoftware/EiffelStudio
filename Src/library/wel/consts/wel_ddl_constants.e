indexing
	description: "Dialog Dir List (DDL) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_DDL_CONSTANTS

feature -- Access

	Ddl_readwrite: INTEGER is 0

	Ddl_readonly: INTEGER is 1

	Ddl_hidden: INTEGER is 2

	Ddl_system: INTEGER is 4

	Ddl_directory: INTEGER is 16

	Ddl_archive: INTEGER is 32

	Ddl_postmsgs: INTEGER is 8192

	Ddl_drives: INTEGER is 16384

	Ddl_exclusive: INTEGER is 32768

end -- class WEL_DDL_CONSTANTS


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

