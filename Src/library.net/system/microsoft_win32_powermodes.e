indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "Microsoft.Win32.PowerModes"
	enum_type: "INTEGER"

frozen expanded external class
	MICROSOFT_WIN32_POWERMODES

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

	frozen resume: MICROSOFT_WIN32_POWERMODES is
		external
			"IL enum signature :Microsoft.Win32.PowerModes use Microsoft.Win32.PowerModes"
		alias
			"1"
		end

	frozen status_change: MICROSOFT_WIN32_POWERMODES is
		external
			"IL enum signature :Microsoft.Win32.PowerModes use Microsoft.Win32.PowerModes"
		alias
			"2"
		end

	frozen suspend: MICROSOFT_WIN32_POWERMODES is
		external
			"IL enum signature :Microsoft.Win32.PowerModes use Microsoft.Win32.PowerModes"
		alias
			"3"
		end

end -- class MICROSOFT_WIN32_POWERMODES
