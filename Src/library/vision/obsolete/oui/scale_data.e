--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Information given by ArchiVision when a scale value's value has been
-- changed.

indexing

	date: "$Date$";
	revision: "$Revision$"

class SCALE_DATA 

inherit 

	CONTEXT_DATA
		rename
			make as context_data_make
		end

creation

	make

feature 

	value: INTEGER;
			-- New value of scale

	make (a_widget: WIDGET; a_value: INTEGER) is
			-- Create a context_data for `value changed' action.
		do
			widget := a_widget;
			value := a_value
		end

end
