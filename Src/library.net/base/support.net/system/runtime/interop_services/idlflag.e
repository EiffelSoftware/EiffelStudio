indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.IDLFLAG"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER_16"

frozen expanded external class
	IDLFLAG

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen idlflag_flcid: IDLFLAG is
		external
			"IL enum signature :System.Runtime.InteropServices.IDLFLAG use System.Runtime.InteropServices.IDLFLAG"
		alias
			"4"
		end

	frozen idlflag_fout: IDLFLAG is
		external
			"IL enum signature :System.Runtime.InteropServices.IDLFLAG use System.Runtime.InteropServices.IDLFLAG"
		alias
			"2"
		end

	frozen idlflag_fin: IDLFLAG is
		external
			"IL enum signature :System.Runtime.InteropServices.IDLFLAG use System.Runtime.InteropServices.IDLFLAG"
		alias
			"1"
		end

	frozen idlflag_none: IDLFLAG is
		external
			"IL enum signature :System.Runtime.InteropServices.IDLFLAG use System.Runtime.InteropServices.IDLFLAG"
		alias
			"0"
		end

	frozen idlflag_fretval: IDLFLAG is
		external
			"IL enum signature :System.Runtime.InteropServices.IDLFLAG use System.Runtime.InteropServices.IDLFLAG"
		alias
			"8"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class IDLFLAG
