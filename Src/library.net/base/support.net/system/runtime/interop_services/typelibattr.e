indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.TYPELIBATTR"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	TYPELIBATTR

inherit
	VALUE_TYPE

feature -- Access

	frozen lcid: INTEGER is
		external
			"IL field signature :System.Int32 use System.Runtime.InteropServices.TYPELIBATTR"
		alias
			"lcid"
		end

	frozen syskind: SYSKIND is
		external
			"IL field signature :System.Runtime.InteropServices.SYSKIND use System.Runtime.InteropServices.TYPELIBATTR"
		alias
			"syskind"
		end

	frozen guid: GUID is
		external
			"IL field signature :System.Guid use System.Runtime.InteropServices.TYPELIBATTR"
		alias
			"guid"
		end

	frozen w_major_ver_num: INTEGER_16 is
		external
			"IL field signature :System.Int16 use System.Runtime.InteropServices.TYPELIBATTR"
		alias
			"wMajorVerNum"
		end

	frozen w_lib_flags: LIBFLAGS is
		external
			"IL field signature :System.Runtime.InteropServices.LIBFLAGS use System.Runtime.InteropServices.TYPELIBATTR"
		alias
			"wLibFlags"
		end

	frozen w_minor_ver_num: INTEGER_16 is
		external
			"IL field signature :System.Int16 use System.Runtime.InteropServices.TYPELIBATTR"
		alias
			"wMinorVerNum"
		end

end -- class TYPELIBATTR
