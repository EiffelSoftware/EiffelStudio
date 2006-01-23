indexing
	description:
		"The demo that goes with the button demo"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
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

create
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

	action_item: EV_MULTI_COLUMN_LIST_ROW;
			-- Tha action row.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class MC_ITEM_WINDOW

