indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Serialization.SerializationInfo"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SERIALIZATION_INFO

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Access

	frozen get_full_type_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Serialization.SerializationInfo"
		alias
			"get_FullTypeName"
		end

	frozen get_assembly_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Serialization.SerializationInfo"
		alias
			"get_AssemblyName"
		end

	frozen get_member_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Serialization.SerializationInfo"
		alias
			"get_MemberCount"
		end

feature -- Element Change

	frozen set_full_type_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Serialization.SerializationInfo"
		alias
			"set_FullTypeName"
		end

	frozen set_assembly_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Serialization.SerializationInfo"
		alias
			"set_AssemblyName"
		end

feature -- Basic Operations

	frozen add_value (name: SYSTEM_STRING; value: REAL) is
		external
			"IL signature (System.String, System.Single): System.Void use System.Runtime.Serialization.SerializationInfo"
		alias
			"AddValue"
		end

	frozen add_value_string_double (name: SYSTEM_STRING; value: DOUBLE) is
		external
			"IL signature (System.String, System.Double): System.Void use System.Runtime.Serialization.SerializationInfo"
		alias
			"AddValue"
		end

	frozen get_int16 (name: SYSTEM_STRING): INTEGER_16 is
		external
			"IL signature (System.String): System.Int16 use System.Runtime.Serialization.SerializationInfo"
		alias
			"GetInt16"
		end

	frozen get_decimal (name: SYSTEM_STRING): DECIMAL is
		external
			"IL signature (System.String): System.Decimal use System.Runtime.Serialization.SerializationInfo"
		alias
			"GetDecimal"
		end

	frozen add_value_string_object_type (name: SYSTEM_STRING; value: SYSTEM_OBJECT; type: TYPE) is
		external
			"IL signature (System.String, System.Object, System.Type): System.Void use System.Runtime.Serialization.SerializationInfo"
		alias
			"AddValue"
		end

	frozen add_value_string_char (name: SYSTEM_STRING; value: CHARACTER) is
		external
			"IL signature (System.String, System.Char): System.Void use System.Runtime.Serialization.SerializationInfo"
		alias
			"AddValue"
		end

	frozen get_byte (name: SYSTEM_STRING): INTEGER_8 is
		external
			"IL signature (System.String): System.Byte use System.Runtime.Serialization.SerializationInfo"
		alias
			"GetByte"
		end

	frozen add_value_string_decimal (name: SYSTEM_STRING; value: DECIMAL) is
		external
			"IL signature (System.String, System.Decimal): System.Void use System.Runtime.Serialization.SerializationInfo"
		alias
			"AddValue"
		end

	frozen add_value_string_byte (name: SYSTEM_STRING; value: INTEGER_8) is
		external
			"IL signature (System.String, System.Byte): System.Void use System.Runtime.Serialization.SerializationInfo"
		alias
			"AddValue"
		end

	frozen get_double (name: SYSTEM_STRING): DOUBLE is
		external
			"IL signature (System.String): System.Double use System.Runtime.Serialization.SerializationInfo"
		alias
			"GetDouble"
		end

	frozen get_string (name: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Runtime.Serialization.SerializationInfo"
		alias
			"GetString"
		end

	frozen set_type (type: TYPE) is
		external
			"IL signature (System.Type): System.Void use System.Runtime.Serialization.SerializationInfo"
		alias
			"SetType"
		end

	frozen get_int64 (name: SYSTEM_STRING): INTEGER_64 is
		external
			"IL signature (System.String): System.Int64 use System.Runtime.Serialization.SerializationInfo"
		alias
			"GetInt64"
		end

	frozen get_single (name: SYSTEM_STRING): REAL is
		external
			"IL signature (System.String): System.Single use System.Runtime.Serialization.SerializationInfo"
		alias
			"GetSingle"
		end

	frozen add_value_string_int16 (name: SYSTEM_STRING; value: INTEGER_16) is
		external
			"IL signature (System.String, System.Int16): System.Void use System.Runtime.Serialization.SerializationInfo"
		alias
			"AddValue"
		end

	frozen add_value_string_boolean (name: SYSTEM_STRING; value: BOOLEAN) is
		external
			"IL signature (System.String, System.Boolean): System.Void use System.Runtime.Serialization.SerializationInfo"
		alias
			"AddValue"
		end

	frozen add_value_string_date_time (name: SYSTEM_STRING; value: SYSTEM_DATE_TIME) is
		external
			"IL signature (System.String, System.DateTime): System.Void use System.Runtime.Serialization.SerializationInfo"
		alias
			"AddValue"
		end

	frozen get_enumerator: SERIALIZATION_INFO_ENUMERATOR is
		external
			"IL signature (): System.Runtime.Serialization.SerializationInfoEnumerator use System.Runtime.Serialization.SerializationInfo"
		alias
			"GetEnumerator"
		end

	frozen get_boolean (name: SYSTEM_STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Runtime.Serialization.SerializationInfo"
		alias
			"GetBoolean"
		end

	frozen get_char (name: SYSTEM_STRING): CHARACTER is
		external
			"IL signature (System.String): System.Char use System.Runtime.Serialization.SerializationInfo"
		alias
			"GetChar"
		end

	frozen add_value_string_object (name: SYSTEM_STRING; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.String, System.Object): System.Void use System.Runtime.Serialization.SerializationInfo"
		alias
			"AddValue"
		end

	frozen get_date_time (name: SYSTEM_STRING): SYSTEM_DATE_TIME is
		external
			"IL signature (System.String): System.DateTime use System.Runtime.Serialization.SerializationInfo"
		alias
			"GetDateTime"
		end

	frozen add_value_string_int64 (name: SYSTEM_STRING; value: INTEGER_64) is
		external
			"IL signature (System.String, System.Int64): System.Void use System.Runtime.Serialization.SerializationInfo"
		alias
			"AddValue"
		end

	frozen add_value_string_int32 (name: SYSTEM_STRING; value: INTEGER) is
		external
			"IL signature (System.String, System.Int32): System.Void use System.Runtime.Serialization.SerializationInfo"
		alias
			"AddValue"
		end

	frozen get_int32 (name: SYSTEM_STRING): INTEGER is
		external
			"IL signature (System.String): System.Int32 use System.Runtime.Serialization.SerializationInfo"
		alias
			"GetInt32"
		end

	frozen get_value (name: SYSTEM_STRING; type: TYPE): SYSTEM_OBJECT is
		external
			"IL signature (System.String, System.Type): System.Object use System.Runtime.Serialization.SerializationInfo"
		alias
			"GetValue"
		end

end -- class SERIALIZATION_INFO
