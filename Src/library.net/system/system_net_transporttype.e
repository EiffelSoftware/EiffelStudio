indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Net.TransportType"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_NET_TRANSPORTTYPE

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

	frozen All_: SYSTEM_NET_TRANSPORTTYPE is
		external
			"IL enum signature :System.Net.TransportType use System.Net.TransportType"
		alias
			"3"
		end

	frozen tcp: SYSTEM_NET_TRANSPORTTYPE is
		external
			"IL enum signature :System.Net.TransportType use System.Net.TransportType"
		alias
			"2"
		end

	frozen connection_oriented: SYSTEM_NET_TRANSPORTTYPE is
		external
			"IL enum signature :System.Net.TransportType use System.Net.TransportType"
		alias
			"2"
		end

	frozen udp: SYSTEM_NET_TRANSPORTTYPE is
		external
			"IL enum signature :System.Net.TransportType use System.Net.TransportType"
		alias
			"1"
		end

	frozen connectionless: SYSTEM_NET_TRANSPORTTYPE is
		external
			"IL enum signature :System.Net.TransportType use System.Net.TransportType"
		alias
			"1"
		end

end -- class SYSTEM_NET_TRANSPORTTYPE
