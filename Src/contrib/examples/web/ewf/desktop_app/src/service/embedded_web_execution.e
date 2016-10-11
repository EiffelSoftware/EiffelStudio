note
	description: "Summary description for {EMBEDDED_WEB_EXECUTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EMBEDDED_WEB_EXECUTION

inherit
	WSF_EXECUTION
		rename
			execute as execute_embedded
		end

	SHARED_EMBEDED_WEB_SERVICE_INFORMATION

feature {NONE} -- Execution

	execute_embedded
			-- Execute the request
			-- See `request.input' for input stream
    		--     `request.meta_variables' for the CGI meta variable
			-- and `response' for output buffer
		local
			m: WSF_PAGE_RESPONSE
		do
			if local_connection_restriction_enabled then
				if
					attached request.remote_addr as l_remote_addr and then
					(
						l_remote_addr.is_case_insensitive_equal_general ("127.0.0.1")
						or else l_remote_addr.is_case_insensitive_equal_general ("localhost")
					)
				then
					execute
				else
					create m.make_with_body ("Only local connection is allowed")
					m.set_status_code (403) -- Forbidden
					response.send (m)
				end
			else
				execute
			end
		end

	execute
		deferred
		end

feature -- Status report

	local_connection_restriction_enabled: BOOLEAN
			-- Accept only local connection?
			--| based on 127.0.0.1 IP
			--| TO IMPROVE

feature -- Change

	set_local_connection_restriction_enabled (b: BOOLEAN)
		do
			local_connection_restriction_enabled := b
		end

end
