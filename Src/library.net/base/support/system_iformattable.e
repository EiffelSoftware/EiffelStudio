indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.IFormattable"

deferred external class
	SYSTEM_IFORMATTABLE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	to_string_string (format: STRING; format_provider: SYSTEM_IFORMATPROVIDER): STRING is
		external
			"IL deferred signature (System.String, System.IFormatProvider): System.String use System.IFormattable"
		alias
			"ToString"
		end

end -- class SYSTEM_IFORMATTABLE
