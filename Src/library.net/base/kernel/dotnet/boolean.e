indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "System.Boolean"
	assembly: "mscorlib", "1.0.2411.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	BOOLEAN

inherit
	VALUE_TYPE
		redefine
			get_hash_code,
			equals,
			to_string
		end
	ICOMPARABLE

	BOOLEAN_REF
		redefine
			get_hash_code,
			equals,
			to_string
		end

create {NONE}

feature -- Access

	frozen false_string: SYSTEM_STRING is
		external
			"IL static_field signature :System.String use System.Boolean"
		alias
			"FalseString"
		end

	frozen true_string: SYSTEM_STRING is
		external
			"IL static_field signature :System.String use System.Boolean"
		alias
			"TrueString"
		end

feature -- Basic Operations

	frozen parse (value: SYSTEM_STRING): BOOLEAN is
		external
			"IL static signature (System.String): System.Boolean use System.Boolean"
		alias
			"Parse"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Boolean"
		alias
			"GetHashCode"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Boolean"
		alias
			"Equals"
		end

	frozen to_string_iformat_provider (provider: IFORMAT_PROVIDER): SYSTEM_STRING is
		external
			"IL signature (System.IFormatProvider): System.String use System.Boolean"
		alias
			"ToString"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Boolean"
		alias
			"ToString"
		end

	frozen get_type_code: TYPE_CODE is
		external
			"IL signature (): System.TypeCode use System.Boolean"
		alias
			"GetTypeCode"
		end

	frozen compare_to (obj: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Boolean"
		alias
			"CompareTo"
		end

end -- class BOOLEAN
