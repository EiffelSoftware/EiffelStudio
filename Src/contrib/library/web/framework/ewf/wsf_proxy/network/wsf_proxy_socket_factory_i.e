note
	description: "Summary description for {WSF_PROXY_SOCKET_FACTORY_I}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_PROXY_SOCKET_FACTORY_I

inherit
	INET_ADDRESS_FACTORY

feature -- Access

	socket_from_uri (a_uri: URI): like socket
		local
			l_port: INTEGER
		do
			if a_uri.is_valid and then attached a_uri.host as l_host then
				l_port := a_uri.port
				if a_uri.scheme.is_case_insensitive_equal_general ("https") then
					if is_ssl_supported then
						if l_port <= 0 then
							l_port := 443
						end
						Result := ssl_socket (l_host, l_port)
					end
				elseif a_uri.scheme.is_case_insensitive_equal_general ("http") then
					if l_port <= 0 then
						l_port := 80
					end
					Result := socket (l_host, l_port)
				end
			end
		end

feature -- Status

	is_uri_supported (a_uri: URI): BOOLEAN
		do
			Result := a_uri.scheme.is_case_insensitive_equal_general ("http")
				or else (
					a_uri.scheme.is_case_insensitive_equal_general ("https")
					and is_ssl_supported
				)
		end

	is_ssl_supported: BOOLEAN
			-- Is https:// supported?
		do
		end

feature {NONE} -- Implementation		

	socket (a_host: READABLE_STRING_8; a_port: INTEGER): detachable NETWORK_STREAM_SOCKET
		do
			if attached create_from_name (a_host) as l_peer_address then
				create Result.make_client_by_address_and_port (l_peer_address, a_port)
			end
		end

	ssl_socket (a_host: READABLE_STRING_8; a_port: INTEGER): detachable NETWORK_STREAM_SOCKET
		require
			is_ssl_supported: is_ssl_supported
		deferred
		end

end
