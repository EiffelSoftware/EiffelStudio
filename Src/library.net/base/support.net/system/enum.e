indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Enum"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ENUM

inherit
	VALUE_TYPE
		redefine
			get_hash_code,
			equals,
			to_string
		end
	ICOMPARABLE
	IFORMATTABLE

feature -- Basic Operations

	frozen get_underlying_type (enum_type: TYPE): TYPE is
		external
			"IL static signature (System.Type): System.Type use System.Enum"
		alias
			"GetUnderlyingType"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Enum"
		alias
			"Equals"
		end

	frozen is_defined (enum_type: TYPE; value: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL static signature (System.Type, System.Object): System.Boolean use System.Enum"
		alias
			"IsDefined"
		end

	frozen get_names (enum_type: TYPE): NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL static signature (System.Type): System.String[] use System.Enum"
		alias
			"GetNames"
		end

	frozen format (enum_type: TYPE; value: SYSTEM_OBJECT; format2: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL static signature (System.Type, System.Object, System.String): System.String use System.Enum"
		alias
			"Format"
		end

	frozen get_values (enum_type: TYPE): SYSTEM_ARRAY is
		external
			"IL static signature (System.Type): System.Array use System.Enum"
		alias
			"GetValues"
		end

	frozen to_object (enum_type: TYPE; value: INTEGER_8): SYSTEM_OBJECT is
		external
			"IL static signature (System.Type, System.Byte): System.Object use System.Enum"
		alias
			"ToObject"
		end

	frozen to_object_type_int16 (enum_type: TYPE; value: INTEGER_16): SYSTEM_OBJECT is
		external
			"IL static signature (System.Type, System.Int16): System.Object use System.Enum"
		alias
			"ToObject"
		end

	frozen get_name (enum_type: TYPE; value: SYSTEM_OBJECT): SYSTEM_STRING is
		external
			"IL static signature (System.Type, System.Object): System.String use System.Enum"
		alias
			"GetName"
		end

	frozen parse_type_string_boolean (enum_type: TYPE; value: SYSTEM_STRING; ignore_case: BOOLEAN): SYSTEM_OBJECT is
		external
			"IL static signature (System.Type, System.String, System.Boolean): System.Object use System.Enum"
		alias
			"Parse"
		end

	frozen compare_to (target: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Enum"
		alias
			"CompareTo"
		end

	frozen to_object_type_object (enum_type: TYPE; value: SYSTEM_OBJECT): SYSTEM_OBJECT is
		external
			"IL static signature (System.Type, System.Object): System.Object use System.Enum"
		alias
			"ToObject"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Enum"
		alias
			"ToString"
		end

	frozen to_object_type_int32 (enum_type: TYPE; value: INTEGER): SYSTEM_OBJECT is
		external
			"IL static signature (System.Type, System.Int32): System.Object use System.Enum"
		alias
			"ToObject"
		end

	frozen to_string_string2 (format2: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Enum"
		alias
			"ToString"
		end

	frozen get_type_code: TYPE_CODE is
		external
			"IL signature (): System.TypeCode use System.Enum"
		alias
			"GetTypeCode"
		end

	frozen to_object_type_int64 (enum_type: TYPE; value: INTEGER_64): SYSTEM_OBJECT is
		external
			"IL static signature (System.Type, System.Int64): System.Object use System.Enum"
		alias
			"ToObject"
		end

	frozen to_string_iformat_provider (provider: IFORMAT_PROVIDER): SYSTEM_STRING is
		external
			"IL signature (System.IFormatProvider): System.String use System.Enum"
		alias
			"ToString"
		end

	frozen to_string_string (format2: SYSTEM_STRING; provider: IFORMAT_PROVIDER): SYSTEM_STRING is
		external
			"IL signature (System.String, System.IFormatProvider): System.String use System.Enum"
		alias
			"ToString"
		end

	frozen parse (enum_type: TYPE; value: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL static signature (System.Type, System.String): System.Object use System.Enum"
		alias
			"Parse"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Enum"
		alias
			"GetHashCode"
		end

end -- class ENUM
