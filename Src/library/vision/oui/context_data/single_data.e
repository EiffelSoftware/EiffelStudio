indexing

	description:
		"Information given by EiffelVision when an item is selected or unselected %
		%a scroll_list with a single or browse selection activated";
	status: "See notice at end of class";
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


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
