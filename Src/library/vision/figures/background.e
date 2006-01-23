indexing

	description: "Figures which have a background color"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	BACKGROUND 

feature -- Access 

	background_color: COLOR;
			-- background color of current figure

feature -- Element change

	set_background_color (a_color: COLOR) is
			-- Set `background_color' to `a_color'.
		do
			background_color := a_color;
		ensure
			background_color = a_color
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




end -- class BACKGROUND

