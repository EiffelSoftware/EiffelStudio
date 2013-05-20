note
	description: "Filter that handles an OPTIONS request, with Cross-Origin Resource Sharing support."
	author: "Olvier Ligot"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Cross-Origin Resource Sharing", "src=http://www.w3.org/TR/cors/", "tag=W3C"

class
	WSF_CORS_OPTIONS_FILTER

inherit
	WSF_FILTER

create
	make

feature {NONE} -- Initialization

	make (a_router: like router)
			-- Initialize Current with `a_router'.
		do
			router := a_router
		ensure
			router_set: router = a_router
		end

feature -- Access

	router: WSF_ROUTER
			-- Associated router

feature -- Basic operations

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute the filter.
		local
			msg: WSF_CORS_OPTIONS_RESPONSE
		do
			if req.is_request_method ({HTTP_REQUEST_METHODS}.method_options) then
				create msg.make (req, router)
				res.send (msg)
			else
				execute_next (req, res)
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
