indexing
	description: "Class Style (CS) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CS_CONSTANTS

feature -- Access

	Cs_vredraw: INTEGER is 1

	Cs_hredraw: INTEGER is 2

	Cs_dblclks: INTEGER is 8

	Cs_owndc: INTEGER is 32

	Cs_classdc: INTEGER is 64

	Cs_parentdc: INTEGER is 128

	Cs_noclose: INTEGER is 512

	Cs_savebits: INTEGER is 2048

	Cs_bytealignclient: INTEGER is 4096

	Cs_bytealignwindow: INTEGER is 8192

	Cs_globalclass: INTEGER is 16384

	Cs_nokeycvt: INTEGER is 256
			-- Not defined any more for some 
			-- C compilers, returns old defined value
	
	Cs_keycvtwindow: INTEGER is 4
			-- Not defined any more for some 
			-- C compilers, returns old defined value

end -- class WEL_CS_CONSTANTS

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

