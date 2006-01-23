indexing
	description: "Text Metric Pitch and Family (TMPF) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TMPF_CONSTANTS

feature -- Access

	Tmpf_fixed_pitch: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"TMPF_FIXED_PITCH"
		end

	Tmpf_vector: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"TMPF_VECTOR"
		end

	Tmpf_device: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"TMPF_DEVICE"
		end

	Tmpf_truetype: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"TMPF_TRUETYPE"
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_TMPF_CONSTANTS

