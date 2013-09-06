note
	description: "Summary description for {WSF_URI_ROUTING_CONTEXT_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_URI_ROUTING_CONTEXT_HANDLER [C -> WSF_HANDLER_CONTEXT create make end]

inherit
	WSF_ROUTING_CONTEXT_HANDLER [C]

	WSF_URI_CONTEXT_HANDLER [C]
		rename
			execute as uri_execute
		select
			uri_execute
		end

create
	make

feature	-- Execution

	uri_execute (ctx: C; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
			--| For such routing handler, the previous context is lost
		do
			execute_with_context (ctx, req, res)
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
