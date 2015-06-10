note
	description: "Helper for execution based on router and uri template mapping context."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_URI_TEMPLATE_CONTEXT_ROUTER_HELPER [C -> WSF_HANDLER_CONTEXT create make end]

feature -- Access

	router: WSF_ROUTER
		deferred
		end

feature -- Mapping helper: uri

	map_uri_template (a_tpl: READABLE_STRING_8; h: WSF_URI_TEMPLATE_CONTEXT_HANDLER [C]; rqst_methods: detachable WSF_REQUEST_METHODS)
		require
			a_tpl_attached: a_tpl /= Void
			h_attached: h /= Void
		do
			router.map (create {WSF_URI_TEMPLATE_CONTEXT_MAPPING [C]}.make (a_tpl, h), rqst_methods)
		end

	map_uri_template_with_request_methods (a_tpl: READABLE_STRING_8; h: WSF_URI_TEMPLATE_CONTEXT_HANDLER [C]; rqst_methods: detachable WSF_REQUEST_METHODS)
		obsolete
			"Use directly `make_uri_template' [June/2015]"
		require
			a_tpl_attached: a_tpl /= Void
			h_attached: h /= Void
		do
			map_uri_template (a_tpl, h, rqst_methods)
		end

feature -- Mapping helper: uri agent		

	map_uri_template_agent (a_tpl: READABLE_STRING_8; proc: PROCEDURE [ANY, TUPLE [ctx: C; req: WSF_REQUEST; res: WSF_RESPONSE]]; rqst_methods: detachable WSF_REQUEST_METHODS)
		require
			a_tpl_attached: a_tpl /= Void
			proc_attached: proc /= Void
		do
			map_uri_template (a_tpl, create {WSF_URI_TEMPLATE_AGENT_CONTEXT_HANDLER [C] }.make (proc), rqst_methods)
		end

	map_uri_template_agent_with_request_methods (a_tpl: READABLE_STRING_8; proc: PROCEDURE [ANY, TUPLE [ctx: C; req: WSF_REQUEST; res: WSF_RESPONSE]]; rqst_methods: detachable WSF_REQUEST_METHODS)
		obsolete
			"Use directly `make_uri_template_agent' [June/2015]"
		require
			a_tpl_attached: a_tpl /= Void
			proc_attached: proc /= Void
		do
			map_uri_template_agent (a_tpl, proc, rqst_methods)
		end

note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Colin Adams, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
