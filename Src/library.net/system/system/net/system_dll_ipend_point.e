indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Net.IPEndPoint"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_IPEND_POINT

inherit
	SYSTEM_DLL_END_POINT
		redefine
			create_,
			serialize,
			get_address_family,
			get_hash_code,
			equals,
			to_string
		end

create
	make_system_dll_ipend_point_1,
	make_system_dll_ipend_point

feature {NONE} -- Initialization

	frozen make_system_dll_ipend_point_1 (address: SYSTEM_DLL_IPADDRESS; port: INTEGER) is
		external
			"IL creator signature (System.Net.IPAddress, System.Int32) use System.Net.IPEndPoint"
		end

	frozen make_system_dll_ipend_point (address: INTEGER_64; port: INTEGER) is
		external
			"IL creator signature (System.Int64, System.Int32) use System.Net.IPEndPoint"
		end

feature -- Access

	frozen max_port: INTEGER is 0xffff

	get_address_family: SYSTEM_DLL_ADDRESS_FAMILY is
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

	frozen get_address: SYSTEM_DLL_IPADDRESS is
		external
			"IL signature (): System.Net.IPAddress use System.Net.IPEndPoint"
		alias
			"get_Address"
		end

feature -- Element Change

	frozen set_address (value: SYSTEM_DLL_IPADDRESS) is
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

	create_ (socket_address: SYSTEM_DLL_SOCKET_ADDRESS): SYSTEM_DLL_END_POINT is
		external
			"IL signature (System.Net.SocketAddress): System.Net.EndPoint use System.Net.IPEndPoint"
		alias
			"Create"
		end

	serialize: SYSTEM_DLL_SOCKET_ADDRESS is
		external
			"IL signature (): System.Net.SocketAddress use System.Net.IPEndPoint"
		alias
			"Serialize"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Net.IPEndPoint"
		alias
			"ToString"
		end

	equals (comparand: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Net.IPEndPoint"
		alias
			"Equals"
		end

end -- class SYSTEM_DLL_IPEND_POINT
