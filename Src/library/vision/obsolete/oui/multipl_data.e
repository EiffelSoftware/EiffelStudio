--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Information given by ArchiVision when an item is selected or unselected
-- a scroll_list with a multiple or extended selection activated.

indexing

	date: "$Date$";
	revision: "$Revision$"

class MULTIPL_DATA 

inherit 

	SINGLE_DATA
		rename
			make as single_data_make
		redefine
			position, item
		end

creation

	make

feature 

	position: INTEGER;
			-- Position of the last selected or unselected item

	item: STRING;
			-- Last selected or unselected item

	positions: LINKED_LIST [INTEGER];
			-- Positions of the selected or unselected items

	items: LINKED_LIST [STRING];
			-- Selected or unselected items

	make (a_widget: WIDGET; a_position: INTEGER; an_item: STRING; a_positions_list: LINKED_LIST [INTEGER]; an_items_list: LINKED_LIST [STRING]) is
			-- Create a context_data for `single' or `browse' action.
		do
			widget := a_widget;
			position := a_position;
			item := an_item;
			positions := a_positions_list;
			items := an_items_list
		end

end
