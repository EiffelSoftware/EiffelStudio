indexing

	description:
		"Information given by EiffelVision when an item is double-clicked in %
		%a scroll list";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	CLICK_DATA 

inherit 

	CONTEXT_DATA
		rename
			make as context_data_make
		end

create

	make

feature -- Initialization

	make (a_widget: WIDGET; a_position: INTEGER; an_item: STRING) is
			-- Create a context_data for `click' action.
		do
			widget := a_widget;
			position := a_position;
			item := an_item
		end

feature -- Access

	position: INTEGER;
			-- Position of the double-clicked item

	item: STRING;
			-- Double-clicked item

end -- CLICK_DATA

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

