indexing
	description: "Constants for use by and with EV_TEXT_ALIGNABLE."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TEXT_ALIGNMENT_CONSTANTS

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




end -- class EV_TEXT_ALIGNMENT_CONSTANTS

