note
	description: "[
			Request execution based on attributes `request' and `response'.
			And returning the response as a `message'.
		 ]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_MESSAGE_EXECUTION

inherit
	WSF_EXECUTION

feature -- Execution

	execute
			-- <Precursor>
		do
			response.send (message)
		end

	message: WSF_RESPONSE_MESSAGE
			-- Message to be sent to the `response'.
		deferred
		ensure
			Result_set: Result /= Void
		end

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
