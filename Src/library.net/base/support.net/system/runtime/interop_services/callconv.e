indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.CALLCONV"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	CALLCONV

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen cc_stdcall: CALLCONV is
		external
			"IL enum signature :System.Runtime.InteropServices.CALLCONV use System.Runtime.InteropServices.CALLCONV"
		alias
			"4"
		end

	frozen cc_mpwpascal: CALLCONV is
		external
			"IL enum signature :System.Runtime.InteropServices.CALLCONV use System.Runtime.InteropServices.CALLCONV"
		alias
			"8"
		end

	frozen cc_reserved: CALLCONV is
		external
			"IL enum signature :System.Runtime.InteropServices.CALLCONV use System.Runtime.InteropServices.CALLCONV"
		alias
			"5"
		end

	frozen cc_macpascal: CALLCONV is
		external
			"IL enum signature :System.Runtime.InteropServices.CALLCONV use System.Runtime.InteropServices.CALLCONV"
		alias
			"3"
		end

	frozen cc_max: CALLCONV is
		external
			"IL enum signature :System.Runtime.InteropServices.CALLCONV use System.Runtime.InteropServices.CALLCONV"
		alias
			"9"
		end

	frozen cc_pascal: CALLCONV is
		external
			"IL enum signature :System.Runtime.InteropServices.CALLCONV use System.Runtime.InteropServices.CALLCONV"
		alias
			"2"
		end

	frozen cc_syscall: CALLCONV is
		external
			"IL enum signature :System.Runtime.InteropServices.CALLCONV use System.Runtime.InteropServices.CALLCONV"
		alias
			"6"
		end

	frozen cc_cdecl: CALLCONV is
		external
			"IL enum signature :System.Runtime.InteropServices.CALLCONV use System.Runtime.InteropServices.CALLCONV"
		alias
			"1"
		end

	frozen cc_mscpascal: CALLCONV is
		external
			"IL enum signature :System.Runtime.InteropServices.CALLCONV use System.Runtime.InteropServices.CALLCONV"
		alias
			"2"
		end

	frozen cc_mpwcdecl: CALLCONV is
		external
			"IL enum signature :System.Runtime.InteropServices.CALLCONV use System.Runtime.InteropServices.CALLCONV"
		alias
			"7"
		end

end -- class CALLCONV
