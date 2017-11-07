note
	description: "Summary description for {WSF_ROUTING_OR_CONDITION}."
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_ROUTING_OR_CONDITION

inherit
	WSF_ROUTING_CONDITION

create
	make

feature {NONE} -- Creation

	make (a_left, a_right: WSF_ROUTING_CONDITION)
		do
			left := a_left
			right := a_right
		end

	left, right: WSF_ROUTING_CONDITION

feature -- Status report

	accepted (req: WSF_REQUEST): BOOLEAN
			-- Does `req` satisfy Current condition?
		do
			Result := left.accepted (req) or else right.accepted (req)
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Colin Adams, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
