note
	description : "simple application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	SERVICE_FILE

inherit
	WSF_DEFAULT_SERVICE

create
	make_and_launch

feature {NONE} -- Initialization

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			f: WSF_FILE_RESPONSE
		do
			create f.make_html ("home.html")
			res.send (f)
		end
end
