indexing
	description: "Objects that display how many times a tab has been selected%
		%in an EV_NOTEBOOK"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NOTEBOOK_SELECTION_ACTIONS_TEST
	
inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Implementation

	default_create is
			-- Create `Current' and initialize test in `widget'.
		local
			item_counter: INTEGER
			button: EV_BUTTON
		do
			create notebook
			notebook.set_minimum_size (200, 200)
			from
				item_counter := 1
			until
				item_counter > 4
			loop
				create button.make_with_text ("Button : " + item_counter.out)
				notebook.extend (button)
				notebook.set_item_text (button, "0")
				item_counter := item_counter + 1
			end
			
				-- Connect to `selection_actions'
			notebook.selection_actions.extend (agent display_selection_count)

			widget := notebook
		end
		
	display_selection_count is
			-- Display the number of times an item has been selected
			-- as part of the associated `item_text'.
			-- Rather than having a counter for each tab, we simply retrieve the
			-- text of the tab, convert it to an integer, increase it by one, and
			-- then set it back to the tab.
		local
			current_value: INTEGER
			current_text: STRING
		do
			current_text := notebook.item_text (notebook.selected_item)
			check
				current_text_is_integer: current_text.is_integer
			end
			current_value := current_text.to_integer
			notebook.set_item_text (notebook.selected_item, (current_value + 1).out)
		end
	
feature {NONE} -- Implementation

	notebook: EV_NOTEBOOK

end -- class NOTEBOOK_SELECTION_ACTIONS_TEST
