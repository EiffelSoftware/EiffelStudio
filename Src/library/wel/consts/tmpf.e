indexing
	description: "Text Metric Pitch and Family (TMPF) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TMPF_CONSTANTS

feature -- Access

	Tmpf_fixed_pitch: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"TMPF_FIXED_PITCH"
		end

	Tmpf_vector: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"TMPF_VECTOR"
		end

	Tmpf_device: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"TMPF_DEVICE"
		end

	Tmpf_truetype: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"TMPF_TRUETYPE"
		end

end -- class WEL_TMPF_CONSTANTS

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
