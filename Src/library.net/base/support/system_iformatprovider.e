indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.IFormatProvider"

deferred external class
	SYSTEM_IFORMATPROVIDER

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	get_format (format_type: SYSTEM_TYPE): ANY is
		external
			"IL deferred signature (System.Type): System.Object use System.IFormatProvider"
		alias
			"GetFormat"
		end

end -- class SYSTEM_IFORMATPROVIDER
