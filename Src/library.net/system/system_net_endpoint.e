indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Net.EndPoint"

deferred external class
	SYSTEM_NET_ENDPOINT

feature -- Access

	get_address_family: SYSTEM_NET_SOCKETS_ADDRESSFAMILY is
		external
			"IL signature (): System.Net.Sockets.AddressFamily use System.Net.EndPoint"
		alias
			"get_AddressFamily"
		end

feature -- Basic Operations

	serialize: SYSTEM_NET_SOCKETADDRESS is
		external
			"IL signature (): System.Net.SocketAddress use System.Net.EndPoint"
		alias
			"Serialize"
		end

	Create_ (socket_address: SYSTEM_NET_SOCKETADDRESS): SYSTEM_NET_ENDPOINT is
		external
			"IL signature (System.Net.SocketAddress): System.Net.EndPoint use System.Net.EndPoint"
		alias
			"Create"
		end

end -- class SYSTEM_NET_ENDPOINT
