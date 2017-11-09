note
	description: "Summary description for {WSF_URI_RESPONSE_AGENT_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_URI_RESPONSE_AGENT_HANDLER

inherit
	WSF_EXECUTE_RESPONSE_AGENT_HANDLER

	WSF_URI_RESPONSE_HANDLER
		undefine
			execute
		end
create
	make

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
