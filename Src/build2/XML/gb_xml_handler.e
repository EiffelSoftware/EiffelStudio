indexing
	description: "Objects that manipulate XML for saving/loading and possibly other%
		%internal uses."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_XML_HANDLER

inherit
	
	INTERNAL
	
	GB_CONSTANTS

create
	initialize

feature -- Initialization

	initialize is
			-- `Create' Current and initialize.
		do
			
		end
		
feature -- Basic operations

	save is
			-- Save the currently built window to XML.
		local
			xml_store: GB_XML_STORE
		do
			create xml_store
			xml_store.store
		end
		
	load is
			-- Retrieve the current built window from XML
		local
			xml_load: GB_XML_LOAD
		do
			create xml_load
			xml_load.load
		end
		
		

end -- class GB_XML_HANDLER
