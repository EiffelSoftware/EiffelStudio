indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.InteropServices.TYPELIBATTR"

frozen expanded external class
	SYSTEM_RUNTIME_INTEROPSERVICES_TYPELIBATTR

inherit
	VALUE_TYPE

feature -- Access

	frozen lcid: INTEGER is
		external
			"IL field signature :System.Int32 use System.Runtime.InteropServices.TYPELIBATTR"
		alias
			"lcid"
		end

	frozen syskind: SYSTEM_RUNTIME_INTEROPSERVICES_SYSKIND is
		external
			"IL field signature :System.Runtime.InteropServices.SYSKIND use System.Runtime.InteropServices.TYPELIBATTR"
		alias
			"syskind"
		end

	frozen guid: SYSTEM_GUID is
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

	frozen w_lib_flags: SYSTEM_RUNTIME_INTEROPSERVICES_LIBFLAGS is
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

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_TYPELIBATTR
