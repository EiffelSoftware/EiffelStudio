indexing
	description: "Objects that demonstrate setting%
		%item texts in an EV_NOTEBOOK"
	date: "$Date$"
	revision: "$Revision$"

class
	NOTEBOOK_ITEM_TEXT_TEST
	
inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create is
			-- Create `Current' and initialize test in `widget'.
		local
			button1, button2: EV_BUTTON
		do
			create notebook
			notebook.set_minimum_size (200, 200)
			create button1.make_with_text ("Notebook item 1")
			create button2.make_with_text ("Notebook item 2")
			
			notebook.extend (button1)
			notebook.extend (button2)
			notebook.extend (create {EV_BUTTON}.make_with_text ("Notebook item 3"))
			
			notebook.set_item_text (button1, "First item")
			notebook.set_item_text (button2, "Second item")
			
				-- As we do not have a reference to the third item,
				-- we query the notebook.
			notebook.set_item_text (notebook.i_th (3), "Third item")
			
			widget := notebook
		end
		
feature {NONE} -- Implementation

	notebook: EV_NOTEBOOK
		-- Widget that test is to be performed on.

end -- class NOTEBOOK_ITEM_TEXT_TEST
