note
	description: "[
			Represents the ancestor of all the WSF_ROUTER handler.
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_HANDLER

feature -- Status report

	is_valid_context (req: WSF_REQUEST): BOOLEAN
			-- Is `req' valid context for current handler?
		require
			req_attached: req /= Void
		do
			Result := True
		end

feature {WSF_ROUTER} -- Mapping

	on_mapped (a_mapping: WSF_ROUTER_MAPPING; a_rqst_methods: detachable WSF_REQUEST_METHODS)
			-- Callback called when a router map a route to Current handler
		require
			a_mapping_attached: a_mapping /= Void
		do
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
