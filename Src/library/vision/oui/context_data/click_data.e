--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Information given by ArchiVision when an item is double-clicked in
-- a scroll list.

indexing

	date: "$Date$";
	revision: "$Revision$"

class CLICK_DATA 

inherit 

	CONTEXT_DATA
		rename
			make as context_data_make
		end

creation

	make

feature 

	position: INTEGER;
			-- Position of the double-clicked item

	item: STRING;
			-- Double-clicked item

	make (a_widget: WIDGET; a_position: INTEGER; an_item: STRING) is
			-- Create a context_data for `click' action.
		do
			widget := a_widget;
			position := a_position;
			item := an_item
		end

end
