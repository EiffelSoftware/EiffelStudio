indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DB_TABLE_SELECTION


inherit
	STATE_WINDOW
		redefine
			update_state_information
		end

creation
	make

feature -- basic Operations

	display is 
			-- Display user entries
		do
			build
		end

	build is 
		local
			h1: EV_HORIZONTAL_BOX
		do 
			Create selected_items
			Create unselected_items
			Create h1
			main_box.extend(h1)
			h1.extend(selected_items)
			h1.extend(unselected_items)
		end

	proceed_with_current_info is 
			-- Process user entries
		do 
			proceed_with_new_state(Create {DB_GENERATION_LOCATION}.make(state_information))
		end

	update_state_information is
			-- Check user entries
		local
			li: LINKED_LIST[CLASS_NAME]
			cl_name: CLASS_NAME
		do
			precursor
		end

feature -- Implementation

	selected_items, unselected_items: EV_LIST

end -- class DB_TABLE_SELECTION
