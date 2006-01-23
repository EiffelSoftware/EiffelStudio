indexing
	description: "[
		Constants for use by and with EV_PARAGRAPH_FORMAT and
		EV_PARAGRAPH_FORMAT_RANGE_INFORMATION
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PARAGRAPH_CONSTANTS

feature -- Constants

	Alignment_left: INTEGER is 1
		-- Aligned left.
		
	Alignment_center: INTEGER is 2
		-- Aligned center.
		
	Alignment_right: INTEGER is 3
		-- Aligned right.
		
	Alignment_justified: INTEGER is 4
		-- Justified.
		
feature -- Paragraph flags.
		
	Alignment: INTEGER is 1
		-- Alignment is applicable.
	
	Left_margin: INTEGER is 2
		-- Left margin is applicable.
	
	Right_margin: INTEGER is 4
		-- Right margin is applicable.
	
	Top_spacing: INTEGER is 8
		-- Top spacing is applicable.
	
	bottom_spacing: INTEGER is 16
		-- Bottom spacing is applicable.
		
feature -- Contract support

	valid_alignment (an_alignment: INTEGER): BOOLEAN is
			-- Is `an_alignment' a valid alignment?
		do
			Result := an_alignment = alignment_left or else
				an_alignment = alignment_center or else
				an_alignment = alignment_right or else
				an_alignment = alignment_justified
		end
		
	valid_paragraph_flag (a_flag: INTEGER): BOOLEAN is
			-- Is `a_flag' a valid paragraph flag?
			-- Used by EV_PARAGRAPH_FORMAT_RANGE_INFORMATION.
		do
			Result := a_flag <= alignment + left_margin + right_margin + top_spacing + bottom_spacing
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




end -- class EV_PARAGRAPH_CONSTANTS

