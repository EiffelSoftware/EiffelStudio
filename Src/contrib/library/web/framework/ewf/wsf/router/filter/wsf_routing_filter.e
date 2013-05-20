note
	description: "Routing filter."
	author: "Olivier Ligot"
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_ROUTING_FILTER

inherit
	WSF_FILTER

create
	make

feature {NONE} -- Initialization

	make (a_router: WSF_ROUTER)
		do
			router := a_router
		ensure
			router_set: router = a_router
		end

feature -- Access

	router: WSF_ROUTER
			-- Router

	execute_default_action: detachable PROCEDURE [ANY, TUPLE [req: WSF_REQUEST; res: WSF_RESPONSE]]
			-- `execute_default' action

feature -- Element change

	set_execute_default_action (an_action: like execute_default_action)
			-- Set `execute_default_action' to `an_action'
		do
			execute_default_action := an_action
		ensure
			execute_default_action_set: execute_default_action = an_action
		end

feature -- Basic operations

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute the filter
		local
			sess: WSF_ROUTER_SESSION
		do
			create sess
			router.dispatch (req, res, sess)
			if not sess.dispatched then
				execute_default (req, res)
			end
			execute_next (req, res)
		end

	execute_default (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			if attached execute_default_action as action then
				action.call ([req, res])
			else
				do_nothing
			end
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
