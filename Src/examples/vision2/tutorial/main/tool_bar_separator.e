indexing
	description: "The demo that goes with the composed item node"
	author: "Ian King"
	date: "$Date$"
	revision: "$Revision$"

class
	TOOL_BAR_SEPARATOR

inherit
		DEMO_ITEM
			redefine
				demo_window
			end

creation
	make

feature -- Initialization

	make (par: EV_TREE_ITEM_HOLDER) is
			-- Initialize
		do
			make_with_title (par, "TOOL_BAR_SEPARATOR")
		end

	create_demo is
			-- Create the demo_window
		do
			!! demo_window.make (demo_page)
		end

feature -- Access

	demo_window: TEST_WINDOW



end -- class MULTI_COLUMN_LIST_ROW_ITEM
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

