note
	description: "[
		Creates a MINI_REQUEST from a request_message
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XH_REQUEST_MINI_PARSER

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do

		end

feature -- Access

	request (a_request_message: STRING): detachable XH_MINI_REQUEST
			-- Returns a XH_REQUEST if the message could be parsed successfully
		require
			not_a_request_message_is_detached_or_empty: a_request_message /= Void and then not a_request_message.is_empty
		local
			l_message: STRING
		do
			create Result.make_empty
			l_message := a_request_message.twin
			if l_message.has_substring ({XU_CONSTANTS}.Request_post_too_big) then
				Result.set_post_too_big (True)
			end
			if l_message.has_substring ({XU_CONSTANTS}.Request_http) and l_message.has ('/') then
				l_message.remove_tail ( l_message.substring_index ({XU_CONSTANTS}.Request_http, 1))
				Result.set_webapp (l_message.split ('/').i_th (2))
			end
		end
feature -- Status report

feature -- Status setting

feature -- Basic operations

feature {NONE} -- Implementation

invariant

end

