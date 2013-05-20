note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

deferred class
	WSF_STARTS_WITH_FILTER_HANDLER

inherit
	WSF_FILTER_HANDLER [WSF_STARTS_WITH_HANDLER]

	WSF_STARTS_WITH_HANDLER

feature -- Execution

	execute_next (a_start_path: READABLE_STRING_8; req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			if attached next as n then
				n.execute (a_start_path, req, res)
			end
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
