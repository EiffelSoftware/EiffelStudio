--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Information given by ArchiVision when a toggle button's value has been
-- changed.

indexing

	date: "$Date$";
	revision: "$Revision$"

class TOGGLE_DATA 

inherit 

	CONTEXT_DATA
		rename
			make as context_data_make
		end

creation

	make

feature 

	state: BOOLEAN;
			-- New state of toggle button

	make (a_widget: WIDGET; a_state: BOOLEAN) is
			-- Create a context_data for `value changed' action.
		do
			widget := a_widget;
			state := a_state
		end

end
