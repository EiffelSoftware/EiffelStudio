indexing

	description:
		"Information given by EiffelVision when an item is selected or unselected %
		%a scroll_list with a multiple or extended selection activated";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class MULTIPL_DATA 

obsolete
	"Use class CONTEXT_DATA instead."

inherit 

	SINGLE_DATA
		rename
			make as single_data_make
		redefine
			position, item
		end

create

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

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

