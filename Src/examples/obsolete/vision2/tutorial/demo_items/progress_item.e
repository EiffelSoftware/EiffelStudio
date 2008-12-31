note
	description:
		"A Demo for progress-bars."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class 
	PROGRESS_ITEM

inherit
	DEMO_ITEM
		redefine
			demo_window
		end

create
	make

feature {NONE} -- Initialization

	make (par:EV_TREE_ITEM_HOLDER)
			-- Create the item and the demo that
			-- goes with it.
		do
			make_with_title (par, "EV_PROGRESS_BAR")
			set_example_path("demo_windows/progess_window.e")
			set_docs_path("documentation/progress_documentation.txt")
			set_class_path("ev_progress_bar")
		end

	create_demo
			-- Create the demo_window.
		do
			create demo_window.make (demo_page)
		end

feature -- Access

	demo_window: PROGRESS_WINDOW;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class PROGRESS_ITEM

