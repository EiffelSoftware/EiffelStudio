note
	description: "Common interface for any request execution."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WGI_EXECUTION

--create
--	make

feature {NONE} -- Initialization

	make (req: WGI_REQUEST; res: WGI_RESPONSE)
			-- Create current execution with request `req' and response `res'.
		do
			request := req
			response := res
		end

feature {WGI_EXECUTION} -- Access

	request: WGI_REQUEST
			-- Request data.

	response: WGI_RESPONSE
			-- Response interface.

feature -- Execution

	execute
			-- Execute the request based on `request' and `response'.
		deferred
		ensure
			is_valid_end_of_execution: is_valid_end_of_execution
		end

feature -- Status report

	is_valid_end_of_execution: BOOLEAN
			-- Last `execute' completed in valid state?
		do
			Result := True
		end

feature -- Cleaning

	clean
			-- Clean request data.
		do
		end

invariant

	wgi_request_set: request /= Void
	wgi_response_set: response /= Void


note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
