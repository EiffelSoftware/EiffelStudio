--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Information given by ArchiVision when a callback is triggered.

indexing

	date: "$Date$";
	revision: "$Revision$"

class CONTEXT_DATA 

creation

	make

feature 

	widget: WIDGET;
			-- The widget who triggered the callback

	make (a_widget: WIDGET) is
			-- Create a general context_data.
		do
			widget := a_widget
		end

end
