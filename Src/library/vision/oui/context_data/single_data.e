--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Information given by ArchiVision when an item is selected or unselected
-- a scroll_list with a single or browse selection activated.

indexing

	date: "$Date$";
	revision: "$Revision$"

class SINGLE_DATA 

inherit 

	CLICK_DATA
		rename
			make as click_data_make
		redefine
			position, item
		end

creation

	make

feature 

	position: INTEGER;
			-- Position of the selected or unselected item

	item: STRING;
			-- selected or unselected item

	make (a_widget: WIDGET; a_position: INTEGER; an_item: STRING) is
			-- Create a context_data for `single' or `browse' action.
		do
			widget := a_widget;
			position := a_position;
			item := an_item
		end

end
