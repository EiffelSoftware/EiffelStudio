indexing
	description:
		"A Demo for gauge items"
	author: ""
	date: "$Date: 1999/07/21"
	revision: "$Revision$"

class
	GAUGE_ITEM

	inherit
		DEMO_ITEM
		redefine
			demo_window
		end

creation
	make

feature {NONE} -- Initialization
	make (par:EV_TREE_ITEM_HOLDER) is
			-- Create the item and the demo that goes with it.
		do
			make_with_title (par, "EV_GAUGE")
			set_example_path("demo_windows/gauge_window.e")
			set_docs_path("documentation/gauge_documentation.txt")
			set_class_path("ev_gauge")
		end


	create_demo is
			-- Create the demo window
		do
			!!demo_window.make (demo_page)
		end

feature -- Access

	demo_window: GAUGE_WINDOW

end -- class GAUGE_ITEM
