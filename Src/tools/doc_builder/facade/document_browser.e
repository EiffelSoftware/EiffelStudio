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

feature -- Commands

--	load_url (a_url: STRING) is
--			-- Load `a_url'
--		do
--		end		
	
	--navigate_back is
			-- Navigate to previous document
	--	do
	--	end	
		
--	navigate_forward is
--			-- Navigate to document loaded before call to `go_back'
--		do
--		end	
	
--	refresh_document is
--			-- Reload the HTML based upon changes made to `document'.  If there is no
--			-- document then simply refresh the loaded url.			
--		do			
--		end			
	
feature -- Statuse Setting

	set_document (a_doc: DOCUMENT) is
			-- Set `document'		
		do			
		end

end -- class DOCUMENT_BROWSER
