indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.PARAMFLAG"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER_16"

frozen expanded external class
	PARAMFLAG

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen paramflag_fin: PARAMFLAG is
		external
			"IL enum signature :System.Runtime.InteropServices.PARAMFLAG use System.Runtime.InteropServices.PARAMFLAG"
		alias
			"1"
		end

	frozen paramflag_flcid: PARAMFLAG is
		external
			"IL enum signature :System.Runtime.InteropServices.PARAMFLAG use System.Runtime.InteropServices.PARAMFLAG"
		alias
			"4"
		end

	frozen paramflag_none: PARAMFLAG is
		external
			"IL enum signature :System.Runtime.InteropServices.PARAMFLAG use System.Runtime.InteropServices.PARAMFLAG"
		alias
			"0"
		end

	frozen paramflag_fhasdefault: PARAMFLAG is
		external
			"IL enum signature :System.Runtime.InteropServices.PARAMFLAG use System.Runtime.InteropServices.PARAMFLAG"
		alias
			"32"
		end

	frozen paramflag_fout: PARAMFLAG is
		external
			"IL enum signature :System.Runtime.InteropServices.PARAMFLAG use System.Runtime.InteropServices.PARAMFLAG"
		alias
			"2"
		end

	frozen paramflag_fopt: PARAMFLAG is
		external
			"IL enum signature :System.Runtime.InteropServices.PARAMFLAG use System.Runtime.InteropServices.PARAMFLAG"
		alias
			"16"
		end

	frozen paramflag_fretval: PARAMFLAG is
		external
			"IL enum signature :System.Runtime.InteropServices.PARAMFLAG use System.Runtime.InteropServices.PARAMFLAG"
		alias
			"8"
		end

	frozen paramflag_fhascustdata: PARAMFLAG is
		external
			"IL enum signature :System.Runtime.InteropServices.PARAMFLAG use System.Runtime.InteropServices.PARAMFLAG"
		alias
			"64"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class PARAMFLAG
