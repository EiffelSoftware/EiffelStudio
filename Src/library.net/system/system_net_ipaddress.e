indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Net.IPAddress"

external class
	SYSTEM_NET_IPADDRESS

inherit
	ANY
		rename
			is_equal as equals_object
		redefine
			get_hash_code,
			equals_object,
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

	frozen get_address: INTEGER is
		external
			"IL signature (): System.Int32 use System.Net.IPAddress"
		alias
			"get_Address"
		end

	frozen get_address_family: SYSTEM_NET_SOCKETS_ADDRESSFAMILY is
		external
			"IL signature (): System.Net.Sockets.AddressFamily use System.Net.IPAddress"
		alias
			"get_AddressFamily"
		end

	frozen loopback: SYSTEM_NET_IPADDRESS is
		external
			"IL static_field signature :System.Net.IPAddress use System.Net.IPAddress"
		alias
			"Loopback"
		end

	frozen none: SYSTEM_NET_IPADDRESS is
		external
			"IL static_field signature :System.Net.IPAddress use System.Net.IPAddress"
		alias
			"None"
		end

	frozen any: SYSTEM_NET_IPADDRESS is
		external
			"IL static_field signature :System.Net.IPAddress use System.Net.IPAddress"
		alias
			"Any"
		end

	frozen broadcast: SYSTEM_NET_IPADDRESS is
		external
			"IL static_field signature :System.Net.IPAddress use System.Net.IPAddress"
		alias
			"Broadcast"
		end

feature -- Element Change

	frozen set_address (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Net.IPAddress"
		alias
			"set_Address"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Net.IPAddress"
		alias
			"ToString"
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

	frozen is_loopback (address: SYSTEM_NET_IPADDRESS): BOOLEAN is
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

	frozen parse (ip_string: STRING): SYSTEM_NET_IPADDRESS is
		external
			"IL static signature (System.String): System.Net.IPAddress use System.Net.IPAddress"
		alias
			"Parse"
		end

	frozen host_to_network_order_int64 (host: INTEGER_64): INTEGER_64 is
		external
			"IL static signature (System.Int64): System.Int64 use System.Net.IPAddress"
		alias
			"HostToNetworkOrder"
		end

	equals_object (comparand: ANY): BOOLEAN is
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

end -- class SYSTEM_NET_IPADDRESS
