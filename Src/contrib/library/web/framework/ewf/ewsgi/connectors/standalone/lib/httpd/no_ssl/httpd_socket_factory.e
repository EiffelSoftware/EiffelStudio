note
	description: "Summary description for {HTTPD_SOCKET_FACTORY}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	HTTPD_SOCKET_FACTORY

feature -- Access

	new_client_socket (a_is_secure: BOOLEAN): HTTPD_STREAM_SOCKET
		do
			check not_secure: not a_is_secure end
			create Result.make_empty
		end

end
