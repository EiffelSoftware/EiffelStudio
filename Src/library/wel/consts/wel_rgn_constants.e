note
	description: "Regions (RGN) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_RGN_CONSTANTS

feature -- Access

	frozen Rgn_and: INTEGER
		external
			"C [macro %"wel.h%"]"
		alias
			"RGN_AND"
		end

	frozen Rgn_or: INTEGER
		external
			"C [macro %"wel.h%"]"
		alias
			"RGN_OR"
		end

	frozen Rgn_xor: INTEGER
		external
			"C [macro %"wel.h%"]"
		alias
			"RGN_XOR"
		end

	frozen Rgn_diff: INTEGER
		external
			"C [macro %"wel.h%"]"
		alias
			"RGN_DIFF"
		end

	frozen Rgn_copy: INTEGER
		external
			"C [macro %"wel.h%"]"
		alias
			"RGN_COPY"
		end

feature -- Status report

	valid_region_constant (c: INTEGER): BOOLEAN
			-- Is `c' a valid region constant?
		do
			Result := c = Rgn_and or else
				c = Rgn_or or else
				c = Rgn_xor or else
				c = Rgn_diff or else
				c = Rgn_copy
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_RGN_CONSTANTS

