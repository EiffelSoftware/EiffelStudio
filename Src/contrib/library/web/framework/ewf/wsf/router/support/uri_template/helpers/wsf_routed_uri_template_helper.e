note
	description: "Facilities inheritance to add URI template-base routing to a routed object."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_ROUTED_URI_TEMPLATE_HELPER

inherit
	WSF_ROUTED

feature -- Mapping helper: uri template

	map_uri_template (a_tpl: STRING; h: WSF_URI_TEMPLATE_HANDLER; rqst_methods: detachable WSF_REQUEST_METHODS)
			-- Map `h' as handler for `a_tpl', according to `rqst_methods'.
		require
			a_tpl_attached: a_tpl /= Void
			h_attached: h /= Void
		do
			router.map (create {WSF_URI_TEMPLATE_MAPPING}.make (a_tpl, h), rqst_methods)
		end

	map_uri_template_with_request_methods (a_tpl: READABLE_STRING_8; h: WSF_URI_TEMPLATE_HANDLER; rqst_methods: detachable WSF_REQUEST_METHODS)
			-- Map `h' as handler for `a_tpl' for request methods `rqst_methods'.
		obsolete
			"Use directly `map_uri_template' [June/2015]"
		require
			a_tpl_attached: a_tpl /= Void
			h_attached: h /= Void
		do
			map_uri_template (a_tpl, h, rqst_methods)
		end

	map_uri_template_response (a_tpl: READABLE_STRING_8; h: WSF_URI_TEMPLATE_RESPONSE_HANDLER; rqst_methods: detachable WSF_REQUEST_METHODS)
			-- Map `h' as response handler for `a_tpl' for request methods `rqst_methods'.
		require
			a_tpl_attached: a_tpl /= Void
			h_attached: h /= Void
		do
			router.map (create {WSF_URI_TEMPLATE_MAPPING}.make (a_tpl, h), rqst_methods)
		end

feature -- Mapping helper: uri template agent

	map_uri_template_agent (a_tpl: READABLE_STRING_8; proc: PROCEDURE [ANY, TUPLE [req: WSF_REQUEST; res: WSF_RESPONSE]]; rqst_methods: detachable WSF_REQUEST_METHODS)
			-- Map `proc' as handler for `a_tpl', according to `rqst_methods'.
		require
			a_tpl_attached: a_tpl /= Void
			proc_attached: proc /= Void
		do
			map_uri_template (a_tpl, create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (proc), rqst_methods)
		end

	map_uri_template_agent_with_request_methods (a_tpl: READABLE_STRING_8; proc: PROCEDURE [ANY, TUPLE [req: WSF_REQUEST; res: WSF_RESPONSE]]; rqst_methods: detachable WSF_REQUEST_METHODS)
			-- Map `proc' as handler for `a_tpl' for request methods `rqst_methods'.
		obsolete
			"Use directly `map_uri_template_agent' [June/2015]"
		require
			a_tpl_attached: a_tpl /= Void
			proc_attached: proc /= Void
		do
			map_uri_template_agent (a_tpl, proc, rqst_methods)
		end

	map_uri_template_response_agent (a_tpl: READABLE_STRING_8; a_action: like {WSF_URI_TEMPLATE_RESPONSE_AGENT_HANDLER}.action; rqst_methods: detachable WSF_REQUEST_METHODS)
			-- Map `a_action' as response handler for `a_tpl' for request methods `rqst_methods'.
		require
			a_tpl_attached: a_tpl /= Void
			a_action_attached: a_action /= Void
		do
			map_uri_template_response (a_tpl, create {WSF_URI_TEMPLATE_RESPONSE_AGENT_HANDLER}.make (a_action), rqst_methods)
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
