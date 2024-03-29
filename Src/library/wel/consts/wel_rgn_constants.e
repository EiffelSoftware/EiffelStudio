note
	description: "Regions (RGN) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_RGN_CONSTANTS

feature -- Access

	error, rgn_error: INTEGER = 0
			-- No region was created.

	null_regiion: INTEGER = 1
			-- Region is empty.

	simple_region: INTEGER = 2
			-- Region is a single rectangle.

	complex_region: INTEGER = 3
			-- Region is more than one rectangle.

	complex_regision: INTEGER
		obsolete
			"Use complex_region [2023-03-29]"
		once
			Result := complex_region
		ensure
			instance_free: class
		end

	rgn_and, rgn_min: INTEGER = 1
	rgn_or: INTEGER = 2
	rgn_xor: INTEGER = 3
	rgn_diff: INTEGER = 4
	rgn_copy, rgn_max: INTEGER = 5

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
	copyright:	"Copyright (c) 1984-2011, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
