note
	description: "Summary description for WSF_WITH_CONDITION_MAPPING."
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_WITH_CONDITION_MAPPING

inherit
	WSF_WITH_CONDITION_MAPPING_I

create
	make

feature -- Access

	handler: WSF_EXECUTE_HANDLER

feature -- change

	set_handler (h: like handler)
		do
			handler := h
		end

feature {NONE} -- Execution

	execute_handler (h: like handler; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute handler `h' with `req' and `res' for Current mapping
		do
			h.execute (req, res)
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
