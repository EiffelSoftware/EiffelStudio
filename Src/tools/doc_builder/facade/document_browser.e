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
		end

feature -- Commands

	load_document_html (a_doc_loc, a_doc_html_loc: STRING) is
			-- Load html document
		do
		end		

	load_document_xml (a_doc_loc, a_doc_xml_loc: STRING) is
			-- Load xml document
		do
		end	

end -- class DOCUMENT_BROWSER
