indexing
	description: "Objects that demonstrate adding items%
		%to EV_NTOEBOOK."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	NOTEBOOK_EXTEND_TEST
	
inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

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

	notebook: EV_NOTEBOOK;
		-- Widget that test is to be performed on.

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


end -- class NOTEBOOK_EXTEND_TEST
