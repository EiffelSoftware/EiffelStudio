indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.ValueType"

deferred external class
	SYSTEM_VALUETYPE

inherit
	ANY
		redefine
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ValueType"
		alias
			"Equals"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ValueType"
		alias
			"GetHashCode"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.ValueType"
		alias
			"ToString"
		end

end -- class SYSTEM_VALUETYPE
