note
	description: "[
				Object to represent a full message to be send to the client 
				via {WSF_RESPONSE}.send (obj)
				
				The only requirement is to implement correctly the `send_to (WSF_RESPONSE)'
				method.
			]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_RESPONSE_MESSAGE

feature {WSF_RESPONSE} -- Output

	send_to (res: WSF_RESPONSE)
			-- Send Current message to `res'
			--
			-- This feature should be called via `{WSF_RESPONSE}.send (obj)'
			-- where `obj' is the current object
		require
			header_not_committed: not res.header_committed
			status_not_committed: not res.status_committed
			no_message_committed: not res.message_committed
		deferred
		ensure
			res_status_set: res.status_is_set
		end

note
	copyright: "2011-2013, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
