indexing
	description: "The demo that goes with the composed item node"
	date: "$Date$"
	revision: "$Revision$"

class
	MULTI_COLUMN_LIST_ROW_ITEM

inherit
		DEMO_ITEM
			redefine
				demo_window
			end

creation
	make

feature -- Initialization


	make (par: EV_TREE_ITEM_HOLDER) is
		do
			make_with_title (par, "MULTI_COLUMN_LIST_ROW_ITEM")

		end
	

	create_demo is
			-- Create the demo_window
		do
			!!demo_window.make (demo_page)
		end

feature -- Access

	demo_window: TEST_WINDOW



end -- class MULTI_COLUMN_LIST_ROW_ITEM
