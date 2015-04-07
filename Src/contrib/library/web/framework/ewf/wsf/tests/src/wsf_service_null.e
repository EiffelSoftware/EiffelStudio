note
	description: "[
	Mock implementation of the WGI_SERVICE interface.

	Used for testing the ewf core and also web applications
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_SERVICE_NULL

inherit

	WSF_SERVICE


feature -- Execute	
	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute the request
			-- See `req.input' for input stream
    		--     `req.meta_variables' for the CGI meta variable
			-- and `res' for output buffer
		do
		end
end
