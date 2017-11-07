note
	description: "[
			Represents the ancestor of all the WSF_ROUTER handlers with `execute (WSF_REQUEST, WSF_RESPONSE)` routine.
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_EXECUTE_HANDLER

inherit
	WSF_HANDLER

feature -- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute `req' responding in `res'.
		require
			req_attached: req /= Void
			res_attached: res /= Void
		deferred
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
