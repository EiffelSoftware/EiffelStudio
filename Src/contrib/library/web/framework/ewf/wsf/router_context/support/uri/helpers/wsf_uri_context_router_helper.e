note
	description: "Summary description for {WSF_URI_CONTEXT_ROUTER_HELPER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_URI_CONTEXT_ROUTER_HELPER [C -> WSF_HANDLER_CONTEXT create make end]

feature -- Access

	router: WSF_ROUTER
		deferred
		end

feature -- Mapping helper: uri

	map_uri (a_uri: READABLE_STRING_8; h: WSF_URI_CONTEXT_HANDLER [C])
		require
			a_uri_attached: a_uri /= Void
			h_attached: h /= Void
		do
			map_uri_with_request_methods (a_uri, h, Void)
		end

	map_uri_with_request_methods (a_uri: READABLE_STRING_8; h: WSF_URI_CONTEXT_HANDLER [C]; rqst_methods: detachable WSF_REQUEST_METHODS)
		require
			a_uri_attached: a_uri /= Void
			h_attached: h /= Void
		do
			router.map_with_request_methods (create {WSF_URI_CONTEXT_MAPPING [C]}.make (a_uri, h), rqst_methods)
		end

feature -- Mapping helper: uri agent		

	map_uri_agent (a_uri: READABLE_STRING_8; proc: PROCEDURE [ANY, TUPLE [ctx: C; req: WSF_REQUEST; res: WSF_RESPONSE]])
		require
			a_uri_attached: a_uri /= Void
			proc_attached: proc /= Void
		do
			map_uri_agent_with_request_methods (a_uri, proc, Void)
		end

	map_uri_agent_with_request_methods (a_uri: READABLE_STRING_8; proc: PROCEDURE [ANY, TUPLE [ctx: C; req: WSF_REQUEST; res: WSF_RESPONSE]]; rqst_methods: detachable WSF_REQUEST_METHODS)
		require
			a_uri_attached: a_uri /= Void
			proc_attached: proc /= Void
		do
			map_uri_with_request_methods (a_uri, create {WSF_URI_AGENT_CONTEXT_HANDLER [C] }.make (proc), rqst_methods)
		end

note
	copyright: "2011-2014, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Colin Adams, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
