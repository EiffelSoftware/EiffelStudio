--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Information given by ArchiVision when a mouse's button is pressed or
-- released.
-- X events associated: `ButtonPress' or `ButtonRelease'.

indexing

	date: "$Date$";
	revision: "$Revision$"

class BUTTON_DATA 

inherit

	CONTEXT_DATA

feature 

	absolute_x: INTEGER;
			-- Absolute horizontal position of the pointer (in other words
			-- relative to the screen)

	absolute_y: INTEGER;
			-- Absolute vertical position of the pointer (in other words
			-- relative to the screen)

	button: INTEGER;
			-- Button that triggered event

	buttons_state: BUTTONS;
			-- State of buttons just before the event occurs

	relative_x: INTEGER;
			-- Horizontal position of the pointer relative to the receiving
			-- window

	relative_y: INTEGER
			-- Vertical position of the pointer relative to the receiving
			-- window

invariant

	not (buttons_state = Void)

end
