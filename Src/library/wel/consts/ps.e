indexing
	description: "Pen style (PS) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_PS_CONSTANTS

feature -- Access

	Ps_solid: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"PS_SOLID"
		end

	Ps_dash: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"PS_DASH"
		end

	Ps_dot: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"PS_DOT"
		end

	Ps_dashdot: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"PS_DASHDOT"
		end

	Ps_dashdotdot: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"PS_DASHDOTDOT"
		end

	Ps_null: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"PS_NULL"
		end

	Ps_insideframe: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"PS_INSIDEFRAME"
		end

end -- class WEL_PS_CONSTANTS

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
