indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Net.Sockets.SocketException"

external class
	SYSTEM_NET_SOCKETS_SOCKETEXCEPTION

inherit
	SYSTEM_COMPONENTMODEL_WIN32EXCEPTION
		redefine
			get_error_code
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_socketexception,
	make_socketexception_1

feature {NONE} -- Initialization

	frozen make_socketexception is
		external
			"IL creator use System.Net.Sockets.SocketException"
		end

	frozen make_socketexception_1 (error_code: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Net.Sockets.SocketException"
		end

feature -- Access

	get_error_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Net.Sockets.SocketException"
		alias
			"get_ErrorCode"
		end

end -- class SYSTEM_NET_SOCKETS_SOCKETEXCEPTION
