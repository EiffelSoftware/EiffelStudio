indexing
	description: "The demo that goes with the composed item node"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

create
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
			create demo_window.make (demo_page)
		end

feature -- Access

	demo_window: TEST_WINDOW;



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


end -- class MULTI_COLUMN_LIST_ROW_ITEM
