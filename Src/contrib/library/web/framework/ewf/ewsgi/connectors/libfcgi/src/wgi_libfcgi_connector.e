note
	description: "libFCGI connector, see libfcgi and http://fastcgi.com"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WGI_LIBFCGI_CONNECTOR [G -> WGI_EXECUTION create make end]

inherit
	WGI_CONNECTOR
		redefine
			default_create
		end

	SHARED_HTML_ENCODER
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
			-- Create libFCGI connector.
		do
			Precursor {WGI_CONNECTOR}
			create fcgi.make
			create input.make (fcgi)
			create output.make (fcgi)
		end

feature -- Access

	Name: STRING_8 = "libFCGI"
			-- Name of Current connector

	Version: STRING_8 = "0.1"
			-- Version of Current connector		

feature -- Server

	launch
			-- Launch libFCGI server.
		local
			res: INTEGER
		do
			from
				res := fcgi.fcgi_listen
			until
				res < 0
			loop
				process_fcgi_request (fcgi.updated_environ_variables, input, output)
				res := fcgi.fcgi_listen
			end
		end

feature -- Execution

	process_fcgi_request (vars: STRING_TABLE [READABLE_STRING_8]; a_input: like input; a_output: like output)
			-- Process the request with variables `vars', input `a_input' and output `a_output'.
		local
			req: WGI_REQUEST_FROM_TABLE
			res: detachable WGI_RESPONSE_STREAM
			exec: detachable WGI_EXECUTION
			rescued: BOOLEAN
		do
			if not rescued then
				a_input.reset
				create req.make (vars, a_input, Current)
				create res.make (a_output, a_output)
				create {G} exec.make (req, res)
				exec.execute
				res.push
				exec.clean
			else
				process_rescue (res)
				if exec /= Void then
					exec.clean
				end
			end
		rescue
			if not rescued then
				rescued := True
				retry
			end
		end

	process_rescue (res: detachable WGI_RESPONSE)
			-- Handle rescued execution of current request.
		do
			if attached (create {EXCEPTION_MANAGER}).last_exception as e and then attached e.trace as l_trace then
				if res /= Void then
					if not res.status_is_set then
						res.set_status_code ({HTTP_STATUS_CODE}.internal_server_error, Void)
					end
					if res.message_writable then
						res.put_string ("<pre>")
						res.put_string (html_encoder.encoded_string (l_trace))
						res.put_string ("</pre>")
					end
					res.push
				end
			end
		end

feature -- Input/Output

	input: WGI_LIBFCGI_INPUT_STREAM
			-- Input from client (from httpd server via FCGI)

	output: WGI_LIBFCGI_OUTPUT_STREAM
			-- Output to client (via httpd server/fcgi)

feature {NONE} -- Implementation

	fcgi: FCGI

invariant
	fcgi_attached: fcgi /= Void

note
	copyright: "2011-2015, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
