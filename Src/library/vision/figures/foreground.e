indexing

	description: "Figures which have a foreground color";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	FOREGROUND 

feature -- Access 

	foreground_color: COLOR;
			-- Foreground color of current figure

feature -- Element change

	set_foreground_color (a_color: COLOR) is
			-- Set `foreground_color' to `a_color'.
		require
			color_not_void: a_color /= Void
		do
			foreground_color := a_color;
		end;

end -- class FOREGROUND

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

