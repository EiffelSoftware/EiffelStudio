--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Information given by ArchiVision when a selection has been converted and
-- stored as a property or when a selection conversion could not be performed.
-- X event associated: `SelectionNotify'.

indexing

	date: "$Date$";
	revision: "$Revision$"

class SELNOT_DATA 

inherit

	CONTEXT_DATA
		undefine
			make
		end

creation

	make

feature 

	make (a_widget: WIDGET) is
			-- Create a context_data for `SelectionNotify' event.
		do
			widget := a_widget
		end

end
