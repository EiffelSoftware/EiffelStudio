note
	description: "Summary description for {WSF_FILTER_CONTEXT_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_FILTER_CONTEXT_HANDLER [C -> WSF_HANDLER_CONTEXT create make end]

inherit
	WSF_FILTER_HANDLER [WSF_CONTEXT_HANDLER [C]]

	WSF_CONTEXT_HANDLER [C]

feature {NONE} -- Implementation

	execute_next (ctx: C; req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			if attached next as n then
				n.execute (ctx, req, res)
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
