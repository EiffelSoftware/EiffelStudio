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
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

