--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Informations given by ArchiVision when a key is pressed or released.
-- Parent of KYPRESS_DATA and KEYREL_DATA

indexing

	date: "$Date$";
	revision: "$Revision$"

class KEY_DATA 

inherit

	CONTEXT_DATA

feature 

	keyboard: KEYBOARD;
			-- State of modifiers key (Shift, control...)

	keycode: INTEGER;
			-- Server-dependent code corresponding to the keystroke

	string: STRING;
			-- String stroked on keyboard

end
