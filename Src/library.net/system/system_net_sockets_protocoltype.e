indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Net.Sockets.ProtocolType"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_NET_SOCKETS_PROTOCOLTYPE

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

	frozen unknown: SYSTEM_NET_SOCKETS_PROTOCOLTYPE is
		external
			"IL enum signature :System.Net.Sockets.ProtocolType use System.Net.Sockets.ProtocolType"
		alias
			"-1"
		end

	frozen ip: SYSTEM_NET_SOCKETS_PROTOCOLTYPE is
		external
			"IL enum signature :System.Net.Sockets.ProtocolType use System.Net.Sockets.ProtocolType"
		alias
			"0"
		end

	frozen ipx: SYSTEM_NET_SOCKETS_PROTOCOLTYPE is
		external
			"IL enum signature :System.Net.Sockets.ProtocolType use System.Net.Sockets.ProtocolType"
		alias
			"1000"
		end

	frozen spx: SYSTEM_NET_SOCKETS_PROTOCOLTYPE is
		external
			"IL enum signature :System.Net.Sockets.ProtocolType use System.Net.Sockets.ProtocolType"
		alias
			"1256"
		end

	frozen nd: SYSTEM_NET_SOCKETS_PROTOCOLTYPE is
		external
			"IL enum signature :System.Net.Sockets.ProtocolType use System.Net.Sockets.ProtocolType"
		alias
			"77"
		end

	frozen raw: SYSTEM_NET_SOCKETS_PROTOCOLTYPE is
		external
			"IL enum signature :System.Net.Sockets.ProtocolType use System.Net.Sockets.ProtocolType"
		alias
			"255"
		end

	frozen igmp: SYSTEM_NET_SOCKETS_PROTOCOLTYPE is
		external
			"IL enum signature :System.Net.Sockets.ProtocolType use System.Net.Sockets.ProtocolType"
		alias
			"2"
		end

	frozen unspecified: SYSTEM_NET_SOCKETS_PROTOCOLTYPE is
		external
			"IL enum signature :System.Net.Sockets.ProtocolType use System.Net.Sockets.ProtocolType"
		alias
			"0"
		end

	frozen idp: SYSTEM_NET_SOCKETS_PROTOCOLTYPE is
		external
			"IL enum signature :System.Net.Sockets.ProtocolType use System.Net.Sockets.ProtocolType"
		alias
			"22"
		end

	frozen icmp: SYSTEM_NET_SOCKETS_PROTOCOLTYPE is
		external
			"IL enum signature :System.Net.Sockets.ProtocolType use System.Net.Sockets.ProtocolType"
		alias
			"1"
		end

	frozen ggp: SYSTEM_NET_SOCKETS_PROTOCOLTYPE is
		external
			"IL enum signature :System.Net.Sockets.ProtocolType use System.Net.Sockets.ProtocolType"
		alias
			"3"
		end

	frozen spx_ii: SYSTEM_NET_SOCKETS_PROTOCOLTYPE is
		external
			"IL enum signature :System.Net.Sockets.ProtocolType use System.Net.Sockets.ProtocolType"
		alias
			"1257"
		end

	frozen pup: SYSTEM_NET_SOCKETS_PROTOCOLTYPE is
		external
			"IL enum signature :System.Net.Sockets.ProtocolType use System.Net.Sockets.ProtocolType"
		alias
			"12"
		end

	frozen tcp: SYSTEM_NET_SOCKETS_PROTOCOLTYPE is
		external
			"IL enum signature :System.Net.Sockets.ProtocolType use System.Net.Sockets.ProtocolType"
		alias
			"6"
		end

	frozen udp: SYSTEM_NET_SOCKETS_PROTOCOLTYPE is
		external
			"IL enum signature :System.Net.Sockets.ProtocolType use System.Net.Sockets.ProtocolType"
		alias
			"17"
		end

end -- class SYSTEM_NET_SOCKETS_PROTOCOLTYPE
