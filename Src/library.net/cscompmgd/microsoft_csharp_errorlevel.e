indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "Microsoft.CSharp.ErrorLevel"
	enum_type: "INTEGER"

frozen expanded external class
	MICROSOFT_CSHARP_ERRORLEVEL

inherit
	ENUM
		rename
			is_equal as equals_object
		end
	SYSTEM_IFORMATTABLE
		rename
			is_equal as equals_object
		end
	SYSTEM_ICOMPARABLE
		rename
			is_equal as equals_object
		end

feature -- Access

	frozen warning: MICROSOFT_CSHARP_ERRORLEVEL is
		external
			"IL enum signature :Microsoft.CSharp.ErrorLevel use Microsoft.CSharp.ErrorLevel"
		alias
			"1"
		end

	frozen error: MICROSOFT_CSHARP_ERRORLEVEL is
		external
			"IL enum signature :Microsoft.CSharp.ErrorLevel use Microsoft.CSharp.ErrorLevel"
		alias
			"2"
		end

	frozen none: MICROSOFT_CSHARP_ERRORLEVEL is
		external
			"IL enum signature :Microsoft.CSharp.ErrorLevel use Microsoft.CSharp.ErrorLevel"
		alias
			"0"
		end

	frozen fatal_error: MICROSOFT_CSHARP_ERRORLEVEL is
		external
			"IL enum signature :Microsoft.CSharp.ErrorLevel use Microsoft.CSharp.ErrorLevel"
		alias
			"3"
		end

end -- class MICROSOFT_CSHARP_ERRORLEVEL
