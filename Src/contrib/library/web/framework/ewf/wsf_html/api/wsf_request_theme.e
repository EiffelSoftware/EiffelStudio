note
	description: "[
				WF_THEME associated with a request
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_REQUEST_THEME

inherit
	WSF_THEME

create
	make_with_request

feature {NONE} -- Initialization

	make_with_request (req: WSF_REQUEST)
		do
			request := req
		end

	request: WSF_REQUEST
			-- Associated  request

feature -- Core

	site_url: READABLE_STRING_8
		do
			Result := request.absolute_script_url ("")
		end

	base_url: detachable READABLE_STRING_8
			-- Base url if any.
		do
			Result := request.script_url ("")
		end

end
