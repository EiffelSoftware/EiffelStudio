--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Information given by ArchiVision when the selection's owner is asked
-- to change.
-- X event associated: `SelectionRequest'.

indexing

	date: "$Date$";
	revision: "$Revision$"

class SELREQ_DATA 

inherit

	CONTEXT_DATA
		undefine
			make
		end

creation

	make

feature 

	make (a_widget: WIDGET) is
			-- Create a context_data for `SelectionRequest' event.
		do
			widget := a_widget
		end

end
