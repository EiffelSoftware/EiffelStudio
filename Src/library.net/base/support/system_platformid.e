indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.PlatformID"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_PLATFORMID

inherit
	ENUM
	SYSTEM_ICOMPARABLE
	SYSTEM_IFORMATTABLE

feature -- Access

	frozen win32_s: SYSTEM_PLATFORMID is
		external
			"IL enum signature :System.PlatformID use System.PlatformID"
		alias
			"0"
		end

	frozen win32_nt: SYSTEM_PLATFORMID is
		external
			"IL enum signature :System.PlatformID use System.PlatformID"
		alias
			"2"
		end

	frozen win32_windows: SYSTEM_PLATFORMID is
		external
			"IL enum signature :System.PlatformID use System.PlatformID"
		alias
			"1"
		end

end -- class SYSTEM_PLATFORMID
