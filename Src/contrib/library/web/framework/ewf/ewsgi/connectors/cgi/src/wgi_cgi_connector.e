note
	description: "Summary description for {WGI_CGI_CONNECTOR}."
	date: "$Date$"
	revision: "$Revision$"

class
	WGI_CGI_CONNECTOR

inherit
	WGI_CONNECTOR

create
	make

feature {NONE} -- Initialization

	make (a_service: like service)
		do
			service := a_service
		end

feature -- Access

	Name: STRING_8 = "CGI"
			-- Name of Current connector

	Version: STRING_8 = "0.1"
			-- Version of Current connector	

feature {NONE} -- Access

	service: WGI_SERVICE
			-- Gateway Service			

feature -- Execution

	launch
		local
			req: WGI_REQUEST_FROM_TABLE
			res: detachable WGI_RESPONSE_STREAM
			rescued: BOOLEAN
		do
			if not rescued then
				create req.make ((create {EXECUTION_ENVIRONMENT}).starting_environment_variables, create {WGI_CGI_INPUT_STREAM}.make, Current)
				create res.make (create {WGI_CGI_OUTPUT_STREAM}.make, create {WGI_CGI_ERROR_STREAM}.make)
				service.execute (req, res)
				res.push
			else
				if attached (create {EXCEPTION_MANAGER}).last_exception as e and then attached e.exception_trace as l_trace then
					if res /= Void then
						if not res.status_is_set then
							res.set_status_code ({HTTP_STATUS_CODE}.internal_server_error, Void)
						end
						if res.message_writable then
							res.put_string ("<pre>")
							res.put_string (l_trace)
							res.put_string ("</pre>")
						end
						res.push
					end
				end
			end
		rescue
			if not rescued then
				rescued := True
				retry
			end
		end

note
	copyright: "2011-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
