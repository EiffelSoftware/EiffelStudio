indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Net.Sockets.NetworkStream"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_NETWORK_STREAM

inherit
	SYSTEM_STREAM
		redefine
			end_write,
			begin_write,
			end_read,
			begin_read,
			close,
			finalize
		end
	IDISPOSABLE
		rename
			dispose as system_idisposable_dispose_void
		select
			system_idisposable_dispose_void
		end

create
	make_system_dll_network_stream_1,
	make_system_dll_network_stream_2,
	make_system_dll_network_stream_3,
	make_system_dll_network_stream

feature {NONE} -- Initialization

	frozen make_system_dll_network_stream_1 (socket: SYSTEM_DLL_SOCKET; owns_socket: BOOLEAN) is
		external
			"IL creator signature (System.Net.Sockets.Socket, System.Boolean) use System.Net.Sockets.NetworkStream"
		end

	frozen make_system_dll_network_stream_2 (socket: SYSTEM_DLL_SOCKET; access: FILE_ACCESS) is
		external
			"IL creator signature (System.Net.Sockets.Socket, System.IO.FileAccess) use System.Net.Sockets.NetworkStream"
		end

	frozen make_system_dll_network_stream_3 (socket: SYSTEM_DLL_SOCKET; access: FILE_ACCESS; owns_socket: BOOLEAN) is
		external
			"IL creator signature (System.Net.Sockets.Socket, System.IO.FileAccess, System.Boolean) use System.Net.Sockets.NetworkStream"
		end

	frozen make_system_dll_network_stream (socket: SYSTEM_DLL_SOCKET) is
		external
			"IL creator signature (System.Net.Sockets.Socket) use System.Net.Sockets.NetworkStream"
		end

feature -- Access

	get_can_write: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Net.Sockets.NetworkStream"
		alias
			"get_CanWrite"
		end

	get_can_read: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Net.Sockets.NetworkStream"
		alias
			"get_CanRead"
		end

	get_length: INTEGER_64 is
		external
			"IL signature (): System.Int64 use System.Net.Sockets.NetworkStream"
		alias
			"get_Length"
		end

	get_can_seek: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Net.Sockets.NetworkStream"
		alias
			"get_CanSeek"
		end

	get_position: INTEGER_64 is
		external
			"IL signature (): System.Int64 use System.Net.Sockets.NetworkStream"
		alias
			"get_Position"
		end

	get_data_available: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Net.Sockets.NetworkStream"
		alias
			"get_DataAvailable"
		end

feature -- Element Change

	set_position (value: INTEGER_64) is
		external
			"IL signature (System.Int64): System.Void use System.Net.Sockets.NetworkStream"
		alias
			"set_Position"
		end

feature -- Basic Operations

	read (buffer: NATIVE_ARRAY [INTEGER_8]; offset: INTEGER; size: INTEGER): INTEGER is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32): System.Int32 use System.Net.Sockets.NetworkStream"
		alias
			"Read"
		end

	close is
		external
			"IL signature (): System.Void use System.Net.Sockets.NetworkStream"
		alias
			"Close"
		end

	set_length (value: INTEGER_64) is
		external
			"IL signature (System.Int64): System.Void use System.Net.Sockets.NetworkStream"
		alias
			"SetLength"
		end

	end_write (async_result: IASYNC_RESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Net.Sockets.NetworkStream"
		alias
			"EndWrite"
		end

	begin_write (buffer: NATIVE_ARRAY [INTEGER_8]; offset: INTEGER; size: INTEGER; callback: ASYNC_CALLBACK; state: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32, System.AsyncCallback, System.Object): System.IAsyncResult use System.Net.Sockets.NetworkStream"
		alias
			"BeginWrite"
		end

	flush is
		external
			"IL signature (): System.Void use System.Net.Sockets.NetworkStream"
		alias
			"Flush"
		end

	begin_read (buffer: NATIVE_ARRAY [INTEGER_8]; offset: INTEGER; size: INTEGER; callback: ASYNC_CALLBACK; state: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32, System.AsyncCallback, System.Object): System.IAsyncResult use System.Net.Sockets.NetworkStream"
		alias
			"BeginRead"
		end

	end_read (async_result: IASYNC_RESULT): INTEGER is
		external
			"IL signature (System.IAsyncResult): System.Int32 use System.Net.Sockets.NetworkStream"
		alias
			"EndRead"
		end

	write (buffer: NATIVE_ARRAY [INTEGER_8]; offset: INTEGER; size: INTEGER) is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32): System.Void use System.Net.Sockets.NetworkStream"
		alias
			"Write"
		end

	seek (offset: INTEGER_64; origin: SEEK_ORIGIN): INTEGER_64 is
		external
			"IL signature (System.Int64, System.IO.SeekOrigin): System.Int64 use System.Net.Sockets.NetworkStream"
		alias
			"Seek"
		end

feature {NONE} -- Implementation

	frozen get_socket: SYSTEM_DLL_SOCKET is
		external
			"IL signature (): System.Net.Sockets.Socket use System.Net.Sockets.NetworkStream"
		alias
			"get_Socket"
		end

	frozen set_readable (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Net.Sockets.NetworkStream"
		alias
			"set_Readable"
		end

	frozen get_readable: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Net.Sockets.NetworkStream"
		alias
			"get_Readable"
		end

	frozen system_idisposable_dispose_void is
		external
			"IL signature (): System.Void use System.Net.Sockets.NetworkStream"
		alias
			"System.IDisposable.Dispose"
		end

	frozen set_writeable (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Net.Sockets.NetworkStream"
		alias
			"set_Writeable"
		end

	dispose (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Net.Sockets.NetworkStream"
		alias
			"Dispose"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Net.Sockets.NetworkStream"
		alias
			"Finalize"
		end

	frozen get_writeable: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Net.Sockets.NetworkStream"
		alias
			"get_Writeable"
		end

end -- class SYSTEM_DLL_NETWORK_STREAM
