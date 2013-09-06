note
	description: "Summary description for {WSF_STARTS_WITH_ROUTING_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_STARTS_WITH_ROUTING_HANDLER

inherit
	WSF_ROUTING_HANDLER

	WSF_STARTS_WITH_HANDLER
		rename
			execute as starts_with_execute
		end

create
	make

feature	-- Execution

	starts_with_execute (a_start_path: READABLE_STRING_8; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
			--| For such routing handler, the previous `a_start_path' is lost
		do
			execute (req, res)
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
