indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.INVOKEKIND"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	INVOKEKIND

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen invoke_func: INVOKEKIND is
		external
			"IL enum signature :System.Runtime.InteropServices.INVOKEKIND use System.Runtime.InteropServices.INVOKEKIND"
		alias
			"1"
		end

	frozen invoke_propertyput: INVOKEKIND is
		external
			"IL enum signature :System.Runtime.InteropServices.INVOKEKIND use System.Runtime.InteropServices.INVOKEKIND"
		alias
			"4"
		end

	frozen invoke_propertyget: INVOKEKIND is
		external
			"IL enum signature :System.Runtime.InteropServices.INVOKEKIND use System.Runtime.InteropServices.INVOKEKIND"
		alias
			"2"
		end

	frozen invoke_propertyputref: INVOKEKIND is
		external
			"IL enum signature :System.Runtime.InteropServices.INVOKEKIND use System.Runtime.InteropServices.INVOKEKIND"
		alias
			"8"
		end

end -- class INVOKEKIND
