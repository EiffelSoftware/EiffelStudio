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

	Cs_keycvtwindow: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"CS_KEYCVTWINDOW"
		end

	Cs_nokeycvt: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"CS_NOKEYCVT"
		end

	Cs_globalclass: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"CS_GLOBALCLASS"
		end

end -- class WEL_CS_CONSTANTS

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1997, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
