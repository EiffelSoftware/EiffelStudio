indexing
	description: "Objects that demonstrate adding items%
		%to EV_NTOEBOOK."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NOTEBOOK_EXTEND_TEST
	
inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Implementation

	default_create is
			-- Create `Current' and initialize test in `widget'.
		do
			create notebook
			notebook.set_minimum_size (200, 200)
			notebook.extend (create {EV_BUTTON}.make_with_text ("Notebook item 1"))
			notebook.extend (create {EV_BUTTON}.make_with_text ("Notebook item 2"))
			notebook.extend (create {EV_BUTTON}.make_with_text ("Notebook item 3"))
			
			widget := notebook
		end
		
feature {NONE} -- Implementation

	notebook: EV_NOTEBOOK

end -- class NOTEBOOK_EXTEND_TEST
