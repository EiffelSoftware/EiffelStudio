indexing
	description: "Font pitch constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_FONT_PITCH_CONSTANTS

feature -- Access

	Default_pitch: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"DEFAULT_PITCH"
		end

	Fixed_pitch: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"FIXED_PITCH"
		end

	Variable_pitch: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"VARIABLE_PITCH"
		end

end -- class WEL_FONT_PITCH_CONSTANTS

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
