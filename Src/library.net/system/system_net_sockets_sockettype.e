indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Net.Sockets.SocketType"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_NET_SOCKETS_SOCKETTYPE

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

	frozen rdm: SYSTEM_NET_SOCKETS_SOCKETTYPE is
		external
			"IL enum signature :System.Net.Sockets.SocketType use System.Net.Sockets.SocketType"
		alias
			"4"
		end

	frozen raw: SYSTEM_NET_SOCKETS_SOCKETTYPE is
		external
			"IL enum signature :System.Net.Sockets.SocketType use System.Net.Sockets.SocketType"
		alias
			"3"
		end

	frozen dgram: SYSTEM_NET_SOCKETS_SOCKETTYPE is
		external
			"IL enum signature :System.Net.Sockets.SocketType use System.Net.Sockets.SocketType"
		alias
			"2"
		end

	frozen stream: SYSTEM_NET_SOCKETS_SOCKETTYPE is
		external
			"IL enum signature :System.Net.Sockets.SocketType use System.Net.Sockets.SocketType"
		alias
			"1"
		end

	frozen seqpacket: SYSTEM_NET_SOCKETS_SOCKETTYPE is
		external
			"IL enum signature :System.Net.Sockets.SocketType use System.Net.Sockets.SocketType"
		alias
			"5"
		end

	frozen unknown: SYSTEM_NET_SOCKETS_SOCKETTYPE is
		external
			"IL enum signature :System.Net.Sockets.SocketType use System.Net.Sockets.SocketType"
		alias
			"-1"
		end

end -- class SYSTEM_NET_SOCKETS_SOCKETTYPE
