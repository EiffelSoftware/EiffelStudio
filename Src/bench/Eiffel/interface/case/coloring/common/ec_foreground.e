indexing

	description: "Figures which have a foreground color";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	EC_FOREGROUND 

feature -- Access 

	foreground_color: EV_COLOR;
			-- Foreground color of current figure

feature -- Element change

	set_foreground_color (a_color: like foreground_color) is
			-- Set `foreground_color' to `a_color'.
		require
			color_not_void: a_color /= Void
		do
			foreground_color := a_color;
		end;

end -- class FOREGROUND
