indexing
	description: "Brush style (BS) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_BRUSH_STYLE_CONSTANTS

feature -- Access

	Bs_solid: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"BS_SOLID"
		end

	Bs_null: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"BS_NULL"
		end

	Bs_hollow: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"BS_HOLLOW"
		end

	Bs_hatched: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"BS_HATCHED"
		end

	Bs_pattern: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"BS_PATTERN"
		end

	Bs_indexed: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"BS_INDEXED"
		end

	Bs_dibpattern: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"BS_DIBPATTERN"
		end

end -- class WEL_BRUSH_STYLE_CONSTANTS

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
