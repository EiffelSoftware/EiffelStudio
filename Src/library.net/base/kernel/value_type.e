indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ValueType"

deferred external class
	VALUE_TYPE

inherit
	ANY
		redefine
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ValueType"
		alias
			"GetHashCode"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ValueType"
		alias
			"Equals"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.ValueType"
		alias
			"ToString"
		end

end -- class VALUE_TYPE
