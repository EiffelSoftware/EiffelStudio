indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Net.Sockets.Socket"

external class
	SYSTEM_NET_SOCKETS_SOCKET

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
	make

feature {NONE} -- Initialization

	frozen make (address_family: SYSTEM_NET_SOCKETS_ADDRESSFAMILY; socket_type: SYSTEM_NET_SOCKETS_SOCKETTYPE; protocol_type: SYSTEM_NET_SOCKETS_PROTOCOLTYPE) is
		external
			"IL creator signature (System.Net.Sockets.AddressFamily, System.Net.Sockets.SocketType, System.Net.Sockets.ProtocolType) use System.Net.Sockets.Socket"
		end

feature -- Access

	frozen get_available: INTEGER is
		external
			"IL signature (): System.Int32 use System.Net.Sockets.Socket"
		alias
			"get_Available"
		end

	frozen get_blocking: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Net.Sockets.Socket"
		alias
			"get_Blocking"
		end

	frozen get_socket_type: SYSTEM_NET_SOCKETS_SOCKETTYPE is
		external
			"IL signature (): System.Net.Sockets.SocketType use System.Net.Sockets.Socket"
		alias
			"get_SocketType"
		end

	frozen get_connected: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Net.Sockets.Socket"
		alias
			"get_Connected"
		end

	frozen get_local_end_point: SYSTEM_NET_ENDPOINT is
		external
			"IL signature (): System.Net.EndPoint use System.Net.Sockets.Socket"
		alias
			"get_LocalEndPoint"
		end

	frozen get_remote_end_point: SYSTEM_NET_ENDPOINT is
		external
			"IL signature (): System.Net.EndPoint use System.Net.Sockets.Socket"
		alias
			"get_RemoteEndPoint"
		end

	frozen get_handle: POINTER is
		external
			"IL signature (): System.IntPtr use System.Net.Sockets.Socket"
		alias
			"get_Handle"
		end

	frozen get_address_family: SYSTEM_NET_SOCKETS_ADDRESSFAMILY is
		external
			"IL signature (): System.Net.Sockets.AddressFamily use System.Net.Sockets.Socket"
		alias
			"get_AddressFamily"
		end

	frozen get_protocol_type: SYSTEM_NET_SOCKETS_PROTOCOLTYPE is
		external
			"IL signature (): System.Net.Sockets.ProtocolType use System.Net.Sockets.Socket"
		alias
			"get_ProtocolType"
		end

