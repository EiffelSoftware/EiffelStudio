indexing
	description:
		"The demo that goes with the button demo";
	date: "$Date$";
	revision: "$Revision$"

class
	MC_ITEM_WINDOW

inherit
	DEMO_WINDOW

	EV_MULTI_COLUMN_LIST
		redefine
			make
		end

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in `par'.
		local
			item: EV_MULTI_COLUMN_LIST_ROW
		do
			make_with_text (par, <<"First name", "Middle name", "Last name", "SSN", "Date of birth">>)
			set_columns_width (<<100, 100, 100, 50, 50>>)
			create item.make_with_text (Current, <<"Happy", "New", "Millenium", "123-45-6789", "01/01/00">>)
			create item.make_with_text (Current, <<"John", "H.", "Smith", "524-45-6871", "12/31/99">>)
			create action_item.make_with_text (Current, <<"Austin", "Action", "Powers", "000-00-0000", "??/??/??">>)
			create item.make_with_text (Current, <<"Isabelle", "Sylvie", "Murdock", "587-94-6782", "08/24/75">>)
		end

	set_tabs is
			-- Set the tabs for the action window.
		do
		end

feature -- Access

	action_item: EV_MULTI_COLUMN_LIST_ROW
			-- Tha action row.

end -- class MC_ITEM_WINDOW

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

