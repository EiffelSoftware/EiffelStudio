indexing

	description:
		"State of the mouse buttons. %
		%The number of buttons is five, %
		%by convention"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	BUTTONS 

inherit

	ARRAY [BOOLEAN]
		rename
			make as make_array
		export
			{NONE} all;
			{ANY} item, put
		end

create

	make

feature -- Initialization

	make (nb_buttons: INTEGER) is
			-- Create an array of five logical 
			-- mouse buttons.
		require
			at_least_one_button: nb_buttons >= 1
		do
			make_array (1, nb_buttons)
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




end -- class BUTTONS

