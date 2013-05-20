note
	description: "Summary description for {WSF_URI_AGENT_CONTEXT_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_URI_AGENT_CONTEXT_HANDLER [C -> WSF_HANDLER_CONTEXT create make end]

inherit
	WSF_URI_CONTEXT_HANDLER [C]

	WSF_AGENT_CONTEXT_HANDLER [C]
		rename
			set_action as make
		end

create
	make

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
