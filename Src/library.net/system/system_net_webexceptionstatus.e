indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Net.WebExceptionStatus"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_NET_WEBEXCEPTIONSTATUS

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

	frozen pending: SYSTEM_NET_WEBEXCEPTIONSTATUS is
		external
			"IL enum signature :System.Net.WebExceptionStatus use System.Net.WebExceptionStatus"
		alias
			"13"
		end

	frozen keep_alive_failure: SYSTEM_NET_WEBEXCEPTIONSTATUS is
		external
			"IL enum signature :System.Net.WebExceptionStatus use System.Net.WebExceptionStatus"
		alias
			"12"
		end

	frozen receive_failure: SYSTEM_NET_WEBEXCEPTIONSTATUS is
		external
			"IL enum signature :System.Net.WebExceptionStatus use System.Net.WebExceptionStatus"
		alias
			"3"
		end

	frozen success: SYSTEM_NET_WEBEXCEPTIONSTATUS is
		external
			"IL enum signature :System.Net.WebExceptionStatus use System.Net.WebExceptionStatus"
		alias
			"0"
		end

	frozen request_canceled: SYSTEM_NET_WEBEXCEPTIONSTATUS is
		external
			"IL enum signature :System.Net.WebExceptionStatus use System.Net.WebExceptionStatus"
		alias
			"6"
		end

	frozen proxy_name_resolution_failure: SYSTEM_NET_WEBEXCEPTIONSTATUS is
		external
			"IL enum signature :System.Net.WebExceptionStatus use System.Net.WebExceptionStatus"
		alias
			"15"
		end

	frozen timeout: SYSTEM_NET_WEBEXCEPTIONSTATUS is
		external
			"IL enum signature :System.Net.WebExceptionStatus use System.Net.WebExceptionStatus"
		alias
			"14"
		end

	frozen name_resolution_failure: SYSTEM_NET_WEBEXCEPTIONSTATUS is
		external
			"IL enum signature :System.Net.WebExceptionStatus use System.Net.WebExceptionStatus"
		alias
			"1"
		end

	frozen pipeline_failure: SYSTEM_NET_WEBEXCEPTIONSTATUS is
		external
			"IL enum signature :System.Net.WebExceptionStatus use System.Net.WebExceptionStatus"
		alias
			"5"
		end

	frozen trust_failure: SYSTEM_NET_WEBEXCEPTIONSTATUS is
		external
			"IL enum signature :System.Net.WebExceptionStatus use System.Net.WebExceptionStatus"
		alias
			"9"
		end

	frozen send_failure: SYSTEM_NET_WEBEXCEPTIONSTATUS is
		external
			"IL enum signature :System.Net.WebExceptionStatus use System.Net.WebExceptionStatus"
		alias
			"4"
		end

	frozen secure_channel_failure: SYSTEM_NET_WEBEXCEPTIONSTATUS is
		external
			"IL enum signature :System.Net.WebExceptionStatus use System.Net.WebExceptionStatus"
		alias
			"10"
		end

	frozen connect_failure: SYSTEM_NET_WEBEXCEPTIONSTATUS is
		external
			"IL enum signature :System.Net.WebExceptionStatus use System.Net.WebExceptionStatus"
		alias
			"2"
		end

	frozen protocol_error: SYSTEM_NET_WEBEXCEPTIONSTATUS is
		external
			"IL enum signature :System.Net.WebExceptionStatus use System.Net.WebExceptionStatus"
		alias
			"7"
		end

	frozen connection_closed: SYSTEM_NET_WEBEXCEPTIONSTATUS is
		external
			"IL enum signature :System.Net.WebExceptionStatus use System.Net.WebExceptionStatus"
		alias
			"8"
		end

	frozen server_protocol_violation: SYSTEM_NET_WEBEXCEPTIONSTATUS is
		external
			"IL enum signature :System.Net.WebExceptionStatus use System.Net.WebExceptionStatus"
		alias
			"11"
		end

end -- class SYSTEM_NET_WEBEXCEPTIONSTATUS
