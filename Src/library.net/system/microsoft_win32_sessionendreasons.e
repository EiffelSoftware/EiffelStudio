indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "Microsoft.Win32.SessionEndReasons"
	enum_type: "INTEGER"

frozen expanded external class
	MICROSOFT_WIN32_SESSIONENDREASONS

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

	frozen logoff: MICROSOFT_WIN32_SESSIONENDREASONS is
		external
			"IL enum signature :Microsoft.Win32.SessionEndReasons use Microsoft.Win32.SessionEndReasons"
		alias
			"1"
		end

	frozen system_shutdown: MICROSOFT_WIN32_SESSIONENDREASONS is
		external
			"IL enum signature :Microsoft.Win32.SessionEndReasons use Microsoft.Win32.SessionEndReasons"
		alias
			"2"
		end

end -- class MICROSOFT_WIN32_SESSIONENDREASONS
