indexing
	description: "Class Style (CS) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CS_CONSTANTS

feature -- Access

	Cs_vredraw: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"CS_VREDRAW"
		end

	Cs_hredraw: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"CS_HREDRAW"
		end

	Cs_owndc: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"CS_OWNDC"
		end

	Cs_classdc: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"CS_CLASSDC"
		end

	Cs_parentdc: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"CS_PARENTDC"
		end

	Cs_savebits: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"CS_SAVEBITS"
		end

	Cs_dblclks: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"CS_DBLCLKS"
		end

	Cs_bytealignclient: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"CS_BYTEALIGNCLIENT"
		end

	Cs_bytealignwindow: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"CS_BYTEALIGNWINDOW"
		end

	Cs_noclose: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"CS_NOCLOSE"
		end

	Cs_globalclass: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"CS_GLOBALCLASS"
		end

	Cs_nokeycvt: INTEGER is
		obsolete
			"Not defined any more for some %
			%C compilers, returns old defined value"
		do
			Result := 256
		end
	
	Cs_keycvtwindow: INTEGER is
		obsolete
			"Not defined any more for some %
			%C compilers, returns old defined value"
		do
			Result := 4
		end

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

