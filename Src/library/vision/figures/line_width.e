--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                      (805) 685-1006                                --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- LINE_WIDTH: Figure who degine a line width.

indexing

	date: "$Date$";
	revision: "$Revision$"

class LINE_WIDTH 

feature 

	line_width: INTEGER;
			-- width of line of current figure

	set_line_width (a_line_width: INTEGER) is
			-- Set `line_width' of current figure to `a_line_width'.
		require
			a_line_width_positive: a_line_width >= 0
		do
			line_width := a_line_width
		ensure
			line_width = a_line_width
		end;

invariant

	line_width >= 0

end
