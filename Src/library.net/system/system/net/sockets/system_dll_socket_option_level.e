indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Net.Sockets.SocketOptionLevel"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DLL_SOCKET_OPTION_LEVEL

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen tcp: SYSTEM_DLL_SOCKET_OPTION_LEVEL is
		external
			"IL enum signature :System.Net.Sockets.SocketOptionLevel use System.Net.Sockets.SocketOptionLevel"
		alias
			"6"
		end

	frozen ip: SYSTEM_DLL_SOCKET_OPTION_LEVEL is
		external
			"IL enum signature :System.Net.Sockets.SocketOptionLevel use System.Net.Sockets.SocketOptionLevel"
		alias
			"0"
		end

	frozen socket: SYSTEM_DLL_SOCKET_OPTION_LEVEL is
		external
			"IL enum signature :System.Net.Sockets.SocketOptionLevel use System.Net.Sockets.SocketOptionLevel"
		alias
			"65535"
		end

	frozen udp: SYSTEM_DLL_SOCKET_OPTION_LEVEL is
		external
			"IL enum signature :System.Net.Sockets.SocketOptionLevel use System.Net.Sockets.SocketOptionLevel"
		alias
			"17"
		end

end -- class SYSTEM_DLL_SOCKET_OPTION_LEVEL
