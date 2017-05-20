note
	description: "Summary description for {WSF_PROXY_SOCKET_FACTORY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_PROXY_SOCKET_FACTORY

inherit
	WSF_PROXY_SOCKET_FACTORY_I
		redefine
			is_ssl_supported
		end

feature {NONE} -- Implementation		

	ssl_socket (a_host: READABLE_STRING_8; a_port: INTEGER): detachable SSL_NETWORK_STREAM_SOCKET
		do
			if attached create_from_name (a_host) as l_peer_address then
				create Result.make_client_by_address_and_port (l_peer_address, a_port)
			end
		end

feature -- Status

	is_ssl_supported: BOOLEAN = True
			-- Is https:// supported?
		
end
