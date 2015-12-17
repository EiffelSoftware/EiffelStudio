note
	description: "Summary description for {WSF_STARTS_WITH_AGENT_CONTEXT_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_STARTS_WITH_AGENT_CONTEXT_HANDLER [C -> WSF_HANDLER_CONTEXT create make end]

inherit
	WSF_STARTS_WITH_CONTEXT_HANDLER [C]

create
	make

feature -- Change

	make (a_action: like action)
		do
			action := a_action
		end

feature -- Access	

	action: PROCEDURE [TUPLE [start_path: READABLE_STRING_8; context: C; request: WSF_REQUEST; response: WSF_RESPONSE]]

feature -- Execution

	execute (a_start_path: READABLE_STRING_8; ctx: C; req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			action.call ([a_start_path, ctx, req, res])
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
