--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Information given by ArchiVision when `NoExpose' event is triggered.
-- Not implemented because ArchiVision doesn't yet give any features
-- to copy areas of window and so this event should never be triggered.
-- X event associated: `NoExpose'.

indexing

	date: "$Date$";
	revision: "$Revision$"

class NOEXP_DATA 

inherit

	CONTEXT_DATA
		undefine
			make
		end

creation

	make

feature 

	make (a_widget: WIDGET) is
			-- Create a context_data for `NoExpose' event.
		do
			widget := a_widget
		end

end
