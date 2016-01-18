note
	description: "[
		Create this service with a callback to implement {WSF_SERVICE}.execute (req, res)
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_CALLBACK_SERVICE

inherit
	WSF_SERVICE

create
	make

convert
	make ({PROCEDURE [WSF_REQUEST, WSF_RESPONSE]})

feature {NONE} -- Implementation

	make (a_callback: like callback)
			-- Initialize `Current'.
		do
			callback := a_callback
		end

feature {NONE} -- Implementation

	callback: PROCEDURE [WSF_REQUEST, WSF_RESPONSE]
			-- Procedure called on `execute'

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute the request
		do
			callback.call ([req, res])
		end

invariant
	callback_attached: callback /= Void

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
