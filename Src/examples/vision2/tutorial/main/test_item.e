indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_ITEM

inherit
	DEMO_ITEM
		redefine
			demo_window
		end


creation
	make

feature {NONE} -- Initialization

	make (par: EV_TREE_ITEM_HOLDER) is
			-- Create the item and the demo that
			-- goes with it.
		do
			make_with_title (par, "TEST_ITEM")
		end

feature -- Access

	create_demo is
	do
		!! demo_window.make (demo_page)
	end

	demo_window : TEST_WINDOW

end -- class TEST_ITEM
