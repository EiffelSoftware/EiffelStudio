note
	description: "Object with a `router' feature, used to dispatch url."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_ROUTED

feature -- Access

	router: WSF_ROUTER
			-- Router used to dispatch the request according to the WSF_REQUEST object
			-- and associated request methods;
			-- This should not be implemented by descendants. Instead, you gain an effective
			--  version by also inheriting from WSF_ROUTED_EXECUTION, or one of it's descendants.
		deferred
		ensure
			router_not_void: Result /= Void
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
