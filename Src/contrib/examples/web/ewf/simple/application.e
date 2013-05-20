note
	description : "simple application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

inherit
	WSF_DEFAULT_SERVICE

create
	make_and_launch

feature {NONE} -- Initialization

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			-- To send a response we need to setup, the status code and
			-- the response headers.
			res.put_header ({HTTP_STATUS_CODE}.ok, <<["Content-Type", "text/plain"], ["Content-Length", "11"]>>)
			res.put_string ("Hello World")
		end

end
