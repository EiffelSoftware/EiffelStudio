indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Net.Sockets.SocketException"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_SOCKET_EXCEPTION

inherit
	SYSTEM_DLL_WIN32_EXCEPTION
		redefine
			get_error_code
		end
	ISERIALIZABLE

create
	make_system_dll_socket_exception_1,
	make_system_dll_socket_exception

feature {NONE} -- Initialization

	frozen make_system_dll_socket_exception_1 (error_code: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Net.Sockets.SocketException"
		end

	frozen make_system_dll_socket_exception is
		external
			"IL creator use System.Net.Sockets.SocketException"
		end

feature -- Access

	get_error_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Net.Sockets.SocketException"
		alias
			"get_ErrorCode"
		end

end -- class SYSTEM_DLL_SOCKET_EXCEPTION
