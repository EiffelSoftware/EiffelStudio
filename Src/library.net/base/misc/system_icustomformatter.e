indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.ICustomFormatter"

deferred external class
	SYSTEM_ICUSTOMFORMATTER

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	format (format2: STRING; arg: ANY; format_provider: SYSTEM_IFORMATPROVIDER): STRING is
		external
			"IL deferred signature (System.String, System.Object, System.IFormatProvider): System.String use System.ICustomFormatter"
		alias
			"Format"
		end

end -- class SYSTEM_ICUSTOMFORMATTER
