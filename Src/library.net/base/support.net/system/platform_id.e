indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.PlatformID"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	PLATFORM_ID

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen win32_s: PLATFORM_ID is
		external
			"IL enum signature :System.PlatformID use System.PlatformID"
		alias
			"0"
		end

	frozen win32_nt: PLATFORM_ID is
		external
			"IL enum signature :System.PlatformID use System.PlatformID"
		alias
			"2"
		end

	frozen win32_windows: PLATFORM_ID is
		external
			"IL enum signature :System.PlatformID use System.PlatformID"
		alias
			"1"
		end

end -- class PLATFORM_ID
