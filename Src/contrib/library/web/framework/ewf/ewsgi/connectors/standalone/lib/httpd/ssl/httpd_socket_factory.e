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
				create {HTTPD_STREAM_SSL_SOCKET} Result.make_empty
			else
				create Result.make_empty
			end
		end

end
