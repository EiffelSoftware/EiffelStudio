indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Net.Sockets.SocketFlags"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_NET_SOCKETS_SOCKETFLAGS

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

	frozen dont_route: SYSTEM_NET_SOCKETS_SOCKETFLAGS is
		external
			"IL enum signature :System.Net.Sockets.SocketFlags use System.Net.Sockets.SocketFlags"
		alias
			"4"
		end

	frozen partial: SYSTEM_NET_SOCKETS_SOCKETFLAGS is
		external
			"IL enum signature :System.Net.Sockets.SocketFlags use System.Net.Sockets.SocketFlags"
		alias
			"32768"
		end

	frozen none: SYSTEM_NET_SOCKETS_SOCKETFLAGS is
		external
			"IL enum signature :System.Net.Sockets.SocketFlags use System.Net.Sockets.SocketFlags"
		alias
			"0"
		end

	frozen peek: SYSTEM_NET_SOCKETS_SOCKETFLAGS is
		external
			"IL enum signature :System.Net.Sockets.SocketFlags use System.Net.Sockets.SocketFlags"
		alias
			"2"
		end

	frozen out_of_band: SYSTEM_NET_SOCKETS_SOCKETFLAGS is
		external
			"IL enum signature :System.Net.Sockets.SocketFlags use System.Net.Sockets.SocketFlags"
		alias
			"1"
		end

	frozen max_iovector_length: SYSTEM_NET_SOCKETS_SOCKETFLAGS is
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

end -- class SYSTEM_NET_SOCKETS_SOCKETFLAGS