feature -- Element Change

	frozen set_blocking (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Net.Sockets.Socket"
		alias
			"set_Blocking"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Net.Sockets.Socket"
		alias
			"GetHashCode"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Net.Sockets.Socket"
		alias
			"ToString"
		end

	frozen set_socket_option_socket_option_level_socket_option_name_int32 (option_level: SYSTEM_NET_SOCKETS_SOCKETOPTIONLEVEL; option_name: SYSTEM_NET_SOCKETS_SOCKETOPTIONNAME; option_value: INTEGER) is
		external
			"IL signature (System.Net.Sockets.SocketOptionLevel, System.Net.Sockets.SocketOptionName, System.Int32): System.Void use System.Net.Sockets.Socket"
		alias
			"SetSocketOption"
		end

	frozen get_socket_option (option_level: SYSTEM_NET_SOCKETS_SOCKETOPTIONLEVEL; option_name: SYSTEM_NET_SOCKETS_SOCKETOPTIONNAME): ANY is
		external
			"IL signature (System.Net.Sockets.SocketOptionLevel, System.Net.Sockets.SocketOptionName): System.Object use System.Net.Sockets.Socket"
		alias
			"GetSocketOption"
		end

	frozen end_receive (async_result: SYSTEM_IASYNCRESULT): INTEGER is
		external
			"IL signature (System.IAsyncResult): System.Int32 use System.Net.Sockets.Socket"
		alias
			"EndReceive"
		end

	frozen begin_send_to (buffer: ARRAY [INTEGER_8]; offset: INTEGER; size: INTEGER; socket_flags: SYSTEM_NET_SOCKETS_SOCKETFLAGS; remote_ep: SYSTEM_NET_ENDPOINT; callback: SYSTEM_ASYNCCALLBACK; state: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32, System.Net.Sockets.SocketFlags, System.Net.EndPoint, System.AsyncCallback, System.Object): System.IAsyncResult use System.Net.Sockets.Socket"
		alias
			"BeginSendTo"
		end

	frozen bind (local_ep: SYSTEM_NET_ENDPOINT) is
		external
			"IL signature (System.Net.EndPoint): System.Void use System.Net.Sockets.Socket"
		alias
			"Bind"
		end

	frozen send_array_byte_socket_flags (buffer: ARRAY [INTEGER_8]; socket_flags: SYSTEM_NET_SOCKETS_SOCKETFLAGS): INTEGER is
		external
			"IL signature (System.Byte[], System.Net.Sockets.SocketFlags): System.Int32 use System.Net.Sockets.Socket"
		alias
			"Send"
		end

	frozen receive_array_byte_socket_flags (buffer: ARRAY [INTEGER_8]; socket_flags: SYSTEM_NET_SOCKETS_SOCKETFLAGS): INTEGER is
		external
			"IL signature (System.Byte[], System.Net.Sockets.SocketFlags): System.Int32 use System.Net.Sockets.Socket"
		alias
			"Receive"
		end

	frozen send_to_array_byte_int32_int32 (buffer: ARRAY [INTEGER_8]; offset: INTEGER; size: INTEGER; socket_flags: SYSTEM_NET_SOCKETS_SOCKETFLAGS; remote_ep: SYSTEM_NET_ENDPOINT): INTEGER is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32, System.Net.Sockets.SocketFlags, System.Net.EndPoint): System.Int32 use System.Net.Sockets.Socket"
		alias
			"SendTo"
		end

	frozen send (buffer: ARRAY [INTEGER_8]): INTEGER is
		external
			"IL signature (System.Byte[]): System.Int32 use System.Net.Sockets.Socket"
		alias
			"Send"
		end

	frozen receive_from_array_byte_int32_int32 (buffer: ARRAY [INTEGER_8]; offset: INTEGER; size: INTEGER; socket_flags: SYSTEM_NET_SOCKETS_SOCKETFLAGS; remote_ep: SYSTEM_NET_ENDPOINT): INTEGER is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32, System.Net.Sockets.SocketFlags, System.Net.EndPoint&): System.Int32 use System.Net.Sockets.Socket"
		alias
			"ReceiveFrom"
		end

	frozen receive_array_byte_int32_socket_flags (buffer: ARRAY [INTEGER_8]; size: INTEGER; socket_flags: SYSTEM_NET_SOCKETS_SOCKETFLAGS): INTEGER is
		external
			"IL signature (System.Byte[], System.Int32, System.Net.Sockets.SocketFlags): System.Int32 use System.Net.Sockets.Socket"
		alias
			"Receive"
		end

	frozen send_to_array_byte_int32_socket_flags (buffer: ARRAY [INTEGER_8]; size: INTEGER; socket_flags: SYSTEM_NET_SOCKETS_SOCKETFLAGS; remote_ep: SYSTEM_NET_ENDPOINT): INTEGER is
		external
			"IL signature (System.Byte[], System.Int32, System.Net.Sockets.SocketFlags, System.Net.EndPoint): System.Int32 use System.Net.Sockets.Socket"
		alias
			"SendTo"
		end

	frozen end_accept (async_result: SYSTEM_IASYNCRESULT): SYSTEM_NET_SOCKETS_SOCKET is
		external
			"IL signature (System.IAsyncResult): System.Net.Sockets.Socket use System.Net.Sockets.Socket"
		alias
			"EndAccept"
		end

	frozen get_socket_option_socket_option_level_socket_option_name_int32 (option_level: SYSTEM_NET_SOCKETS_SOCKETOPTIONLEVEL; option_name: SYSTEM_NET_SOCKETS_SOCKETOPTIONNAME; option_length: INTEGER): ARRAY [INTEGER_8] is
		external
			"IL signature (System.Net.Sockets.SocketOptionLevel, System.Net.Sockets.SocketOptionName, System.Int32): System.Byte[] use System.Net.Sockets.Socket"
		alias
			"GetSocketOption"
		end

	frozen send_array_byte_int32_socket_flags (buffer: ARRAY [INTEGER_8]; size: INTEGER; socket_flags: SYSTEM_NET_SOCKETS_SOCKETFLAGS): INTEGER is
		external
			"IL signature (System.Byte[], System.Int32, System.Net.Sockets.SocketFlags): System.Int32 use System.Net.Sockets.Socket"
		alias
			"Send"
		end

	frozen Select_ (check_read: SYSTEM_COLLECTIONS_ILIST; check_write: SYSTEM_COLLECTIONS_ILIST; check_error: SYSTEM_COLLECTIONS_ILIST; micro_seconds: INTEGER) is
		external
			"IL static signature (System.Collections.IList, System.Collections.IList, System.Collections.IList, System.Int32): System.Void use System.Net.Sockets.Socket"
		alias
			"Select"
		end

	frozen set_socket_option_socket_option_level_socket_option_name_array_byte (option_level: SYSTEM_NET_SOCKETS_SOCKETOPTIONLEVEL; option_name: SYSTEM_NET_SOCKETS_SOCKETOPTIONNAME; option_value: ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Net.Sockets.SocketOptionLevel, System.Net.Sockets.SocketOptionName, System.Byte[]): System.Void use System.Net.Sockets.Socket"
		alias
			"SetSocketOption"
		end

	frozen send_array_byte_int32_int32 (buffer: ARRAY [INTEGER_8]; offset: INTEGER; size: INTEGER; socket_flags: SYSTEM_NET_SOCKETS_SOCKETFLAGS): INTEGER is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32, System.Net.Sockets.SocketFlags): System.Int32 use System.Net.Sockets.Socket"
		alias
			"Send"
		end

	frozen end_connect (async_result: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Net.Sockets.Socket"
		alias
			"EndConnect"
		end

	frozen close is
		external
			"IL signature (): System.Void use System.Net.Sockets.Socket"
		alias
			"Close"
		end

	frozen end_send (async_result: SYSTEM_IASYNCRESULT): INTEGER is
		external
			"IL signature (System.IAsyncResult): System.Int32 use System.Net.Sockets.Socket"
		alias
			"EndSend"
		end

	frozen end_receive_from (async_result: SYSTEM_IASYNCRESULT; end_point: SYSTEM_NET_ENDPOINT): INTEGER is
		external
			"IL signature (System.IAsyncResult, System.Net.EndPoint&): System.Int32 use System.Net.Sockets.Socket"
		alias
			"EndReceiveFrom"
		end

	frozen receive (buffer: ARRAY [INTEGER_8]): INTEGER is
		external
			"IL signature (System.Byte[]): System.Int32 use System.Net.Sockets.Socket"
		alias
			"Receive"
		end

	frozen poll (micro_seconds: INTEGER; mode: SYSTEM_NET_SOCKETS_SELECTMODE): BOOLEAN is
		external
			"IL signature (System.Int32, System.Net.Sockets.SelectMode): System.Boolean use System.Net.Sockets.Socket"
		alias
			"Poll"
		end

	frozen accept: SYSTEM_NET_SOCKETS_SOCKET is
		external
			"IL signature (): System.Net.Sockets.Socket use System.Net.Sockets.Socket"
		alias
			"Accept"
		end

	frozen shutdown (how: SYSTEM_NET_SOCKETS_SOCKETSHUTDOWN) is
		external
			"IL signature (System.Net.Sockets.SocketShutdown): System.Void use System.Net.Sockets.Socket"
		alias
			"Shutdown"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Net.Sockets.Socket"
		alias
			"Equals"
		end

	frozen connect (remote_ep: SYSTEM_NET_ENDPOINT) is
		external
			"IL signature (System.Net.EndPoint): System.Void use System.Net.Sockets.Socket"
		alias
			"Connect"
		end

	frozen send_to (buffer: ARRAY [INTEGER_8]; remote_ep: SYSTEM_NET_ENDPOINT): INTEGER is
		external
			"IL signature (System.Byte[], System.Net.EndPoint): System.Int32 use System.Net.Sockets.Socket"
		alias
			"SendTo"
		end

	frozen receive_from (buffer: ARRAY [INTEGER_8]; remote_ep: SYSTEM_NET_ENDPOINT): INTEGER is
		external
			"IL signature (System.Byte[], System.Net.EndPoint&): System.Int32 use System.Net.Sockets.Socket"
		alias
			"ReceiveFrom"
		end

	frozen set_socket_option (option_level: SYSTEM_NET_SOCKETS_SOCKETOPTIONLEVEL; option_name: SYSTEM_NET_SOCKETS_SOCKETOPTIONNAME; option_value: ANY) is
		external
			"IL signature (System.Net.Sockets.SocketOptionLevel, System.Net.Sockets.SocketOptionName, System.Object): System.Void use System.Net.Sockets.Socket"
		alias
			"SetSocketOption"
		end

	frozen begin_send (buffer: ARRAY [INTEGER_8]; offset: INTEGER; size: INTEGER; socket_flags: SYSTEM_NET_SOCKETS_SOCKETFLAGS; callback: SYSTEM_ASYNCCALLBACK; state: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32, System.Net.Sockets.SocketFlags, System.AsyncCallback, System.Object): System.IAsyncResult use System.Net.Sockets.Socket"
		alias
			"BeginSend"
		end

	frozen send_to_array_byte_socket_flags (buffer: ARRAY [INTEGER_8]; socket_flags: SYSTEM_NET_SOCKETS_SOCKETFLAGS; remote_ep: SYSTEM_NET_ENDPOINT): INTEGER is
		external
			"IL signature (System.Byte[], System.Net.Sockets.SocketFlags, System.Net.EndPoint): System.Int32 use System.Net.Sockets.Socket"
		alias
			"SendTo"
		end

	frozen begin_accept (callback: SYSTEM_ASYNCCALLBACK; state: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.AsyncCallback, System.Object): System.IAsyncResult use System.Net.Sockets.Socket"
		alias
			"BeginAccept"
		end

	frozen iocontrol (io_control_code: INTEGER; option_in_value: ARRAY [INTEGER_8]; option_out_value: ARRAY [INTEGER_8]): INTEGER is
		external
			"IL signature (System.Int32, System.Byte[], System.Byte[]): System.Int32 use System.Net.Sockets.Socket"
		alias
			"IOControl"
		end

	frozen receive_from_array_byte_int32_socket_flags (buffer: ARRAY [INTEGER_8]; size: INTEGER; socket_flags: SYSTEM_NET_SOCKETS_SOCKETFLAGS; remote_ep: SYSTEM_NET_ENDPOINT): INTEGER is
		external
			"IL signature (System.Byte[], System.Int32, System.Net.Sockets.SocketFlags, System.Net.EndPoint&): System.Int32 use System.Net.Sockets.Socket"
		alias
			"ReceiveFrom"
		end

	frozen receive_from_array_byte_socket_flags (buffer: ARRAY [INTEGER_8]; socket_flags: SYSTEM_NET_SOCKETS_SOCKETFLAGS; remote_ep: SYSTEM_NET_ENDPOINT): INTEGER is
		external
			"IL signature (System.Byte[], System.Net.Sockets.SocketFlags, System.Net.EndPoint&): System.Int32 use System.Net.Sockets.Socket"
		alias
			"ReceiveFrom"
		end

	frozen end_send_to (async_result: SYSTEM_IASYNCRESULT): INTEGER is
		external
			"IL signature (System.IAsyncResult): System.Int32 use System.Net.Sockets.Socket"
		alias
			"EndSendTo"
		end

	frozen begin_connect (remote_ep: SYSTEM_NET_ENDPOINT; callback: SYSTEM_ASYNCCALLBACK; state: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Net.EndPoint, System.AsyncCallback, System.Object): System.IAsyncResult use System.Net.Sockets.Socket"
		alias
			"BeginConnect"
		end

	frozen begin_receive_from (buffer: ARRAY [INTEGER_8]; offset: INTEGER; size: INTEGER; socket_flags: SYSTEM_NET_SOCKETS_SOCKETFLAGS; remote_ep: SYSTEM_NET_ENDPOINT; callback: SYSTEM_ASYNCCALLBACK; state: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32, System.Net.Sockets.SocketFlags, System.Net.EndPoint&, System.AsyncCallback, System.Object): System.IAsyncResult use System.Net.Sockets.Socket"
		alias
			"BeginReceiveFrom"
		end

	frozen get_socket_option_socket_option_level_socket_option_name_array_byte (option_level: SYSTEM_NET_SOCKETS_SOCKETOPTIONLEVEL; option_name: SYSTEM_NET_SOCKETS_SOCKETOPTIONNAME; option_value: ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Net.Sockets.SocketOptionLevel, System.Net.Sockets.SocketOptionName, System.Byte[]): System.Void use System.Net.Sockets.Socket"
		alias
			"GetSocketOption"
		end

	frozen listen (backlog: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Net.Sockets.Socket"
		alias
			"Listen"
		end

	frozen begin_receive (buffer: ARRAY [INTEGER_8]; offset: INTEGER; size: INTEGER; socket_flags: SYSTEM_NET_SOCKETS_SOCKETFLAGS; callback: SYSTEM_ASYNCCALLBACK; state: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32, System.Net.Sockets.SocketFlags, System.AsyncCallback, System.Object): System.IAsyncResult use System.Net.Sockets.Socket"
		alias
			"BeginReceive"
		end

	frozen receive_array_byte_int32_int32 (buffer: ARRAY [INTEGER_8]; offset: INTEGER; size: INTEGER; socket_flags: SYSTEM_NET_SOCKETS_SOCKETFLAGS): INTEGER is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32, System.Net.Sockets.SocketFlags): System.Int32 use System.Net.Sockets.Socket"
		alias
			"Receive"
		end

feature {NONE} -- Implementation

	dispose (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Net.Sockets.Socket"
		alias
			"Dispose"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Net.Sockets.Socket"
		alias
			"Finalize"
		end

	frozen system_idisposable_dispose is
		external
			"IL signature (): System.Void use System.Net.Sockets.Socket"
		alias
			"System.IDisposable.Dispose"
		end

end -- class SYSTEM_NET_SOCKETS_SOCKET
