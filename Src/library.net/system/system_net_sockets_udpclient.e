indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Net.Sockets.UdpClient"

external class
	SYSTEM_NET_SOCKETS_UDPCLIENT

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end

create
	make_3,
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_3 (hostname: STRING; port: INTEGER) is
		external
			"IL creator signature (System.String, System.Int32) use System.Net.Sockets.UdpClient"
		end

	frozen make_2 (local_ep: SYSTEM_NET_IPENDPOINT) is
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

	to_string: STRING is
		external
			"IL signature (): System.String use System.Net.Sockets.UdpClient"
		alias
			"ToString"
		end

	frozen send_array_byte_int32_string (dgram: ARRAY [INTEGER_8]; bytes: INTEGER; hostname: STRING; port: INTEGER): INTEGER is
		external
			"IL signature (System.Byte[], System.Int32, System.String, System.Int32): System.Int32 use System.Net.Sockets.UdpClient"
		alias
			"Send"
		end

	frozen connect_string (hostname: STRING; port: INTEGER) is
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

	frozen receive (remote_ep: SYSTEM_NET_IPENDPOINT): ARRAY [INTEGER_8] is
		external
			"IL signature (System.Net.IPEndPoint&): System.Byte[] use System.Net.Sockets.UdpClient"
		alias
			"Receive"
		end

	frozen connect_ipaddress (addr: SYSTEM_NET_IPADDRESS; port: INTEGER) is
		external
			"IL signature (System.Net.IPAddress, System.Int32): System.Void use System.Net.Sockets.UdpClient"
		alias
			"Connect"
		end

	frozen drop_multicast_group (multicast_addr: SYSTEM_NET_IPADDRESS) is
		external
			"IL signature (System.Net.IPAddress): System.Void use System.Net.Sockets.UdpClient"
		alias
			"DropMulticastGroup"
		end

	frozen join_multicast_group_ipaddress_int32 (multicast_addr: SYSTEM_NET_IPADDRESS; time_to_live: INTEGER) is
		external
			"IL signature (System.Net.IPAddress, System.Int32): System.Void use System.Net.Sockets.UdpClient"
		alias
			"JoinMulticastGroup"
		end

	frozen send (dgram: ARRAY [INTEGER_8]; bytes: INTEGER): INTEGER is
		external
			"IL signature (System.Byte[], System.Int32): System.Int32 use System.Net.Sockets.UdpClient"
		alias
			"Send"
		end

	frozen connect (end_point: SYSTEM_NET_IPENDPOINT) is
		external
			"IL signature (System.Net.IPEndPoint): System.Void use System.Net.Sockets.UdpClient"
		alias
			"Connect"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Net.Sockets.UdpClient"
		alias
			"Equals"
		end

	frozen send_array_byte_int32_ipend_point (dgram: ARRAY [INTEGER_8]; bytes: INTEGER; end_point: SYSTEM_NET_IPENDPOINT): INTEGER is
		external
			"IL signature (System.Byte[], System.Int32, System.Net.IPEndPoint): System.Int32 use System.Net.Sockets.UdpClient"
		alias
			"Send"
		end

	frozen join_multicast_group (multicast_addr: SYSTEM_NET_IPADDRESS) is
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

	frozen get_client: SYSTEM_NET_SOCKETS_SOCKET is
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

	frozen set_client (value: SYSTEM_NET_SOCKETS_SOCKET) is
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

end -- class SYSTEM_NET_SOCKETS_UDPCLIENT
