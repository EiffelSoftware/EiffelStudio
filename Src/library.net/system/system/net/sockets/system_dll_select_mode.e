indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Net.Sockets.SelectMode"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DLL_SELECT_MODE

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen select_write: SYSTEM_DLL_SELECT_MODE is
		external
			"IL enum signature :System.Net.Sockets.SelectMode use System.Net.Sockets.SelectMode"
		alias
			"1"
		end

	frozen select_error: SYSTEM_DLL_SELECT_MODE is
		external
			"IL enum signature :System.Net.Sockets.SelectMode use System.Net.Sockets.SelectMode"
		alias
			"2"
		end

	frozen select_read: SYSTEM_DLL_SELECT_MODE is
		external
			"IL enum signature :System.Net.Sockets.SelectMode use System.Net.Sockets.SelectMode"
		alias
			"0"
		end

end -- class SYSTEM_DLL_SELECT_MODE
