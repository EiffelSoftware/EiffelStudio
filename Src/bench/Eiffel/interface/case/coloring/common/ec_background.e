indexing

	description: "Figures which have a background color";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	EC_BACKGROUND 

feature -- Access 

	background_color: EV_COLOR;
			-- background color of current figure

feature -- Element change

	set_background_color (a_color: like background_color) is
			-- Set `background_color' to `a_color'.
		do
			background_color := a_color;
		ensure
			background_color = a_color
		end

end -- class BACKGROUND


