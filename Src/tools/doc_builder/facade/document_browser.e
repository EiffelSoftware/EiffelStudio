indexing
	description: "Vision2 Widget containing Active X Web Browser control for web browsing."
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENT_BROWSER
	
inherit
	EV_VERTICAL_BOX
	
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

end -- class DOCUMENT_BROWSER
