indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.TYPEFLAGS"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER_16"

frozen expanded external class
	TYPEFLAGS

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen typeflag_fpredeclid: TYPEFLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.TYPEFLAGS use System.Runtime.InteropServices.TYPEFLAGS"
		alias
			"8"
		end

	frozen typeflag_fcontrol: TYPEFLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.TYPEFLAGS use System.Runtime.InteropServices.TYPEFLAGS"
		alias
			"32"
		end

	frozen typeflag_fcancreate: TYPEFLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.TYPEFLAGS use System.Runtime.InteropServices.TYPEFLAGS"
		alias
			"2"
		end

	frozen typeflag_foleautomation: TYPEFLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.TYPEFLAGS use System.Runtime.InteropServices.TYPEFLAGS"
		alias
			"256"
		end

	frozen typeflag_fappobject: TYPEFLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.TYPEFLAGS use System.Runtime.InteropServices.TYPEFLAGS"
		alias
			"1"
		end

	frozen typeflag_freplaceable: TYPEFLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.TYPEFLAGS use System.Runtime.InteropServices.TYPEFLAGS"
		alias
			"2048"
		end

	frozen typeflag_faggregatable: TYPEFLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.TYPEFLAGS use System.Runtime.InteropServices.TYPEFLAGS"
		alias
			"1024"
		end

	frozen typeflag_freversebind: TYPEFLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.TYPEFLAGS use System.Runtime.InteropServices.TYPEFLAGS"
		alias
			"8192"
		end

	frozen typeflag_flicensed: TYPEFLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.TYPEFLAGS use System.Runtime.InteropServices.TYPEFLAGS"
		alias
			"4"
		end

	frozen typeflag_frestricted: TYPEFLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.TYPEFLAGS use System.Runtime.InteropServices.TYPEFLAGS"
		alias
			"512"
		end

	frozen typeflag_fdual: TYPEFLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.TYPEFLAGS use System.Runtime.InteropServices.TYPEFLAGS"
		alias
			"64"
		end

	frozen typeflag_fhidden: TYPEFLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.TYPEFLAGS use System.Runtime.InteropServices.TYPEFLAGS"
		alias
			"16"
		end

	frozen typeflag_fnonextensible: TYPEFLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.TYPEFLAGS use System.Runtime.InteropServices.TYPEFLAGS"
		alias
			"128"
		end

	frozen typeflag_fdispatchable: TYPEFLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.TYPEFLAGS use System.Runtime.InteropServices.TYPEFLAGS"
		alias
			"4096"
		end

	frozen typeflag_fproxy: TYPEFLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.TYPEFLAGS use System.Runtime.InteropServices.TYPEFLAGS"
		alias
			"16384"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class TYPEFLAGS
