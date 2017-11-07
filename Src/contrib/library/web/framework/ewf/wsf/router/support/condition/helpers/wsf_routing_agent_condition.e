note
	description: "Summary description for {WSF_ROUTING_AGENT_CONDITION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_ROUTING_AGENT_CONDITION

inherit
	WSF_ROUTING_CONDITION

create
	make

feature {NONE} -- Initialization

	make (act: like condition)
		do
			condition := act
		end

	condition: FUNCTION [TUPLE [request: WSF_REQUEST], BOOLEAN]

feature -- Status report

	accepted (req: WSF_REQUEST): BOOLEAN
			-- Does `req` satisfy Current condition?
		do
			Result := condition (req)
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
