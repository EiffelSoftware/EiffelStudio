note
	description: "Summary description for {EWF_DEBUG_EXECUTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EWF_DEBUG_EXECUTION

inherit
	WSF_EXECUTION

create
	make

feature -- Execution

	execute
		local
			dbg: WSF_DEBUG_HANDLER
		do
			response.put_error ("DEBUG uri=" + request.request_uri + "%N")
			create dbg.make
			dbg.execute_starts_with ("", request, response)
		end

end
