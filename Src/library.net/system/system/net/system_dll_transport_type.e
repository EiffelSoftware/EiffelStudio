indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Net.TransportType"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DLL_TRANSPORT_TYPE

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen all_: SYSTEM_DLL_TRANSPORT_TYPE is
		external
			"IL enum signature :System.Net.TransportType use System.Net.TransportType"
		alias
			"3"
		end

	frozen tcp: SYSTEM_DLL_TRANSPORT_TYPE is
		external
			"IL enum signature :System.Net.TransportType use System.Net.TransportType"
		alias
			"2"
		end

	frozen connection_oriented: SYSTEM_DLL_TRANSPORT_TYPE is
		external
			"IL enum signature :System.Net.TransportType use System.Net.TransportType"
		alias
			"2"
		end

	frozen udp: SYSTEM_DLL_TRANSPORT_TYPE is
		external
			"IL enum signature :System.Net.TransportType use System.Net.TransportType"
		alias
			"1"
		end

	frozen connectionless: SYSTEM_DLL_TRANSPORT_TYPE is
		external
			"IL enum signature :System.Net.TransportType use System.Net.TransportType"
		alias
			"1"
		end

end -- class SYSTEM_DLL_TRANSPORT_TYPE
