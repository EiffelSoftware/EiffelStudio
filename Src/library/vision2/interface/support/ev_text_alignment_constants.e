indexing
	description: "Constants for use by and with EV_TEXT_ALIGNABLE."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TEXT_ALIGNABLE_CONSTANTS

feature -- Constants

	Ev_text_alignment_left: INTEGER is 1
		-- Aligned left.
		
	Ev_text_alignment_center: INTEGER is 2
		-- Aligned center.
		
	Ev_text_alignment_right: INTEGER is 3
		-- Aligned right.
		
feature -- Contract support

	valid_alignment (an_alignment: INTEGER): BOOLEAN is
			-- Is `an_alignment' a valid alignment?
		do
			Result := an_alignment = Ev_text_alignment_left or else
				an_alignment = Ev_text_alignment_center or else
				an_alignment = Ev_text_alignment_right	
		end

end -- class EV_TEXT_ALIGNABLE_CONSTANTS
