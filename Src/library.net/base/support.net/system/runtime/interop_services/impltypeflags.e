indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.IMPLTYPEFLAGS"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	IMPLTYPEFLAGS

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen impltypeflag_frestricted: IMPLTYPEFLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.IMPLTYPEFLAGS use System.Runtime.InteropServices.IMPLTYPEFLAGS"
		alias
			"4"
		end

	frozen impltypeflag_fsource: IMPLTYPEFLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.IMPLTYPEFLAGS use System.Runtime.InteropServices.IMPLTYPEFLAGS"
		alias
			"2"
		end

	frozen impltypeflag_fdefault: IMPLTYPEFLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.IMPLTYPEFLAGS use System.Runtime.InteropServices.IMPLTYPEFLAGS"
		alias
			"1"
		end

	frozen impltypeflag_fdefaultvtable: IMPLTYPEFLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.IMPLTYPEFLAGS use System.Runtime.InteropServices.IMPLTYPEFLAGS"
		alias
			"8"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class IMPLTYPEFLAGS
