note
	description: "Summary description for {DEFAULT_HTTP_CLIENT_I}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DEFAULT_HTTP_CLIENT_I

inherit
	HTTP_CLIENT

feature -- Change

	force_default_client (a_cl_name: detachable READABLE_STRING_GENERAL)
			-- Set default client according to the name `a_cl_name`.
		do
		end

note
	copyright: "2011-2023, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
