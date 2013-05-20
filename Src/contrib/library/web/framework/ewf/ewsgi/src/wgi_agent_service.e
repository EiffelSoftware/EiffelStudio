note
	description: "Summary description for {WGI_AGENT_SERVICE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WGI_AGENT_SERVICE

inherit
	WGI_SERVICE

create
	make

feature {NONE} -- Implementation

	make (a_callback: like callback)
			-- Initialize `Current'.
		do
			callback := a_callback
		end

feature {NONE} -- Implementation

	callback: PROCEDURE [ANY, TUPLE [req: WGI_REQUEST; res: WGI_RESPONSE]]
			-- Procedure called on `execute'

	execute (req: WGI_REQUEST; res: WGI_RESPONSE)
			-- Execute the request
		do
			callback.call ([req, res])
		end

invariant
	callback_attached: callback /= Void

note
	copyright: "2011-2012, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
