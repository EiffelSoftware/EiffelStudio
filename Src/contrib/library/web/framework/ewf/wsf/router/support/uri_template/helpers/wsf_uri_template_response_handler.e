note
	description: "Summary description for {WSF_URI_TEMPLATE_RESPONSE_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_URI_TEMPLATE_RESPONSE_HANDLER

inherit
	WSF_URI_TEMPLATE_HANDLER

feature -- Response

	response (req: WSF_REQUEST): WSF_RESPONSE_MESSAGE
		require
			is_valid_context: is_valid_context (req)
		deferred
		ensure
			Result_attached: Result /= Void
		end

feature -- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler	
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
