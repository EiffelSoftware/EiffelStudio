
-- BACKGROUND: Figure who have a background color.

indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class BACKGROUND 

feature -- Access 

	background_color: COLOR;
			-- background color of current figure

feature -- Modification & Insertion

	set_background_color (a_color: COLOR) is
			-- Set `background_color' to `a_color'.
		do
			background_color := a_color;
		ensure
			background_color = a_color
		end

end -- class BACKGROUND


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
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
