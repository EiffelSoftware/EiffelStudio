note
	description: "[
				This class represents the processing of a request via a WSF_ROUTER.
				
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_ROUTER_SESSION

feature -- Status report	

	dispatched: BOOLEAN
			-- Handler dispatched?
		do
			Result := dispatched_handler /= Void
		ensure
			Result implies dispatched_handler /= Void
		end

feature -- Access

	dispatched_handler: detachable WSF_HANDLER
			-- Handler dispatched

feature -- Change

	set_dispatched_handler (h: like dispatched_handler)
		do
			dispatched_handler := h
		ensure
			h_set: dispatched_handler = h
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
