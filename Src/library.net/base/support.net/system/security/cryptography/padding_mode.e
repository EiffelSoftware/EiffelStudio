indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Cryptography.PaddingMode"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	PADDING_MODE

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen zeros: PADDING_MODE is
		external
			"IL enum signature :System.Security.Cryptography.PaddingMode use System.Security.Cryptography.PaddingMode"
		alias
			"3"
		end

	frozen none: PADDING_MODE is
		external
			"IL enum signature :System.Security.Cryptography.PaddingMode use System.Security.Cryptography.PaddingMode"
		alias
			"1"
		end

	frozen pkcs7: PADDING_MODE is
		external
			"IL enum signature :System.Security.Cryptography.PaddingMode use System.Security.Cryptography.PaddingMode"
		alias
			"2"
		end

end -- class PADDING_MODE
