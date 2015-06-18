note
	description: "Request execution based on attributes `request' and `response'. "
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_EXECUTION

inherit
	WGI_EXECUTION
		rename
			request as wgi_request,
			response as wgi_response,
			make_from_execution as make_from_wgi_execution			
		redefine
			make,
			execute,
			clean,
			is_valid_end_of_execution
		end

--create
--	make

feature {NONE} -- Initialization

	frozen make (req: WGI_REQUEST; res: WGI_RESPONSE)
			-- Create Current execution with request `req' and response `res'.
		do
			Precursor (req, res)
			create request.make_from_wgi (wgi_request)
			create response.make_from_wgi (wgi_response)
			initialize
		end

	frozen make_from_execution (a_execution: WSF_EXECUTION)
			-- Create current execution from `a_execution'.
		do
			make_from_wgi_execution (a_execution)
			request := a_execution.request
			response := a_execution.response
			initialize
		end

	initialize
			-- Initialize Current object.
			--| To be redefined if needed.
		do

		end

feature -- Access

	request: WSF_REQUEST
			-- Access to request data.
			-- Header, Query, Post, Input data..

	response: WSF_RESPONSE
			-- Access to output stream, back to the client.

feature -- Execution

	execute
			-- Execute Current request,
			-- getting data from `request'
			-- and response to client via `response'.
		deferred
		end

feature -- Status report

	is_valid_end_of_execution: BOOLEAN
			-- <Precursor>
		do
				--| Note: overwrite precursor implementation
			Result := Precursor and response.status_is_set
		end

	message_writable: BOOLEAN
		do
			Result := response.message_writable
		end

feature -- Helpers

	put_character (c: CHARACTER_8)
			-- Send the character `c'.
		require
			message_writable: message_writable
		do
			response.put_character (c)
		end

	put_string (s: READABLE_STRING_8)
			-- Send the string `s'.
		require
			message_writable: message_writable
		do
			response.put_string (s)
		end

	put_error (err: READABLE_STRING_8)
			-- Report error message `err' on the error output of the associated connector.
		require
			message_writable: message_writable
		do
			response.put_error (err)
		end

feature -- Cleaning

	clean
			-- Precursor
		do
			Precursor
			request.destroy
		end

invariant

	wsf_request_set: request /= Void
	wsf_response_set: response /= Void

note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Colin Adams, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
