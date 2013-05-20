note
	description: "[
					Context for the handler execution
					It provides information related to the matching handler at runtime, i.e:
						- request: WSF_REQUEST -- Associated request
					- path: READABLE_STRING_8	-- Associated path
				]"
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_HANDLER_CONTEXT

create
	make

feature {NONE} -- Initialization

	make (req: like request; map: like mapping)
		do
			request := req
			mapping := map
		end

feature -- Access

	request: WSF_REQUEST
			-- Associated request

	mapping: WSF_ROUTER_MAPPING
			-- Associated mapping

;note
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
