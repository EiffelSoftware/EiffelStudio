indexing

	description: "Figures which define a line width";
	status: "See notice at end of class";
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

end -- class LINE_WIDTH

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------

