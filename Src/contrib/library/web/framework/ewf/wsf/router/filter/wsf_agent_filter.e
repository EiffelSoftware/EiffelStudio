note
	description: "Summary description for {WSF_AGENT_FILTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_AGENT_FILTER

inherit
	WSF_FILTER

create
	make

feature {NONE} -- Initialization

	make (agt: like action)
		do
			action := agt
		end

	action: PROCEDURE [ANY, TUPLE [WSF_REQUEST, WSF_RESPONSE]]

feature -- Basic operations

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute the filter
		do
			action.call ([req, res])
			execute_next (req, res)
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
