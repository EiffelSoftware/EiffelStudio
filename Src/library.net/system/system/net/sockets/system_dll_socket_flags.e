indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Net.Sockets.SocketFlags"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DLL_SOCKET_FLAGS

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen dont_route: SYSTEM_DLL_SOCKET_FLAGS is
		external
			"IL enum signature :System.Net.Sockets.SocketFlags use System.Net.Sockets.SocketFlags"
		alias
			"4"
		end

	frozen partial: SYSTEM_DLL_SOCKET_FLAGS is
		external
			"IL enum signature :System.Net.Sockets.SocketFlags use System.Net.Sockets.SocketFlags"
		alias
			"32768"
		end

	frozen none: SYSTEM_DLL_SOCKET_FLAGS is
		external
			"IL enum signature :System.Net.Sockets.SocketFlags use System.Net.Sockets.SocketFlags"
		alias
			"0"
		end

	frozen peek: SYSTEM_DLL_SOCKET_FLAGS is
		external
			"IL enum signature :System.Net.Sockets.SocketFlags use System.Net.Sockets.SocketFlags"
		alias
			"2"
		end

	frozen out_of_band: SYSTEM_DLL_SOCKET_FLAGS is
		external
			"IL enum signature :System.Net.Sockets.SocketFlags use System.Net.Sockets.SocketFlags"
		alias
			"1"
		end

	frozen max_iovector_length: SYSTEM_DLL_SOCKET_FLAGS is
		external
			"IL enum signature :System.Net.Sockets.SocketFlags use System.Net.Sockets.SocketFlags"
		alias
			"16"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class SYSTEM_DLL_SOCKET_FLAGS
