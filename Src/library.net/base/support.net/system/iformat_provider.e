indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.IFormatProvider"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	IFORMAT_PROVIDER

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	get_format (format_type: TYPE): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.Type): System.Object use System.IFormatProvider"
		alias
			"GetFormat"
		end

end -- class IFORMAT_PROVIDER
