indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Net.IPEndPoint"

external class
	SYSTEM_NET_IPENDPOINT

inherit
	SYSTEM_NET_ENDPOINT
		rename
			is_equal as equals_object
		redefine
			Create_,
			serialize,
			get_address_family,
			get_hash_code,
			equals_object,
			to_string
		end

create
	make_ipendpoint_1,
	make_ipendpoint

feature {NONE} -- Initialization

	frozen make_ipendpoint_1 (address: SYSTEM_NET_IPADDRESS; port: INTEGER) is
		external
			"IL creator signature (System.Net.IPAddress, System.Int32) use System.Net.IPEndPoint"
		end

	frozen make_ipendpoint (address: INTEGER_64; port: INTEGER) is
		external
			"IL creator signature (System.Int64, System.Int32) use System.Net.IPEndPoint"
		end

feature -- Access

	frozen max_port: INTEGER is 0xffff

	get_address_family: SYSTEM_NET_SOCKETS_ADDRESSFAMILY is
		external
			"IL signature (): System.Net.Sockets.AddressFamily use System.Net.IPEndPoint"
		alias
			"get_AddressFamily"
		end

	frozen min_port: INTEGER is 0x0

	frozen get_port: INTEGER is
		external
			"IL signature (): System.Int32 use System.Net.IPEndPoint"
		alias
			"get_Port"
		end

	frozen get_address: SYSTEM_NET_IPADDRESS is
		external
			"IL signature (): System.Net.IPAddress use System.Net.IPEndPoint"
		alias
			"get_Address"
		end

feature -- Element Change

	frozen set_address (value: SYSTEM_NET_IPADDRESS) is
		external
			"IL signature (System.Net.IPAddress): System.Void use System.Net.IPEndPoint"
		alias
			"set_Address"
		end

	frozen set_port (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Net.IPEndPoint"
		alias
			"set_Port"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Net.IPEndPoint"
		alias
			"GetHashCode"
		end

	equals_object (comparand: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Net.IPEndPoint"
		alias
			"Equals"
		end

	serialize: SYSTEM_NET_SOCKETADDRESS is
		external
			"IL signature (): System.Net.SocketAddress use System.Net.IPEndPoint"
		alias
			"Serialize"
		end

	Create_ (socket_address: SYSTEM_NET_SOCKETADDRESS): SYSTEM_NET_ENDPOINT is
		external
			"IL signature (System.Net.SocketAddress): System.Net.EndPoint use System.Net.IPEndPoint"
		alias
			"Create"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Net.IPEndPoint"
		alias
			"ToString"
		end

end -- class SYSTEM_NET_IPENDPOINT
