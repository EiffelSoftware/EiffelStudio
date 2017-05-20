note
	description: "Summary description for {HTTPD_SOCKET_FACTORY}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	HTTPD_SOCKET_FACTORY

feature -- Access

	new_client_socket (a_is_secure: BOOLEAN): HTTPD_STREAM_SOCKET
		do
			if a_is_secure then
				create {HTTPD_STREAM_SECURE_SOCKET} Result.make_empty
			else
				create Result.make_empty
			end
		end

note
	copyright: "2011-2016, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
