indexing
	description: "Vision2 Widget containing Active X Web Browser control for web browsing."
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENT_BROWSER
	
inherit
	EV_VERTICAL_BOX
	
	OBSERVER
		undefine
			is_equal,
			copy,
			default_create
		end
	
create
	make

feature -- Creation

	make is 
			-- Create 
		do
			default_create
		end		

feature -- Statuse Setting

	set_document (a_doc: DOCUMENT) is
			-- Set `document'		
		do			
		end
		
	update is
			-- Update
		do			
		end		

end -- class DOCUMENT_BROWSER
