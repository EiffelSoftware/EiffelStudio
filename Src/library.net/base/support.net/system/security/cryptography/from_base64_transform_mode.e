indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Cryptography.FromBase64TransformMode"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	FROM_BASE64_TRANSFORM_MODE

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen ignore_white_spaces: FROM_BASE64_TRANSFORM_MODE is
		external
			"IL enum signature :System.Security.Cryptography.FromBase64TransformMode use System.Security.Cryptography.FromBase64TransformMode"
		alias
			"0"
		end

	frozen do_not_ignore_white_spaces: FROM_BASE64_TRANSFORM_MODE is
		external
			"IL enum signature :System.Security.Cryptography.FromBase64TransformMode use System.Security.Cryptography.FromBase64TransformMode"
		alias
			"1"
		end

end -- class FROM_BASE64_TRANSFORM_MODE
