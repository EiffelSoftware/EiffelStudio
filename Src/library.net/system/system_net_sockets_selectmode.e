indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Net.Sockets.SelectMode"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_NET_SOCKETS_SELECTMODE

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

	frozen select_write: SYSTEM_NET_SOCKETS_SELECTMODE is
		external
			"IL enum signature :System.Net.Sockets.SelectMode use System.Net.Sockets.SelectMode"
		alias
			"1"
		end

	frozen select_error: SYSTEM_NET_SOCKETS_SELECTMODE is
		external
			"IL enum signature :System.Net.Sockets.SelectMode use System.Net.Sockets.SelectMode"
		alias
			"2"
		end

	frozen select_read: SYSTEM_NET_SOCKETS_SELECTMODE is
		external
			"IL enum signature :System.Net.Sockets.SelectMode use System.Net.Sockets.SelectMode"
		alias
			"0"
		end

end -- class SYSTEM_NET_SOCKETS_SELECTMODE
