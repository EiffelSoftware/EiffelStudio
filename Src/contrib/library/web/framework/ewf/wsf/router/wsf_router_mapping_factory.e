note
	description: "[
				Component that know how to create a router mapping from request and response.
				Usually handler inherits from this classes, this way, it is easy to use WSF_ROUTER.handle_... (resource, handler, ..)
			]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_ROUTER_MAPPING_FACTORY

feature {WSF_ROUTER} -- Mapping

	new_mapping (a_uri: READABLE_STRING_8): WSF_ROUTER_MAPPING
			-- New mapping object
		require
			a_uri_attached: a_uri /= Void
		deferred
		ensure
			Result_attached: Result /= Void
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
