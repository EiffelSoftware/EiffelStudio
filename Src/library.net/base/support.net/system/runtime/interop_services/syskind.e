indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.SYSKIND"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	SYSKIND

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen sys_win16: SYSKIND is
		external
			"IL enum signature :System.Runtime.InteropServices.SYSKIND use System.Runtime.InteropServices.SYSKIND"
		alias
			"0"
		end

	frozen sys_win32: SYSKIND is
		external
			"IL enum signature :System.Runtime.InteropServices.SYSKIND use System.Runtime.InteropServices.SYSKIND"
		alias
			"1"
		end

	frozen sys_mac: SYSKIND is
		external
			"IL enum signature :System.Runtime.InteropServices.SYSKIND use System.Runtime.InteropServices.SYSKIND"
		alias
			"2"
		end

end -- class SYSKIND
