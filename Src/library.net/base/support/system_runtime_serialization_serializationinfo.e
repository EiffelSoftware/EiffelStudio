indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Serialization.SerializationInfo"

frozen external class
	SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO

create {NONE}

feature -- Access

	frozen get_full_type_name: STRING is
		external
			"IL signature (): System.String use System.Runtime.Serialization.SerializationInfo"
		alias
			"get_FullTypeName"
		end

	frozen get_assembly_name: STRING is
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

	frozen set_full_type_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Serialization.SerializationInfo"
		alias
			"set_FullTypeName"
		end

	frozen set_assembly_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Serialization.SerializationInfo"
		alias
			"set_AssemblyName"
		end

feature -- Basic Operations

	frozen add_value (name: STRING; value: REAL) is
		external
			"IL signature (System.String, System.Single): System.Void use System.Runtime.Serialization.SerializationInfo"
		alias
			"AddValue"
		end

	frozen add_value_string_double (name: STRING; value: DOUBLE) is
		external
			"IL signature (System.String, System.Double): System.Void use System.Runtime.Serialization.SerializationInfo"
		alias
			"AddValue"
		end

	frozen get_int16 (name: STRING): INTEGER_16 is
		external
			"IL signature (System.String): System.Int16 use System.Runtime.Serialization.SerializationInfo"
		alias
			"GetInt16"
		end

	frozen get_decimal (name: STRING): SYSTEM_DECIMAL is
		external
			"IL signature (System.String): System.Decimal use System.Runtime.Serialization.SerializationInfo"
		alias
			"GetDecimal"
		end

	frozen add_value_string_object_type (name: STRING; value: ANY; type: SYSTEM_TYPE) is
		external
			"IL signature (System.String, System.Object, System.Type): System.Void use System.Runtime.Serialization.SerializationInfo"
		alias
			"AddValue"
		end

	frozen add_value_string_char (name: STRING; value: CHARACTER) is
		external
			"IL signature (System.String, System.Char): System.Void use System.Runtime.Serialization.SerializationInfo"
		alias
			"AddValue"
		end

	frozen get_byte (name: STRING): INTEGER_8 is
		external
			"IL signature (System.String): System.Byte use System.Runtime.Serialization.SerializationInfo"
		alias
			"GetByte"
		end

	frozen add_value_string_decimal (name: STRING; value: SYSTEM_DECIMAL) is
		external
			"IL signature (System.String, System.Decimal): System.Void use System.Runtime.Serialization.SerializationInfo"
		alias
			"AddValue"
		end

	frozen add_value_string_byte (name: STRING; value: INTEGER_8) is
		external
			"IL signature (System.String, System.Byte): System.Void use System.Runtime.Serialization.SerializationInfo"
		alias
			"AddValue"
		end

	frozen get_double (name: STRING): DOUBLE is
		external
			"IL signature (System.String): System.Double use System.Runtime.Serialization.SerializationInfo"
		alias
			"GetDouble"
		end

	frozen get_string (name: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Runtime.Serialization.SerializationInfo"
		alias
			"GetString"
		end

	frozen set_type (type: SYSTEM_TYPE) is
		external
			"IL signature (System.Type): System.Void use System.Runtime.Serialization.SerializationInfo"
		alias
			"SetType"
		end

	frozen get_int64 (name: STRING): INTEGER_64 is
		external
			"IL signature (System.String): System.Int64 use System.Runtime.Serialization.SerializationInfo"
		alias
			"GetInt64"
		end

	frozen get_single (name: STRING): REAL is
		external
			"IL signature (System.String): System.Single use System.Runtime.Serialization.SerializationInfo"
		alias
			"GetSingle"
		end

	frozen add_value_string_int16 (name: STRING; value: INTEGER_16) is
		external
			"IL signature (System.String, System.Int16): System.Void use System.Runtime.Serialization.SerializationInfo"
		alias
			"AddValue"
		end

	frozen add_value_string_boolean (name: STRING; value: BOOLEAN) is
		external
			"IL signature (System.String, System.Boolean): System.Void use System.Runtime.Serialization.SerializationInfo"
		alias
			"AddValue"
		end

	frozen add_value_string_date_time (name: STRING; value: SYSTEM_DATETIME) is
		external
			"IL signature (System.String, System.DateTime): System.Void use System.Runtime.Serialization.SerializationInfo"
		alias
			"AddValue"
		end

	frozen get_enumerator: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFOENUMERATOR is
		external
			"IL signature (): System.Runtime.Serialization.SerializationInfoEnumerator use System.Runtime.Serialization.SerializationInfo"
		alias
			"GetEnumerator"
		end

	frozen get_boolean (name: STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Runtime.Serialization.SerializationInfo"
		alias
			"GetBoolean"
		end

	frozen get_char (name: STRING): CHARACTER is
		external
			"IL signature (System.String): System.Char use System.Runtime.Serialization.SerializationInfo"
		alias
			"GetChar"
		end

	frozen add_value_string_object (name: STRING; value: ANY) is
		external
			"IL signature (System.String, System.Object): System.Void use System.Runtime.Serialization.SerializationInfo"
		alias
			"AddValue"
		end

	frozen get_date_time (name: STRING): SYSTEM_DATETIME is
		external
			"IL signature (System.String): System.DateTime use System.Runtime.Serialization.SerializationInfo"
		alias
			"GetDateTime"
		end

	frozen add_value_string_int64 (name: STRING; value: INTEGER_64) is
		external
			"IL signature (System.String, System.Int64): System.Void use System.Runtime.Serialization.SerializationInfo"
		alias
			"AddValue"
		end

	frozen add_value_string_int32 (name: STRING; value: INTEGER) is
		external
			"IL signature (System.String, System.Int32): System.Void use System.Runtime.Serialization.SerializationInfo"
		alias
			"AddValue"
		end

	frozen get_int32 (name: STRING): INTEGER is
		external
			"IL signature (System.String): System.Int32 use System.Runtime.Serialization.SerializationInfo"
		alias
			"GetInt32"
		end

	frozen get_value (name: STRING; type: SYSTEM_TYPE): ANY is
		external
			"IL signature (System.String, System.Type): System.Object use System.Runtime.Serialization.SerializationInfo"
		alias
			"GetValue"
		end

end -- class SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO
