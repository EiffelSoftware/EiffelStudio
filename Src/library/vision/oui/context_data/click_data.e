
-- Information given by ArchiVision when an item is double-clicked in
-- a scroll list.

indexing

	copyright: "See notice at end of class";
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


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
