note
	description: "Summary description for {WSF_STARTS_WITH_CONTEXT_ROUTED_SERVICE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_STARTS_WITH_CONTEXT_ROUTER_HELPER [C -> WSF_HANDLER_CONTEXT create make end]

feature -- Access

	router: WSF_ROUTER
		deferred
		end

feature -- Mapping helper: starts_with

	map_starts_with (a_uri: READABLE_STRING_8; h: WSF_STARTS_WITH_CONTEXT_HANDLER [C])
		do
			map_starts_with_request_methods (a_uri, h, Void)
		end

	map_starts_with_request_methods (a_uri: READABLE_STRING_8; h: WSF_STARTS_WITH_CONTEXT_HANDLER [C]; rqst_methods: detachable WSF_REQUEST_METHODS)
		do
			router.map_with_request_methods (create {WSF_STARTS_WITH_CONTEXT_MAPPING [C]}.make (a_uri, h), rqst_methods)
		end

feature -- Mapping helper: starts_with agent		

	map_starts_with_agent (a_uri: READABLE_STRING_8; proc: PROCEDURE [ANY, TUPLE [start_path: READABLE_STRING_8; ctx: C; req: WSF_REQUEST; res: WSF_RESPONSE]])
		do
			map_starts_with_agent_with_request_methods (a_uri, proc, Void)
		end

	map_starts_with_agent_with_request_methods (a_uri: READABLE_STRING_8; proc: PROCEDURE [ANY, TUPLE [start_path: READABLE_STRING_8; ctx: C; req: WSF_REQUEST; res: WSF_RESPONSE]]; rqst_methods: detachable WSF_REQUEST_METHODS)
		do
			map_starts_with_request_methods (a_uri, create {WSF_STARTS_WITH_AGENT_CONTEXT_HANDLER [C] }.make (proc), rqst_methods)
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
