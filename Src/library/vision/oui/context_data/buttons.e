--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- State of the mouse buttons. 
-- The number of buttons is five,
-- by convention.

indexing

	date: "$Date$";
	revision: "$Revision$"

class BUTTONS 

inherit

	ARRAY [BOOLEAN]
		rename
			make as make_array
		export
			{NONE} all;
			{ANY} item, put
		end

creation

	make

feature 

	make (nb_buttons: INTEGER) is
			-- Create an array of five logical 
			-- mouse buttons.
		require
			at_least_one_button: nb_buttons >= 1
		do
			make_array (1, nb_buttons)
		end

end
