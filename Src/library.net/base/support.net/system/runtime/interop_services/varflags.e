indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.VARFLAGS"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER_16"

frozen expanded external class
	VARFLAGS

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen varflag_fhidden: VARFLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.VARFLAGS use System.Runtime.InteropServices.VARFLAGS"
		alias
			"64"
		end

	frozen varflag_fdisplaybind: VARFLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.VARFLAGS use System.Runtime.InteropServices.VARFLAGS"
		alias
			"16"
		end

	frozen varflag_frequestedit: VARFLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.VARFLAGS use System.Runtime.InteropServices.VARFLAGS"
		alias
			"8"
		end

	frozen varflag_freadonly: VARFLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.VARFLAGS use System.Runtime.InteropServices.VARFLAGS"
		alias
			"1"
		end

	frozen varflag_fnonbrowsable: VARFLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.VARFLAGS use System.Runtime.InteropServices.VARFLAGS"
		alias
			"1024"
		end

	frozen varflag_frestricted: VARFLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.VARFLAGS use System.Runtime.InteropServices.VARFLAGS"
		alias
			"128"
		end

	frozen varflag_fdefaultcollelem: VARFLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.VARFLAGS use System.Runtime.InteropServices.VARFLAGS"
		alias
			"256"
		end

	frozen varflag_fbindable: VARFLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.VARFLAGS use System.Runtime.InteropServices.VARFLAGS"
		alias
			"4"
		end

	frozen varflag_fuidefault: VARFLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.VARFLAGS use System.Runtime.InteropServices.VARFLAGS"
		alias
			"512"
		end

	frozen varflag_fdefaultbind: VARFLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.VARFLAGS use System.Runtime.InteropServices.VARFLAGS"
		alias
			"32"
		end

	frozen varflag_fsource: VARFLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.VARFLAGS use System.Runtime.InteropServices.VARFLAGS"
		alias
			"2"
		end

	frozen varflag_fimmediatebind: VARFLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.VARFLAGS use System.Runtime.InteropServices.VARFLAGS"
		alias
			"4096"
		end

	frozen varflag_freplaceable: VARFLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.VARFLAGS use System.Runtime.InteropServices.VARFLAGS"
		alias
			"2048"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class VARFLAGS
