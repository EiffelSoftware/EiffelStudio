indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ICustomFormatter"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ICUSTOM_FORMATTER

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	format (format2: SYSTEM_STRING; arg: SYSTEM_OBJECT; format_provider: IFORMAT_PROVIDER): SYSTEM_STRING is
		external
			"IL deferred signature (System.String, System.Object, System.IFormatProvider): System.String use System.ICustomFormatter"
		alias
			"Format"
		end

end -- class ICUSTOM_FORMATTER
