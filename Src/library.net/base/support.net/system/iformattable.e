indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.IFormattable"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	IFORMATTABLE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	to_string_string (format: SYSTEM_STRING; format_provider: IFORMAT_PROVIDER): SYSTEM_STRING is
		external
			"IL deferred signature (System.String, System.IFormatProvider): System.String use System.IFormattable"
		alias
			"ToString"
		end

end -- class IFORMATTABLE
