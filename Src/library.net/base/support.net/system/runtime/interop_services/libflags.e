indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.LIBFLAGS"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER_16"

frozen expanded external class
	LIBFLAGS

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen libflag_frestricted: LIBFLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.LIBFLAGS use System.Runtime.InteropServices.LIBFLAGS"
		alias
			"1"
		end

	frozen libflag_fhidden: LIBFLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.LIBFLAGS use System.Runtime.InteropServices.LIBFLAGS"
		alias
			"4"
		end

	frozen libflag_fhasdiskimage: LIBFLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.LIBFLAGS use System.Runtime.InteropServices.LIBFLAGS"
		alias
			"8"
		end

	frozen libflag_fcontrol: LIBFLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.LIBFLAGS use System.Runtime.InteropServices.LIBFLAGS"
		alias
			"2"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class LIBFLAGS
