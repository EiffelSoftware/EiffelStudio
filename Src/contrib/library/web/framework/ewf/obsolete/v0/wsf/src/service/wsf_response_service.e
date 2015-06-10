note
	description: "[
		Inherit from this class to implement the main entry of your web service
		You just need to implement `execute', get data from the request `req'
		and return a response message
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_RESPONSE_SERVICE

inherit
	WSF_SERVICE

feature -- Response

	response (req: WSF_REQUEST): WSF_RESPONSE_MESSAGE
		deferred
		ensure
			Result_attached: Result /= Void
		end

feature -- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			res.send (response (req))
		end

note
	copyright: "2011-2012, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
