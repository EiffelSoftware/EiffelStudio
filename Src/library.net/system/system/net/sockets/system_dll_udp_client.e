indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Net.Sockets.UdpClient"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_UDP_CLIENT

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end

create
	make_3,
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_3 (hostname: SYSTEM_STRING; port: INTEGER) is
		external
			"IL creator signature (System.String, System.Int32) use System.Net.Sockets.UdpClient"
		end

	frozen make_2 (local_ep: SYSTEM_DLL_IPEND_POINT) is
		external
			"IL creator signature (System.Net.IPEndPoint) use System.Net.Sockets.UdpClient"
		end

	frozen make is
		external
			"IL creator use System.Net.Sockets.UdpClient"
		end

	frozen make_1 (port: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Net.Sockets.UdpClient"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Net.Sockets.UdpClient"
		alias
			"ToString"
		end

	frozen send_array_byte_int32_string (dgram: NATIVE_ARRAY [INTEGER_8]; bytes: INTEGER; hostname: SYSTEM_STRING; port: INTEGER): INTEGER is
		external
			"IL signature (System.Byte[], System.Int32, System.String, System.Int32): System.Int32 use System.Net.Sockets.UdpClient"
		alias
			"Send"
		end

	frozen connect_string (hostname: SYSTEM_STRING; port: INTEGER) is
		external
			"IL signature (System.String, System.Int32): System.Void use System.Net.Sockets.UdpClient"
		alias
			"Connect"
		end

	frozen close is
		external
			"IL signature (): System.Void use System.Net.Sockets.UdpClient"
		alias
			"Close"
		end

	frozen receive (remote_ep: SYSTEM_DLL_IPEND_POINT): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (System.Net.IPEndPoint&): System.Byte[] use System.Net.Sockets.UdpClient"
		alias
			"Receive"
		end

	frozen connect_ipaddress (addr: SYSTEM_DLL_IPADDRESS; port: INTEGER) is
		external
			"IL signature (System.Net.IPAddress, System.Int32): System.Void use System.Net.Sockets.UdpClient"
		alias
			"Connect"
		end

	frozen drop_multicast_group (multicast_addr: SYSTEM_DLL_IPADDRESS) is
		external
			"IL signature (System.Net.IPAddress): System.Void use System.Net.Sockets.UdpClient"
		alias
			"DropMulticastGroup"
		end

	frozen join_multicast_group_ipaddress_int32 (multicast_addr: SYSTEM_DLL_IPADDRESS; time_to_live: INTEGER) is
		external
			"IL signature (System.Net.IPAddress, System.Int32): System.Void use System.Net.Sockets.UdpClient"
		alias
			"JoinMulticastGroup"
		end

	frozen send (dgram: NATIVE_ARRAY [INTEGER_8]; bytes: INTEGER): INTEGER is
		external
			"IL signature (System.Byte[], System.Int32): System.Int32 use System.Net.Sockets.UdpClient"
		alias
			"Send"
		end

	frozen connect (end_point: SYSTEM_DLL_IPEND_POINT) is
		external
			"IL signature (System.Net.IPEndPoint): System.Void use System.Net.Sockets.UdpClient"
		alias
			"Connect"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Net.Sockets.UdpClient"
		alias
			"Equals"
		end

	frozen send_array_byte_int32_ipend_point (dgram: NATIVE_ARRAY [INTEGER_8]; bytes: INTEGER; end_point: SYSTEM_DLL_IPEND_POINT): INTEGER is
		external
			"IL signature (System.Byte[], System.Int32, System.Net.IPEndPoint): System.Int32 use System.Net.Sockets.UdpClient"
		alias
			"Send"
		end

	frozen join_multicast_group (multicast_addr: SYSTEM_DLL_IPADDRESS) is
		external
			"IL signature (System.Net.IPAddress): System.Void use System.Net.Sockets.UdpClient"
		alias
			"JoinMulticastGroup"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Net.Sockets.UdpClient"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	frozen get_client: SYSTEM_DLL_SOCKET is
		external
			"IL signature (): System.Net.Sockets.Socket use System.Net.Sockets.UdpClient"
		alias
			"get_Client"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Net.Sockets.UdpClient"
		alias
			"Finalize"
		end

	frozen set_client (value: SYSTEM_DLL_SOCKET) is
		external
			"IL signature (System.Net.Sockets.Socket): System.Void use System.Net.Sockets.UdpClient"
		alias
			"set_Client"
		end

	frozen set_active (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Net.Sockets.UdpClient"
		alias
			"set_Active"
		end

	frozen system_idisposable_dispose is
		external
			"IL signature (): System.Void use System.Net.Sockets.UdpClient"
		alias
			"System.IDisposable.Dispose"
		end

	frozen get_active: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Net.Sockets.UdpClient"
		alias
			"get_Active"
		end

end -- class SYSTEM_DLL_UDP_CLIENT
