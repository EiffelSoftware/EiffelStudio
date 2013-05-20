note
	description: "Summary description for {WSF_URI_TEMPLATE_CONTEXT_MAPPING}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_URI_TEMPLATE_CONTEXT_MAPPING [C -> WSF_HANDLER_CONTEXT create make end]

inherit
	WSF_URI_TEMPLATE_MAPPING_I
		undefine
			debug_output
		end

	WSF_ROUTER_CONTEXT_MAPPING [C]

create
	make,
	make_from_template

feature -- Access		

	handler: WSF_URI_TEMPLATE_CONTEXT_HANDLER [C]

feature -- Change

	set_handler	(h: like handler)
		do
			handler := h
		end

feature {NONE} -- Execution

	execute_handler (h: like handler; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			ctx: detachable C
		do
			create ctx.make (req, Current)
			h.execute (ctx, req, res)
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
