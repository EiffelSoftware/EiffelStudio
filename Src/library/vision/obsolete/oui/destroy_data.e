--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Information given by ArchiVision when a child of a window has been
-- destroyed.
-- X event associated: `DestroyNotify'.

indexing

	date: "$Date$";
	revision: "$Revision$"

class DESTROY_DATA 

inherit

	CONTEXT_DATA
		undefine
			make
		end

creation

	make

feature 

	make (a_widget: WIDGET) is
			-- Create a context_data for `DestroyNotify' event.
		do
			widget := a_widget
		end

end
