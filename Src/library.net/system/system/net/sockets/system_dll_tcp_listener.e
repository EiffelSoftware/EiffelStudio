indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Net.Sockets.TcpListener"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_TCP_LISTENER

inherit
	SYSTEM_OBJECT
		redefine
			finalize
		end

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (port: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Net.Sockets.TcpListener"
		end

	frozen make (local_ep: SYSTEM_DLL_IPEND_POINT) is
		external
			"IL creator signature (System.Net.IPEndPoint) use System.Net.Sockets.TcpListener"
		end

	frozen make_1 (localaddr: SYSTEM_DLL_IPADDRESS; port: INTEGER) is
		external
			"IL creator signature (System.Net.IPAddress, System.Int32) use System.Net.Sockets.TcpListener"
		end

feature -- Access

	frozen get_local_endpoint: SYSTEM_DLL_END_POINT is
		external
			"IL signature (): System.Net.EndPoint use System.Net.Sockets.TcpListener"
		alias
			"get_LocalEndpoint"
		end

feature -- Basic Operations

	frozen accept_socket: SYSTEM_DLL_SOCKET is
		external
			"IL signature (): System.Net.Sockets.Socket use System.Net.Sockets.TcpListener"
		alias
			"AcceptSocket"
		end

	frozen pending: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Net.Sockets.TcpListener"
		alias
			"Pending"
		end

	frozen start is
		external
			"IL signature (): System.Void use System.Net.Sockets.TcpListener"
		alias
			"Start"
		end

	frozen accept_tcp_client: SYSTEM_DLL_TCP_CLIENT is
		external
			"IL signature (): System.Net.Sockets.TcpClient use System.Net.Sockets.TcpListener"
		alias
			"AcceptTcpClient"
		end

	frozen stop is
		external
			"IL signature (): System.Void use System.Net.Sockets.TcpListener"
		alias
			"Stop"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Net.Sockets.TcpListener"
		alias
			"Finalize"
		end

	frozen get_active: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Net.Sockets.TcpListener"
		alias
			"get_Active"
		end

	frozen get_server: SYSTEM_DLL_SOCKET is
		external
			"IL signature (): System.Net.Sockets.Socket use System.Net.Sockets.TcpListener"
		alias
			"get_Server"
		end

end -- class SYSTEM_DLL_TCP_LISTENER
