indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Net.Sockets.SocketShutdown"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_NET_SOCKETS_SOCKETSHUTDOWN

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

	frozen both: SYSTEM_NET_SOCKETS_SOCKETSHUTDOWN is
		external
			"IL enum signature :System.Net.Sockets.SocketShutdown use System.Net.Sockets.SocketShutdown"
		alias
			"2"
		end

	frozen send: SYSTEM_NET_SOCKETS_SOCKETSHUTDOWN is
		external
			"IL enum signature :System.Net.Sockets.SocketShutdown use System.Net.Sockets.SocketShutdown"
		alias
			"1"
		end

	frozen receive: SYSTEM_NET_SOCKETS_SOCKETSHUTDOWN is
		external
			"IL enum signature :System.Net.Sockets.SocketShutdown use System.Net.Sockets.SocketShutdown"
		alias
			"0"
		end

end -- class SYSTEM_NET_SOCKETS_SOCKETSHUTDOWN
