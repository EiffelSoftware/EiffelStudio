note
	description: "[
		{WSF_XSS_FILTER}.
		Simple anti cross-site scripting (XSS) filter.
		Remove all suspicious strings from request parameters (query strings and form) before returning them to the application

	]"
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_XSS_FILTER

inherit

	WSF_FILTER

feature -- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute the filter.
		do
			execute_next (create {WSF_XSS_REQUEST}.make_from_request (req), res)
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
