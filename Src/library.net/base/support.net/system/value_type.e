indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ValueType"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	VALUE_TYPE

inherit
	SYSTEM_OBJECT
		redefine
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ValueType"
		alias
			"GetHashCode"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.ValueType"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ValueType"
		alias
			"Equals"
		end

end -- class VALUE_TYPE
