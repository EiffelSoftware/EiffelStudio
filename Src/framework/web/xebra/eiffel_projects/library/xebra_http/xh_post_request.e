note
	description: "[
		POST version of REQUEST
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XH_POST_REQUEST

inherit
	XH_REQUEST
	redefine
		method
	end

create
	make_from_message,
	make_empty,
	make_goto_request

feature {NONE} -- Initialization

feature -- Constants


feature -- Access

	method: CHARACTER = 'P'

feature -- Implementation

	read_uri (a_the_request: STRING): STRING
		local
			l_i: INTEGER
		do
			l_i := a_the_request.substring_index ("HTTP",1)
			Result := a_the_request.substring (6, l_i-2)
		end

	call_pre_handler (servlet: XWA_SERVLET; a_response: XH_RESPONSE)
			-- <Precursor>
			-- Calls prehandle_post_request
		do
			servlet.handle_form (Current, a_response)
		end
end
