indexing
	description: "Clipping capabilities (CP) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CLIPPING_CAPABILITIES_CONSTANTS

feature -- Access

	Cp_none: INTEGER is
			-- Output is not clipped
		external
			"C [macro <wel.h>]"
		alias
			"CP_NONE"
		end

	Cp_rectangle: INTEGER is
			-- Output is clipped to rectangles
		external
			"C [macro <wel.h>]"
		alias
			"CP_RECTANGLE"
		end

	Cp_region: INTEGER is
			-- Output is clipped to regions
		external
			"C [macro <wel.h>]"
		alias
			"CP_REGION"
		end

end -- class WEL_CLIPPING_CAPABILITIES_CONSTANTS

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
