indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Net.Sockets.TcpClient"

external class
	SYSTEM_NET_SOCKETS_TCPCLIENT

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
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (hostname: STRING; port: INTEGER) is
		external
			"IL creator signature (System.String, System.Int32) use System.Net.Sockets.TcpClient"
		end

	frozen make (local_ep: SYSTEM_NET_IPENDPOINT) is
		external
			"IL creator signature (System.Net.IPEndPoint) use System.Net.Sockets.TcpClient"
		end

	frozen make_1 is
		external
			"IL creator use System.Net.Sockets.TcpClient"
		end

feature -- Access

	frozen get_linger_state: SYSTEM_NET_SOCKETS_LINGEROPTION is
		external
			"IL signature (): System.Net.Sockets.LingerOption use System.Net.Sockets.TcpClient"
		alias
			"get_LingerState"
		end

	frozen get_receive_buffer_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.Net.Sockets.TcpClient"
		alias
			"get_ReceiveBufferSize"
		end

	frozen get_send_timeout: INTEGER is
		external
			"IL signature (): System.Int32 use System.Net.Sockets.TcpClient"
		alias
			"get_SendTimeout"
		end

	frozen get_receive_timeout: INTEGER is
		external
			"IL signature (): System.Int32 use System.Net.Sockets.TcpClient"
		alias
			"get_ReceiveTimeout"
		end

	frozen get_no_delay: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Net.Sockets.TcpClient"
		alias
			"get_NoDelay"
		end

	frozen get_send_buffer_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.Net.Sockets.TcpClient"
		alias
			"get_SendBufferSize"
		end

feature -- Element Change

	frozen set_no_delay (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Net.Sockets.TcpClient"
		alias
			"set_NoDelay"
		end

	frozen set_send_timeout (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Net.Sockets.TcpClient"
		alias
			"set_SendTimeout"
		end

	frozen set_linger_state (value: SYSTEM_NET_SOCKETS_LINGEROPTION) is
		external
			"IL signature (System.Net.Sockets.LingerOption): System.Void use System.Net.Sockets.TcpClient"
		alias
			"set_LingerState"
		end

	frozen set_send_buffer_size (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Net.Sockets.TcpClient"
		alias
			"set_SendBufferSize"
		end

	frozen set_receive_timeout (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Net.Sockets.TcpClient"
		alias
			"set_ReceiveTimeout"
		end

	frozen set_receive_buffer_size (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Net.Sockets.TcpClient"
		alias
			"set_ReceiveBufferSize"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Net.Sockets.TcpClient"
		alias
			"ToString"
		end

	frozen get_stream: SYSTEM_NET_SOCKETS_NETWORKSTREAM is
		external
			"IL signature (): System.Net.Sockets.NetworkStream use System.Net.Sockets.TcpClient"
		alias
			"GetStream"
		end

	frozen connect_string (hostname: STRING; port: INTEGER) is
		external
			"IL signature (System.String, System.Int32): System.Void use System.Net.Sockets.TcpClient"
		alias
			"Connect"
		end

	frozen connect_ipaddress (address: SYSTEM_NET_IPADDRESS; port: INTEGER) is
		external
			"IL signature (System.Net.IPAddress, System.Int32): System.Void use System.Net.Sockets.TcpClient"
		alias
			"Connect"
		end

	frozen close is
		external
			"IL signature (): System.Void use System.Net.Sockets.TcpClient"
		alias
			"Close"
		end

	frozen connect (remote_ep: SYSTEM_NET_IPENDPOINT) is
		external
			"IL signature (System.Net.IPEndPoint): System.Void use System.Net.Sockets.TcpClient"
		alias
			"Connect"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Net.Sockets.TcpClient"
		alias
			"Equals"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Net.Sockets.TcpClient"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	dispose (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Net.Sockets.TcpClient"
		alias
			"Dispose"
		end

	frozen get_client: SYSTEM_NET_SOCKETS_SOCKET is
		external
			"IL signature (): System.Net.Sockets.Socket use System.Net.Sockets.TcpClient"
		alias
			"get_Client"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Net.Sockets.TcpClient"
		alias
			"Finalize"
		end

	frozen set_client (value: SYSTEM_NET_SOCKETS_SOCKET) is
		external
			"IL signature (System.Net.Sockets.Socket): System.Void use System.Net.Sockets.TcpClient"
		alias
			"set_Client"
		end

	frozen set_active (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Net.Sockets.TcpClient"
		alias
			"set_Active"
		end

	frozen system_idisposable_dispose is
		external
			"IL signature (): System.Void use System.Net.Sockets.TcpClient"
		alias
			"System.IDisposable.Dispose"
		end

	frozen get_active: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Net.Sockets.TcpClient"
		alias
			"get_Active"
		end

end -- class SYSTEM_NET_SOCKETS_TCPCLIENT
