indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.CharSet"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	CHAR_SET

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen ansi: CHAR_SET is
		external
			"IL enum signature :System.Runtime.InteropServices.CharSet use System.Runtime.InteropServices.CharSet"
		alias
			"2"
		end

	frozen unicode: CHAR_SET is
		external
			"IL enum signature :System.Runtime.InteropServices.CharSet use System.Runtime.InteropServices.CharSet"
		alias
			"3"
		end

	frozen auto: CHAR_SET is
		external
			"IL enum signature :System.Runtime.InteropServices.CharSet use System.Runtime.InteropServices.CharSet"
		alias
			"4"
		end

	frozen none: CHAR_SET is
		external
			"IL enum signature :System.Runtime.InteropServices.CharSet use System.Runtime.InteropServices.CharSet"
		alias
			"1"
		end

end -- class CHAR_SET
