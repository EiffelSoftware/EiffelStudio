--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Informations given by ArchiVision when a key is released.
-- X event associated: `KeyRelease'.

indexing

	date: "$Date$";
	revision: "$Revision$"

class KEYREL_DATA 

inherit

	KEY_DATA
		rename
			make as key_data_make
		end

creation

	make

feature 

	make (a_widget: WIDGET; a_keycode: INTEGER; a_string: STRING; a_keyboard: KEYBOARD) is
			-- Create a context_data for `KeyRelease' event.
		do
			widget := a_widget;
			keycode := a_keycode;
			string := a_string;
			keyboard := a_keyboard
		end

end
