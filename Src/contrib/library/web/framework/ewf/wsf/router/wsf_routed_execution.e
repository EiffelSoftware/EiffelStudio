note
	description: "Execution based on router."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_ROUTED_EXECUTION

inherit
	WSF_EXECUTION
		redefine
			initialize
		end

	WSF_ROUTED

feature {NONE} -- Initialize

	initialize
		do
			Precursor
			initialize_router
		end

feature -- Router

	initialize_router
			-- Initialize router
		do
			create_router
			setup_router
		end

	create_router
			-- Create `router'	
			--| could be redefine to initialize with proper capacity
		do
			create router.make (10)
		ensure
			router_created: router /= Void
		end

	setup_router
			-- Setup `router'
		require
			router_created: router /= Void
		deferred
		end

feature -- Access

	router: WSF_ROUTER
			-- Router used to dispatch the request according to the WSF_REQUEST object
			-- and associated request methods		

feature -- Execution

	execute
			-- Dispatch the request
			-- and if handler is not found, execute the default procedure `execute_default'.
		do
			router_execute (request, response)
		end

	router_execute (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			sess: WSF_ROUTER_SESSION
		do
			create sess
			router.dispatch (req, res, sess)
			if not sess.dispatched then
				execute_default (req, res)
			end
		end

	execute_default (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Dispatch requests without a matching handler.
		local
			msg: WSF_DEFAULT_ROUTER_RESPONSE
		do
			create msg.make_with_router (request, router)
			msg.set_documentation_included (True)
			response.send (msg)
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
