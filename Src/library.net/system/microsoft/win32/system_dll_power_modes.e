indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "Microsoft.Win32.PowerModes"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DLL_POWER_MODES

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen resume: SYSTEM_DLL_POWER_MODES is
		external
			"IL enum signature :Microsoft.Win32.PowerModes use Microsoft.Win32.PowerModes"
		alias
			"1"
		end

	frozen status_change: SYSTEM_DLL_POWER_MODES is
		external
			"IL enum signature :Microsoft.Win32.PowerModes use Microsoft.Win32.PowerModes"
		alias
			"2"
		end

	frozen suspend: SYSTEM_DLL_POWER_MODES is
		external
			"IL enum signature :Microsoft.Win32.PowerModes use Microsoft.Win32.PowerModes"
		alias
			"3"
		end

end -- class SYSTEM_DLL_POWER_MODES
