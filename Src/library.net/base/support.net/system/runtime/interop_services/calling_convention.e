indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.CallingConvention"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	CALLING_CONVENTION

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen fast_call: CALLING_CONVENTION is
		external
			"IL enum signature :System.Runtime.InteropServices.CallingConvention use System.Runtime.InteropServices.CallingConvention"
		alias
			"5"
		end

	frozen cdecl: CALLING_CONVENTION is
		external
			"IL enum signature :System.Runtime.InteropServices.CallingConvention use System.Runtime.InteropServices.CallingConvention"
		alias
			"2"
		end

	frozen winapi: CALLING_CONVENTION is
		external
			"IL enum signature :System.Runtime.InteropServices.CallingConvention use System.Runtime.InteropServices.CallingConvention"
		alias
			"1"
		end

	frozen std_call: CALLING_CONVENTION is
		external
			"IL enum signature :System.Runtime.InteropServices.CallingConvention use System.Runtime.InteropServices.CallingConvention"
		alias
			"3"
		end

	frozen this_call: CALLING_CONVENTION is
		external
			"IL enum signature :System.Runtime.InteropServices.CallingConvention use System.Runtime.InteropServices.CallingConvention"
		alias
			"4"
		end

end -- class CALLING_CONVENTION
