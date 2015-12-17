note
	description: "Summary description for {WSF_URI_RESPONSE_AGENT_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_URI_RESPONSE_AGENT_HANDLER

inherit
	WSF_URI_RESPONSE_HANDLER

create
	make

feature -- Initialization

	make (act: like action)
		do
			action := act
		end

feature -- Access

	action: FUNCTION [TUPLE [req: WSF_REQUEST], WSF_RESPONSE_MESSAGE]

feature -- Execution

	response (req: WSF_REQUEST): WSF_RESPONSE_MESSAGE
		do
			Result := action.item ([req])
		end

note
	copyright: "2011-2012, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
