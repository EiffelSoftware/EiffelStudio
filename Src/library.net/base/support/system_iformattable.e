indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.IFormattable"

deferred external class
	SYSTEM_IFORMATTABLE

inherit
	ANY
		undefine
			Finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	to_string_with_format_and_provider (format: STRING; formatProvider: SYSTEM_IFORMATPROVIDER): STRING is
		external
			"IL deferred signature (System.String, System.IFormatProvider): System.String use System.IFormattable"
		alias
			"ToString"
		end

end -- class SYSTEM_IFORMATTABLE
