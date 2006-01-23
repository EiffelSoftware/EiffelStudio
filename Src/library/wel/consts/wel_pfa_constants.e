indexing
	description: "Paragraph format alignment (PFA) constants for the rich %
		%edit control."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_PFA_CONSTANTS

feature -- Access

	Pfa_left: INTEGER is 1
			-- Paragraphs are aligned with the left margin.

	Pfa_right: INTEGER is 2
			-- Paragraphs are aligned with the right margin.
			
	Pfa_center: INTEGER is 3
			-- Paragraphs are centered.
		
	Pfa_justify: INTEGER is 4
			-- Paragraphs are justified.
		
	Pfa_full_interword: INTEGER is 5;
			-- Paragraphs are justified by expanding blanks alone.
			
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




end -- class WEL_PFA_CONSTANTS

