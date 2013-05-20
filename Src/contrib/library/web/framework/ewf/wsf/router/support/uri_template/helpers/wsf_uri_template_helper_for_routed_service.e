note

	description: "Facilities inheritance to add URI template-base routing to a routed service"

	date: "$Date$"
	revision: "$Revision$"

deferred class WSF_URI_TEMPLATE_HELPER_FOR_ROUTED_SERVICE

feature -- Access

	router: WSF_ROUTER
			-- Router used to dispatch the request according to the WSF_REQUEST object
			-- and associated request methods;
			-- This should not be implemented by descendants. Instead, you gain an effective
			--  version by also inheriting from WSF_ROUTED_SERVICE, or one of it's descendants.
		deferred
		ensure
			router_not_void: Result /= Void
		end

feature -- Mapping helper: uri template

	map_uri_template (a_tpl: STRING; h: WSF_URI_TEMPLATE_HANDLER)
			-- Map `h' as handler for `a_tpl'
		require
			a_tpl_attached: a_tpl /= Void
			h_attached: h /= Void	
		do
			map_uri_template_with_request_methods (a_tpl, h, Void)
		end

	map_uri_template_with_request_methods (a_tpl: READABLE_STRING_8; h: WSF_URI_TEMPLATE_HANDLER; rqst_methods: detachable WSF_REQUEST_METHODS)
			-- Map `h' as handler for `a_tpl' for request methods `rqst_methods'.
		require
			a_tpl_attached: a_tpl /= Void
			h_attached: h /= Void
		do
			router.map_with_request_methods (create {WSF_URI_TEMPLATE_MAPPING}.make (a_tpl, h), rqst_methods)
		end

feature -- Mapping helper: uri template agent

	map_uri_template_agent (a_tpl: READABLE_STRING_8; proc: PROCEDURE [ANY, TUPLE [req: WSF_REQUEST; res: WSF_RESPONSE]])
			-- Map `proc' as handler for `a_tpl'
		require
			a_tpl_attached: a_tpl /= Void
			proc_attached: proc /= Void	
		do
			map_uri_template_agent_with_request_methods (a_tpl, proc, Void)
		end

	map_uri_template_agent_with_request_methods (a_tpl: READABLE_STRING_8; proc: PROCEDURE [ANY, TUPLE [req: WSF_REQUEST; res: WSF_RESPONSE]]; rqst_methods: detachable WSF_REQUEST_METHODS)
			-- Map `proc' as handler for `a_tpl' for request methods `rqst_methods'.
		require
			a_tpl_attached: a_tpl /= Void
			proc_attached: proc /= Void
		do
			map_uri_template_with_request_methods (a_tpl, create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (proc), rqst_methods)
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
