indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.DESCKIND"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	DESCKIND

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen desckind_funcdesc: DESCKIND is
		external
			"IL enum signature :System.Runtime.InteropServices.DESCKIND use System.Runtime.InteropServices.DESCKIND"
		alias
			"1"
		end

	frozen desckind_vardesc: DESCKIND is
		external
			"IL enum signature :System.Runtime.InteropServices.DESCKIND use System.Runtime.InteropServices.DESCKIND"
		alias
			"2"
		end

	frozen desckind_none: DESCKIND is
		external
			"IL enum signature :System.Runtime.InteropServices.DESCKIND use System.Runtime.InteropServices.DESCKIND"
		alias
			"0"
		end

	frozen desckind_implicitappobj: DESCKIND is
		external
			"IL enum signature :System.Runtime.InteropServices.DESCKIND use System.Runtime.InteropServices.DESCKIND"
		alias
			"4"
		end

	frozen desckind_typecomp: DESCKIND is
		external
			"IL enum signature :System.Runtime.InteropServices.DESCKIND use System.Runtime.InteropServices.DESCKIND"
		alias
			"3"
		end

	frozen desckind_max: DESCKIND is
		external
			"IL enum signature :System.Runtime.InteropServices.DESCKIND use System.Runtime.InteropServices.DESCKIND"
		alias
			"5"
		end

end -- class DESCKIND
