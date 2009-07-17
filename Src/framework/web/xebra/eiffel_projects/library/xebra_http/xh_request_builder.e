note
	description: "[
		Provides a means to create different types of requests.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XH_REQUEST_BUILDER

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
		end

feature -- Access

feature -- Basic operations

	create_goto_request (a_url: STRING; a_previous_request: XH_REQUEST): XH_REQUEST
			-- Creates a goto request
		require
			not_a_url_is_detached_or_empty: a_url /= Void and then not a_url.is_empty
			a_previous_request_attached: a_previous_request /= Void
		local
			l_parser: XH_REQUEST_PARSER
			l_temp: STRING
		do
			create Result.make_empty
			create l_parser.make

			l_temp := a_previous_request.method + " " + a_url + " " + a_previous_request.request_message.split (' ').i_th (3)
			if attached {XH_REQUEST} l_parser.request (l_temp) as l_rec then
				Result := l_rec
			end
		ensure
			result_attached: Result /= Void
		end

end
