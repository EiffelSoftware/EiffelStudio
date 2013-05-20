note
	description: "Summary description for {WSF_URI_TEMPLATE_CONTEXT_ROUTED_SERVICE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_URI_TEMPLATE_CONTEXT_ROUTED_SERVICE [C -> WSF_HANDLER_CONTEXT create make end]

obsolete "Inherit from WSF_ROUTED_SERVICE and WSF_URI_TEMPLATE_CONTEXT_ROUTER_HELPER [2013-mar-19]"

inherit
	WSF_ROUTED_SERVICE

	WSF_URI_TEMPLATE_CONTEXT_ROUTER_HELPER [C]

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
