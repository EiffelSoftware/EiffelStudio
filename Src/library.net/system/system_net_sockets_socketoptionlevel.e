indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Net.Sockets.SocketOptionLevel"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_NET_SOCKETS_SOCKETOPTIONLEVEL

inherit
	ENUM
		rename
			is_equal as equals_object
		end
	SYSTEM_IFORMATTABLE
		rename
			is_equal as equals_object
		end
	SYSTEM_ICOMPARABLE
		rename
			is_equal as equals_object
		end

feature -- Access

	frozen tcp: SYSTEM_NET_SOCKETS_SOCKETOPTIONLEVEL is
		external
			"IL enum signature :System.Net.Sockets.SocketOptionLevel use System.Net.Sockets.SocketOptionLevel"
		alias
			"6"
		end

	frozen ip: SYSTEM_NET_SOCKETS_SOCKETOPTIONLEVEL is
		external
			"IL enum signature :System.Net.Sockets.SocketOptionLevel use System.Net.Sockets.SocketOptionLevel"
		alias
			"0"
		end

	frozen socket: SYSTEM_NET_SOCKETS_SOCKETOPTIONLEVEL is
		external
			"IL enum signature :System.Net.Sockets.SocketOptionLevel use System.Net.Sockets.SocketOptionLevel"
		alias
			"65535"
		end

	frozen udp: SYSTEM_NET_SOCKETS_SOCKETOPTIONLEVEL is
		external
			"IL enum signature :System.Net.Sockets.SocketOptionLevel use System.Net.Sockets.SocketOptionLevel"
		alias
			"17"
		end

end -- class SYSTEM_NET_SOCKETS_SOCKETOPTIONLEVEL
