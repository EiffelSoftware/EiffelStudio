indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Net.Sockets.Socket"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_SOCKET

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
	make

feature {NONE} -- Initialization

	frozen make (address_family: SYSTEM_DLL_ADDRESS_FAMILY; socket_type: SYSTEM_DLL_SOCKET_TYPE; protocol_type: SYSTEM_DLL_PROTOCOL_TYPE) is
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

	frozen get_socket_type: SYSTEM_DLL_SOCKET_TYPE is
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

	frozen get_local_end_point: SYSTEM_DLL_END_POINT is
		external
			"IL signature (): System.Net.EndPoint use System.Net.Sockets.Socket"
		alias
			"get_LocalEndPoint"
		end

	frozen get_remote_end_point: SYSTEM_DLL_END_POINT is
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

	frozen get_address_family: SYSTEM_DLL_ADDRESS_FAMILY is
		external
			"IL signature (): System.Net.Sockets.AddressFamily use System.Net.Sockets.Socket"
		alias
			"get_AddressFamily"
		end

	frozen get_protocol_type: SYSTEM_DLL_PROTOCOL_TYPE is
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

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Net.Sockets.Socket"
		alias
			"ToString"
		end

	frozen set_socket_option_socket_option_level_socket_option_name_int32 (option_level: SYSTEM_DLL_SOCKET_OPTION_LEVEL; option_name: SYSTEM_DLL_SOCKET_OPTION_NAME; option_value: INTEGER) is
		external
			"IL signature (System.Net.Sockets.SocketOptionLevel, System.Net.Sockets.SocketOptionName, System.Int32): System.Void use System.Net.Sockets.Socket"
		alias
			"SetSocketOption"
		end

	frozen get_socket_option (option_level: SYSTEM_DLL_SOCKET_OPTION_LEVEL; option_name: SYSTEM_DLL_SOCKET_OPTION_NAME): SYSTEM_OBJECT is
		external
			"IL signature (System.Net.Sockets.SocketOptionLevel, System.Net.Sockets.SocketOptionName): System.Object use System.Net.Sockets.Socket"
		alias
			"GetSocketOption"
		end

	frozen end_receive (async_result: IASYNC_RESULT): INTEGER is
		external
			"IL signature (System.IAsyncResult): System.Int32 use System.Net.Sockets.Socket"
		alias
			"EndReceive"
		end

	frozen begin_send_to (buffer: NATIVE_ARRAY [INTEGER_8]; offset: INTEGER; size: INTEGER; socket_flags: SYSTEM_DLL_SOCKET_FLAGS; remote_ep: SYSTEM_DLL_END_POINT; callback: ASYNC_CALLBACK; state: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32, System.Net.Sockets.SocketFlags, System.Net.EndPoint, System.AsyncCallback, System.Object): System.IAsyncResult use System.Net.Sockets.Socket"
		alias
			"BeginSendTo"
		end

	frozen bind (local_ep: SYSTEM_DLL_END_POINT) is
		external
			"IL signature (System.Net.EndPoint): System.Void use System.Net.Sockets.Socket"
		alias
			"Bind"
		end

	frozen send_array_byte_socket_flags (buffer: NATIVE_ARRAY [INTEGER_8]; socket_flags: SYSTEM_DLL_SOCKET_FLAGS): INTEGER is
		external
			"IL signature (System.Byte[], System.Net.Sockets.SocketFlags): System.Int32 use System.Net.Sockets.Socket"
		alias
			"Send"
		end

	frozen receive_array_byte_socket_flags (buffer: NATIVE_ARRAY [INTEGER_8]; socket_flags: SYSTEM_DLL_SOCKET_FLAGS): INTEGER is
		external
			"IL signature (System.Byte[], System.Net.Sockets.SocketFlags): System.Int32 use System.Net.Sockets.Socket"
		alias
			"Receive"
		end

	frozen select_ (check_read: ILIST; check_write: ILIST; check_error: ILIST; micro_seconds: INTEGER) is
		external
			"IL static signature (System.Collections.IList, System.Collections.IList, System.Collections.IList, System.Int32): System.Void use System.Net.Sockets.Socket"
		alias
			"Select"
		end

	frozen send_to_array_byte_int32_int32 (buffer: NATIVE_ARRAY [INTEGER_8]; offset: INTEGER; size: INTEGER; socket_flags: SYSTEM_DLL_SOCKET_FLAGS; remote_ep: SYSTEM_DLL_END_POINT): INTEGER is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32, System.Net.Sockets.SocketFlags, System.Net.EndPoint): System.Int32 use System.Net.Sockets.Socket"
		alias
			"SendTo"
		end

	frozen send (buffer: NATIVE_ARRAY [INTEGER_8]): INTEGER is
		external
			"IL signature (System.Byte[]): System.Int32 use System.Net.Sockets.Socket"
		alias
			"Send"
		end

	frozen receive_from_array_byte_int32_int32 (buffer: NATIVE_ARRAY [INTEGER_8]; offset: INTEGER; size: INTEGER; socket_flags: SYSTEM_DLL_SOCKET_FLAGS; remote_ep: SYSTEM_DLL_END_POINT): INTEGER is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32, System.Net.Sockets.SocketFlags, System.Net.EndPoint&): System.Int32 use System.Net.Sockets.Socket"
		alias
			"ReceiveFrom"
		end

	frozen receive_array_byte_int32_socket_flags (buffer: NATIVE_ARRAY [INTEGER_8]; size: INTEGER; socket_flags: SYSTEM_DLL_SOCKET_FLAGS): INTEGER is
		external
			"IL signature (System.Byte[], System.Int32, System.Net.Sockets.SocketFlags): System.Int32 use System.Net.Sockets.Socket"
		alias
			"Receive"
		end

	frozen send_to_array_byte_int32_socket_flags (buffer: NATIVE_ARRAY [INTEGER_8]; size: INTEGER; socket_flags: SYSTEM_DLL_SOCKET_FLAGS; remote_ep: SYSTEM_DLL_END_POINT): INTEGER is
		external
			"IL signature (System.Byte[], System.Int32, System.Net.Sockets.SocketFlags, System.Net.EndPoint): System.Int32 use System.Net.Sockets.Socket"
		alias
			"SendTo"
		end

	frozen end_accept (async_result: IASYNC_RESULT): SYSTEM_DLL_SOCKET is
		external
			"IL signature (System.IAsyncResult): System.Net.Sockets.Socket use System.Net.Sockets.Socket"
		alias
			"EndAccept"
		end

	frozen get_socket_option_socket_option_level_socket_option_name_int32 (option_level: SYSTEM_DLL_SOCKET_OPTION_LEVEL; option_name: SYSTEM_DLL_SOCKET_OPTION_NAME; option_length: INTEGER): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (System.Net.Sockets.SocketOptionLevel, System.Net.Sockets.SocketOptionName, System.Int32): System.Byte[] use System.Net.Sockets.Socket"
		alias
			"GetSocketOption"
		end

	frozen send_array_byte_int32_socket_flags (buffer: NATIVE_ARRAY [INTEGER_8]; size: INTEGER; socket_flags: SYSTEM_DLL_SOCKET_FLAGS): INTEGER is
		external
			"IL signature (System.Byte[], System.Int32, System.Net.Sockets.SocketFlags): System.Int32 use System.Net.Sockets.Socket"
		alias
			"Send"
		end

	frozen set_socket_option_socket_option_level_socket_option_name_array_byte (option_level: SYSTEM_DLL_SOCKET_OPTION_LEVEL; option_name: SYSTEM_DLL_SOCKET_OPTION_NAME; option_value: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Net.Sockets.SocketOptionLevel, System.Net.Sockets.SocketOptionName, System.Byte[]): System.Void use System.Net.Sockets.Socket"
		alias
			"SetSocketOption"
		end

	frozen send_array_byte_int32_int32 (buffer: NATIVE_ARRAY [INTEGER_8]; offset: INTEGER; size: INTEGER; socket_flags: SYSTEM_DLL_SOCKET_FLAGS): INTEGER is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32, System.Net.Sockets.SocketFlags): System.Int32 use System.Net.Sockets.Socket"
		alias
			"Send"
		end

	frozen end_connect (async_result: IASYNC_RESULT) is
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

	frozen end_send (async_result: IASYNC_RESULT): INTEGER is
		external
			"IL signature (System.IAsyncResult): System.Int32 use System.Net.Sockets.Socket"
		alias
			"EndSend"
		end

	frozen end_receive_from (async_result: IASYNC_RESULT; end_point: SYSTEM_DLL_END_POINT): INTEGER is
		external
			"IL signature (System.IAsyncResult, System.Net.EndPoint&): System.Int32 use System.Net.Sockets.Socket"
		alias
			"EndReceiveFrom"
		end

	frozen receive (buffer: NATIVE_ARRAY [INTEGER_8]): INTEGER is
		external
			"IL signature (System.Byte[]): System.Int32 use System.Net.Sockets.Socket"
		alias
			"Receive"
		end

	frozen poll (micro_seconds: INTEGER; mode: SYSTEM_DLL_SELECT_MODE): BOOLEAN is
		external
			"IL signature (System.Int32, System.Net.Sockets.SelectMode): System.Boolean use System.Net.Sockets.Socket"
		alias
			"Poll"
		end

	frozen accept: SYSTEM_DLL_SOCKET is
		external
			"IL signature (): System.Net.Sockets.Socket use System.Net.Sockets.Socket"
		alias
			"Accept"
		end

	frozen shutdown (how: SYSTEM_DLL_SOCKET_SHUTDOWN) is
		external
			"IL signature (System.Net.Sockets.SocketShutdown): System.Void use System.Net.Sockets.Socket"
		alias
			"Shutdown"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Net.Sockets.Socket"
		alias
			"Equals"
		end

	frozen connect (remote_ep: SYSTEM_DLL_END_POINT) is
		external
			"IL signature (System.Net.EndPoint): System.Void use System.Net.Sockets.Socket"
		alias
			"Connect"
		end

	frozen send_to (buffer: NATIVE_ARRAY [INTEGER_8]; remote_ep: SYSTEM_DLL_END_POINT): INTEGER is
		external
			"IL signature (System.Byte[], System.Net.EndPoint): System.Int32 use System.Net.Sockets.Socket"
		alias
			"SendTo"
		end

	frozen receive_from (buffer: NATIVE_ARRAY [INTEGER_8]; remote_ep: SYSTEM_DLL_END_POINT): INTEGER is
		external
			"IL signature (System.Byte[], System.Net.EndPoint&): System.Int32 use System.Net.Sockets.Socket"
		alias
			"ReceiveFrom"
		end

	frozen set_socket_option (option_level: SYSTEM_DLL_SOCKET_OPTION_LEVEL; option_name: SYSTEM_DLL_SOCKET_OPTION_NAME; option_value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Net.Sockets.SocketOptionLevel, System.Net.Sockets.SocketOptionName, System.Object): System.Void use System.Net.Sockets.Socket"
		alias
			"SetSocketOption"
		end

	frozen begin_send (buffer: NATIVE_ARRAY [INTEGER_8]; offset: INTEGER; size: INTEGER; socket_flags: SYSTEM_DLL_SOCKET_FLAGS; callback: ASYNC_CALLBACK; state: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32, System.Net.Sockets.SocketFlags, System.AsyncCallback, System.Object): System.IAsyncResult use System.Net.Sockets.Socket"
		alias
			"BeginSend"
		end

	frozen send_to_array_byte_socket_flags (buffer: NATIVE_ARRAY [INTEGER_8]; socket_flags: SYSTEM_DLL_SOCKET_FLAGS; remote_ep: SYSTEM_DLL_END_POINT): INTEGER is
		external
			"IL signature (System.Byte[], System.Net.Sockets.SocketFlags, System.Net.EndPoint): System.Int32 use System.Net.Sockets.Socket"
		alias
			"SendTo"
		end

	frozen begin_accept (callback: ASYNC_CALLBACK; state: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.AsyncCallback, System.Object): System.IAsyncResult use System.Net.Sockets.Socket"
		alias
			"BeginAccept"
		end

	frozen iocontrol (io_control_code: INTEGER; option_in_value: NATIVE_ARRAY [INTEGER_8]; option_out_value: NATIVE_ARRAY [INTEGER_8]): INTEGER is
		external
			"IL signature (System.Int32, System.Byte[], System.Byte[]): System.Int32 use System.Net.Sockets.Socket"
		alias
			"IOControl"
		end

	frozen receive_from_array_byte_int32_socket_flags (buffer: NATIVE_ARRAY [INTEGER_8]; size: INTEGER; socket_flags: SYSTEM_DLL_SOCKET_FLAGS; remote_ep: SYSTEM_DLL_END_POINT): INTEGER is
		external
			"IL signature (System.Byte[], System.Int32, System.Net.Sockets.SocketFlags, System.Net.EndPoint&): System.Int32 use System.Net.Sockets.Socket"
		alias
			"ReceiveFrom"
		end

	frozen receive_from_array_byte_socket_flags (buffer: NATIVE_ARRAY [INTEGER_8]; socket_flags: SYSTEM_DLL_SOCKET_FLAGS; remote_ep: SYSTEM_DLL_END_POINT): INTEGER is
		external
			"IL signature (System.Byte[], System.Net.Sockets.SocketFlags, System.Net.EndPoint&): System.Int32 use System.Net.Sockets.Socket"
		alias
			"ReceiveFrom"
		end

	frozen end_send_to (async_result: IASYNC_RESULT): INTEGER is
		external
			"IL signature (System.IAsyncResult): System.Int32 use System.Net.Sockets.Socket"
		alias
			"EndSendTo"
		end

	frozen begin_connect (remote_ep: SYSTEM_DLL_END_POINT; callback: ASYNC_CALLBACK; state: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.Net.EndPoint, System.AsyncCallback, System.Object): System.IAsyncResult use System.Net.Sockets.Socket"
		alias
			"BeginConnect"
		end

	frozen begin_receive_from (buffer: NATIVE_ARRAY [INTEGER_8]; offset: INTEGER; size: INTEGER; socket_flags: SYSTEM_DLL_SOCKET_FLAGS; remote_ep: SYSTEM_DLL_END_POINT; callback: ASYNC_CALLBACK; state: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32, System.Net.Sockets.SocketFlags, System.Net.EndPoint&, System.AsyncCallback, System.Object): System.IAsyncResult use System.Net.Sockets.Socket"
		alias
			"BeginReceiveFrom"
		end

	frozen get_socket_option_socket_option_level_socket_option_name_array_byte (option_level: SYSTEM_DLL_SOCKET_OPTION_LEVEL; option_name: SYSTEM_DLL_SOCKET_OPTION_NAME; option_value: NATIVE_ARRAY [INTEGER_8]) is
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

	frozen begin_receive (buffer: NATIVE_ARRAY [INTEGER_8]; offset: INTEGER; size: INTEGER; socket_flags: SYSTEM_DLL_SOCKET_FLAGS; callback: ASYNC_CALLBACK; state: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32, System.Net.Sockets.SocketFlags, System.AsyncCallback, System.Object): System.IAsyncResult use System.Net.Sockets.Socket"
		alias
			"BeginReceive"
		end

	frozen receive_array_byte_int32_int32 (buffer: NATIVE_ARRAY [INTEGER_8]; offset: INTEGER; size: INTEGER; socket_flags: SYSTEM_DLL_SOCKET_FLAGS): INTEGER is
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

end -- class SYSTEM_DLL_SOCKET
