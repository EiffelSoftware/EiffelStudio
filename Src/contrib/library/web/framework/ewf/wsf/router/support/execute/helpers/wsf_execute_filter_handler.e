note
	description: "[
				Handler that can also play the role of a filter, i.e.
				than can pre-process incoming data and post-process outgoing data.
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_EXECUTE_FILTER_HANDLER

inherit
	WSF_FILTER_HANDLER [WSF_EXECUTE_HANDLER]

	WSF_EXECUTE_HANDLER

feature -- Execution

	execute_next (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			if attached next as n then
				n.execute (req, res)
			end
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Colin Adams, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
