indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.TYPEKIND"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	TYPEKIND

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen tkind_dispatch: TYPEKIND is
		external
			"IL enum signature :System.Runtime.InteropServices.TYPEKIND use System.Runtime.InteropServices.TYPEKIND"
		alias
			"4"
		end

	frozen tkind_alias: TYPEKIND is
		external
			"IL enum signature :System.Runtime.InteropServices.TYPEKIND use System.Runtime.InteropServices.TYPEKIND"
		alias
			"6"
		end

	frozen tkind_enum: TYPEKIND is
		external
			"IL enum signature :System.Runtime.InteropServices.TYPEKIND use System.Runtime.InteropServices.TYPEKIND"
		alias
			"0"
		end

	frozen tkind_record: TYPEKIND is
		external
			"IL enum signature :System.Runtime.InteropServices.TYPEKIND use System.Runtime.InteropServices.TYPEKIND"
		alias
			"1"
		end

	frozen tkind_max: TYPEKIND is
		external
			"IL enum signature :System.Runtime.InteropServices.TYPEKIND use System.Runtime.InteropServices.TYPEKIND"
		alias
			"8"
		end

	frozen tkind_union: TYPEKIND is
		external
			"IL enum signature :System.Runtime.InteropServices.TYPEKIND use System.Runtime.InteropServices.TYPEKIND"
		alias
			"7"
		end

	frozen tkind_interface: TYPEKIND is
		external
			"IL enum signature :System.Runtime.InteropServices.TYPEKIND use System.Runtime.InteropServices.TYPEKIND"
		alias
			"3"
		end

	frozen tkind_module: TYPEKIND is
		external
			"IL enum signature :System.Runtime.InteropServices.TYPEKIND use System.Runtime.InteropServices.TYPEKIND"
		alias
			"2"
		end

	frozen tkind_coclass: TYPEKIND is
		external
			"IL enum signature :System.Runtime.InteropServices.TYPEKIND use System.Runtime.InteropServices.TYPEKIND"
		alias
			"5"
		end

end -- class TYPEKIND
