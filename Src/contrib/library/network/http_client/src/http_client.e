note
	description : "[
				Instantiate one of the descendant of HTTP_CLIENT
				then use `new_session' to create a session of http requests
			]"
	date        : "$Date$"
	revision    : "$Revision$"

deferred class
	HTTP_CLIENT

feature -- Status

	new_session (a_base_url: READABLE_STRING_8): HTTP_CLIENT_SESSION
			-- Create a new session using `a_base_url'.
		deferred
		end

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
