note
	description: "Text Alignment (TA) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TA_CONSTANTS

feature -- Access

	Ta_noupdatecp: INTEGER
			-- The current position is not updated after each text output call.
		external
			"C [macro %"wel.h%"]"
		alias
			"TA_NOUPDATECP"
		end

	Ta_updatecp: INTEGER
			-- The current position is updated after each text output call.
		external
			"C [macro %"wel.h%"]"
		alias
			"TA_UPDATECP"
		end

	Ta_left: INTEGER
			-- The reference point is on the left edge of the bounding rectangle.
		external
			"C [macro %"wel.h%"]"
		alias
			"TA_LEFT"
		end

	Ta_right: INTEGER
				-- The reference point is on the right edge of the bounding rectangle.
		external
			"C [macro %"wel.h%"]"
		alias
			"TA_RIGHT"
		end

	Ta_center: INTEGER
			-- The reference point is aligned horizontally with the center of the bounding rectangle.
		external
			"C [macro %"wel.h%"]"
		alias
			"TA_CENTER"
		end

	Ta_top: INTEGER
			-- The reference point is on the top edge of the bounding rectangle.
		external
			"C [macro %"wel.h%"]"
		alias
			"TA_TOP"
		end

	Ta_bottom: INTEGER
			-- The reference point is on the bottom edge of the bounding rectangle.
		external
			"C [macro %"wel.h%"]"
		alias
			"TA_BOTTOM"
		end

	Ta_baseline: INTEGER
			-- The reference point is on the base line of the text.
		external
			"C [macro %"wel.h%"]"
		alias
			"TA_BASELINE"
		end

feature -- Vertical text alignement

	Vta_baseline: INTEGER
			-- The reference point is on the base line of the text.
		external
			"C [macro <windows.h>]"
		alias
			"VTA_BASELINE"
		end

	Vta_center: INTEGER
			-- The reference point is aligned vertically with the center of the bounding rectangle.
		external
			"C [macro <windows.h>]"
		alias
			"VTA_CENTER"
		end

feature -- Status report

	valid_text_alignment_constant (c: INTEGER): BOOLEAN
			-- Is `c' a valid text alignment constant?
		do
			Result := c = Ta_noupdatecp or else
				c = Ta_updatecp or else
				c = Ta_left or else
				c = Ta_right or else
				c = Ta_center or else
				c = Ta_top or else
				c = Ta_bottom or else
				c = Ta_baseline
		end

	valid_text_alignement_constant (c: INTEGER): BOOLEAN
			-- Is `c' a valid text alignment constant?
		obsolete
			"Use valid_text_alignment_constant instead [2017-05-31]."
		do
			Result := valid_text_alignment_constant (c)
		end


	valid_htext_alignment_constant (c: INTEGER): BOOLEAN
			-- Is `c' a valid text alignment constant for horizontal positioning?
		do
			Result := c = Ta_left or else
				c = Ta_right or else
				c = Ta_center
		end

	valid_vtext_alignment_constant (c: INTEGER): BOOLEAN
			-- Is `c' a valid text alignment constant for vertical positioning?
		do
			Result := c = Ta_top or else
				c = Ta_bottom or else
				c = Ta_baseline
		end

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class WEL_TA_CONSTANTS

