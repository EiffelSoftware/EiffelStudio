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