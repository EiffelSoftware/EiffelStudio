--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Information given by ArchiVision just after a `EnterNotify' or
-- `FocusIn' events.
-- X event associated: `KeymapNotify'.

indexing

	date: "$Date$";
	revision: "$Revision$"

class KEYMAP_DATA 

inherit

	CONTEXT_DATA
		undefine
			make
		end

creation

	make

feature 

	make (a_widget: WIDGET) is
			-- Create a context_data for `KeymapNotify' event.
		do
			widget := a_widget
		end

end
