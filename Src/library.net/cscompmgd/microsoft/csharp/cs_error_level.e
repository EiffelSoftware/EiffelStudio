indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "Microsoft.CSharp.ErrorLevel"
	assembly: "cscompmgd", "7.0.3300.0", "neutral", "b03f5f7f11d5a3a"
	enum_type: "INTEGER"

frozen expanded external class
	CS_ERROR_LEVEL

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen warning: CS_ERROR_LEVEL is
		external
			"IL enum signature :Microsoft.CSharp.ErrorLevel use Microsoft.CSharp.ErrorLevel"
		alias
			"1"
		end

	frozen error: CS_ERROR_LEVEL is
		external
			"IL enum signature :Microsoft.CSharp.ErrorLevel use Microsoft.CSharp.ErrorLevel"
		alias
			"2"
		end

	frozen none: CS_ERROR_LEVEL is
		external
			"IL enum signature :Microsoft.CSharp.ErrorLevel use Microsoft.CSharp.ErrorLevel"
		alias
			"0"
		end

	frozen fatal_error: CS_ERROR_LEVEL is
		external
			"IL enum signature :Microsoft.CSharp.ErrorLevel use Microsoft.CSharp.ErrorLevel"
		alias
			"3"
		end

end -- class CS_ERROR_LEVEL
