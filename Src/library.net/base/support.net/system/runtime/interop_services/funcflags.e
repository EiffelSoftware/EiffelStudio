indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.FUNCFLAGS"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER_16"

frozen expanded external class
	FUNCFLAGS

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen funcflag_fsource: FUNCFLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.FUNCFLAGS use System.Runtime.InteropServices.FUNCFLAGS"
		alias
			"2"
		end

	frozen funcflag_fuidefault: FUNCFLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.FUNCFLAGS use System.Runtime.InteropServices.FUNCFLAGS"
		alias
			"512"
		end

	frozen funcflag_fhidden: FUNCFLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.FUNCFLAGS use System.Runtime.InteropServices.FUNCFLAGS"
		alias
			"64"
		end

	frozen funcflag_frestricted: FUNCFLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.FUNCFLAGS use System.Runtime.InteropServices.FUNCFLAGS"
		alias
			"1"
		end

	frozen funcflag_fdefaultbind: FUNCFLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.FUNCFLAGS use System.Runtime.InteropServices.FUNCFLAGS"
		alias
			"32"
		end

	frozen funcflag_freplaceable: FUNCFLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.FUNCFLAGS use System.Runtime.InteropServices.FUNCFLAGS"
		alias
			"2048"
		end

	frozen funcflag_fdisplaybind: FUNCFLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.FUNCFLAGS use System.Runtime.InteropServices.FUNCFLAGS"
		alias
			"16"
		end

	frozen funcflag_fdefaultcollelem: FUNCFLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.FUNCFLAGS use System.Runtime.InteropServices.FUNCFLAGS"
		alias
			"256"
		end

	frozen funcflag_frequestedit: FUNCFLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.FUNCFLAGS use System.Runtime.InteropServices.FUNCFLAGS"
		alias
			"8"
		end

	frozen funcflag_fusesgetlasterror: FUNCFLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.FUNCFLAGS use System.Runtime.InteropServices.FUNCFLAGS"
		alias
			"128"
		end

	frozen funcflag_fimmediatebind: FUNCFLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.FUNCFLAGS use System.Runtime.InteropServices.FUNCFLAGS"
		alias
			"4096"
		end

	frozen funcflag_fbindable: FUNCFLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.FUNCFLAGS use System.Runtime.InteropServices.FUNCFLAGS"
		alias
			"4"
		end

	frozen funcflag_fnonbrowsable: FUNCFLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.FUNCFLAGS use System.Runtime.InteropServices.FUNCFLAGS"
		alias
			"1024"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class FUNCFLAGS
