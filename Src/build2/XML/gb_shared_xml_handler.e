indexing
	description: "Objects that provide access to a GB_XML_HANDLER"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_SHARED_XML_HANDLER

feature {GB_COMPONENT} -- Implementation

	xml_handler: GB_XML_HANDLER is
			-- `Result' is the GB_XML_HANDLER used by
			-- the system. There should only be one handler.
			-- Any class that needs access, simply inherits from
			-- this class.
		once
			create Result
		end

end -- class GB_ACCESSIBLE_XML_HANDLER
