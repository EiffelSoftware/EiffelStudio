indexing
	description: "Vision2 Widget containing Active X Web Browser control for web browsing."
	date: "$Date$"
	revision: "$Revision$"

class
	WEB_BROWSER_WIDGET
	
inherit
	EV_VERTICAL_BOX
	
	TEXT_OBSERVER
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

feature -- Status Setting

	set_document (a_doc: DOCUMENT) is
			-- Set `document'		
		do			
		end
		
	update is
			-- Update
		do			
		end		

end -- class DOCUMENT_BROWSER
