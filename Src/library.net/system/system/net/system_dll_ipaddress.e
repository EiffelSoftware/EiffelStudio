indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Net.IPAddress"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_IPADDRESS

inherit
	SYSTEM_OBJECT
		redefine
			get_hash_code,
			equals,
			to_string
		end

create
	make

feature {NONE} -- Initialization

	frozen make (new_address: INTEGER_64) is
		external
			"IL creator signature (System.Int64) use System.Net.IPAddress"
		end

feature -- Access

	frozen get_address: INTEGER_64 is
		external
			"IL signature (): System.Int64 use System.Net.IPAddress"
		alias
			"get_Address"
		end

	frozen get_address_family: SYSTEM_DLL_ADDRESS_FAMILY is
		external
			"IL signature (): System.Net.Sockets.AddressFamily use System.Net.IPAddress"
		alias
			"get_AddressFamily"
		end

	frozen loopback: SYSTEM_DLL_IPADDRESS is
		external
			"IL static_field signature :System.Net.IPAddress use System.Net.IPAddress"
		alias
			"Loopback"
		end

	frozen none: SYSTEM_DLL_IPADDRESS is
		external
			"IL static_field signature :System.Net.IPAddress use System.Net.IPAddress"
		alias
			"None"
		end

	frozen any: SYSTEM_DLL_IPADDRESS is
		external
			"IL static_field signature :System.Net.IPAddress use System.Net.IPAddress"
		alias
			"Any"
		end

	frozen broadcast: SYSTEM_DLL_IPADDRESS is
		external
			"IL static_field signature :System.Net.IPAddress use System.Net.IPAddress"
		alias
			"Broadcast"
		end

feature -- Element Change

	frozen set_address (value: INTEGER_64) is
		external
			"IL signature (System.Int64): System.Void use System.Net.IPAddress"
		alias
			"set_Address"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Net.IPAddress"
		alias
			"ToString"
		end

	frozen host_to_network_order_int64 (host: INTEGER_64): INTEGER_64 is
		external
			"IL static signature (System.Int64): System.Int64 use System.Net.IPAddress"
		alias
			"HostToNetworkOrder"
		end

	frozen host_to_network_order (host: INTEGER_16): INTEGER_16 is
		external
			"IL static signature (System.Int16): System.Int16 use System.Net.IPAddress"
		alias
			"HostToNetworkOrder"
		end

	frozen network_to_host_order (network: INTEGER_16): INTEGER_16 is
		external
			"IL static signature (System.Int16): System.Int16 use System.Net.IPAddress"
		alias
			"NetworkToHostOrder"
		end

	frozen network_to_host_order_int64 (network: INTEGER_64): INTEGER_64 is
		external
			"IL static signature (System.Int64): System.Int64 use System.Net.IPAddress"
		alias
			"NetworkToHostOrder"
		end

	frozen is_loopback (address: SYSTEM_DLL_IPADDRESS): BOOLEAN is
		external
			"IL static signature (System.Net.IPAddress): System.Boolean use System.Net.IPAddress"
		alias
			"IsLoopback"
		end

	frozen host_to_network_order_int32 (host: INTEGER): INTEGER is
		external
			"IL static signature (System.Int32): System.Int32 use System.Net.IPAddress"
		alias
			"HostToNetworkOrder"
		end

	frozen network_to_host_order_int32 (network: INTEGER): INTEGER is
		external
			"IL static signature (System.Int32): System.Int32 use System.Net.IPAddress"
		alias
			"NetworkToHostOrder"
		end

	frozen parse (ip_string: SYSTEM_STRING): SYSTEM_DLL_IPADDRESS is
		external
			"IL static signature (System.String): System.Net.IPAddress use System.Net.IPAddress"
		alias
			"Parse"
		end

	equals (comparand: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Net.IPAddress"
		alias
			"Equals"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Net.IPAddress"
		alias
			"GetHashCode"
		end

end -- class SYSTEM_DLL_IPADDRESS
