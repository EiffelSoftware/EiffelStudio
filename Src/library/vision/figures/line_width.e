indexing

	description: "Figures which define a line width"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	LINE_WIDTH 

feature -- Access 

	line_width: INTEGER;
			-- width of line of current figure

feature -- Element change

	set_line_width (a_line_width: INTEGER) is
			-- Set `line_width' of current figure to `a_line_width'.
		require
			a_line_width_positive: a_line_width >= 0
		do
			line_width := a_line_width;
		ensure
			line_width = a_line_width
		end;

invariant

	line_width >= 0

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




end -- class LINE_WIDTH

