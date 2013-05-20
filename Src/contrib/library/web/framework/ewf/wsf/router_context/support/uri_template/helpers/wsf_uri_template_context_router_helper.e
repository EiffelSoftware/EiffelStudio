note
	description: "Summary description for {WSF_URI_TEMPLATE_CONTEXT_ROUTER_HELPER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_URI_TEMPLATE_CONTEXT_ROUTER_HELPER [C -> WSF_HANDLER_CONTEXT create make end]

feature -- Access

	router: WSF_ROUTER
		deferred
		end

feature -- Mapping helper: uri

	map_uri_template (a_tpl: READABLE_STRING_8; h: WSF_URI_TEMPLATE_CONTEXT_HANDLER [C])
		do
			map_uri_template_with_request_methods (a_tpl, h, Void)
		end

	map_uri_template_with_request_methods (a_tpl: READABLE_STRING_8; h: WSF_URI_TEMPLATE_CONTEXT_HANDLER [C]; rqst_methods: detachable WSF_REQUEST_METHODS)
		do
			router.map_with_request_methods (create {WSF_URI_TEMPLATE_CONTEXT_MAPPING [C]}.make (a_tpl, h), rqst_methods)
		end

feature -- Mapping helper: uri agent		

	map_uri_template_agent (a_tpl: READABLE_STRING_8; proc: PROCEDURE [ANY, TUPLE [ctx: C; req: WSF_REQUEST; res: WSF_RESPONSE]])
		do
			map_uri_template_agent_with_request_methods (a_tpl, proc, Void)
		end

	map_uri_template_agent_with_request_methods (a_tpl: READABLE_STRING_8; proc: PROCEDURE [ANY, TUPLE [ctx: C; req: WSF_REQUEST; res: WSF_RESPONSE]]; rqst_methods: detachable WSF_REQUEST_METHODS)
		do
			map_uri_template_with_request_methods (a_tpl, create {WSF_URI_TEMPLATE_AGENT_CONTEXT_HANDLER [C] }.make (proc), rqst_methods)
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
