note
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_ROUTER_CONTEXT_MAPPING [C -> WSF_HANDLER_CONTEXT create make end]

inherit
	WSF_ROUTER_MAPPING
		redefine
			debug_output
		end

feature -- Access		

	handler: WSF_CONTEXT_HANDLER [C]
			-- Handler associated with Current mapping.
		deferred
		end

feature -- Status report

	debug_output: READABLE_STRING_32
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := Precursor + " {" + ({C}).name_32 + "}"
		end

note
	copyright: "2011-2021, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Colin Adams, Alexander Kogtenkov, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
