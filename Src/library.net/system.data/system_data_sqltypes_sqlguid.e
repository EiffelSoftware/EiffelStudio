indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.SqlTypes.SqlGuid"

frozen expanded external class
	SYSTEM_DATA_SQLTYPES_SQLGUID

inherit
	VALUE_TYPE
		rename
			is_equal as equals_object
		redefine
			get_hash_code,
			equals_object,
			to_string
		end
	SYSTEM_DATA_SQLTYPES_INULLABLE
		rename
			is_equal as equals_object
		end
	SYSTEM_ICOMPARABLE
		rename
			is_equal as equals_object
		end



feature -- Initialization

	frozen make_sqlguid_3 (a: INTEGER; b: INTEGER_16; c: INTEGER_16; d: INTEGER_8; e: INTEGER_8; f: INTEGER_8; g: INTEGER_8; h: INTEGER_8; i: INTEGER_8; j: INTEGER_8; k: INTEGER_8) is
		external
			"IL creator signature (System.Int32, System.Int16, System.Int16, System.Byte, System.Byte, System.Byte, System.Byte, System.Byte, System.Byte, System.Byte, System.Byte) use System.Data.SqlTypes.SqlGuid"
		end

	frozen make_sqlguid_2 (g: SYSTEM_GUID) is
		external
			"IL creator signature (System.Guid) use System.Data.SqlTypes.SqlGuid"
		end

	frozen make_sqlguid (value: ARRAY [INTEGER_8]) is
		external
			"IL creator signature (System.Byte[]) use System.Data.SqlTypes.SqlGuid"
		end

	frozen make_sqlguid_1 (s: STRING) is
		external
			"IL creator signature (System.String) use System.Data.SqlTypes.SqlGuid"
		end

feature -- Access

	frozen null: SYSTEM_DATA_SQLTYPES_SQLGUID is
		external
			"IL static_field signature :System.Data.SqlTypes.SqlGuid use System.Data.SqlTypes.SqlGuid"
		alias
			"Null"
		end

	frozen get_is_null: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.SqlTypes.SqlGuid"
		alias
			"get_IsNull"
		end

	frozen get_value: SYSTEM_GUID is
		external
			"IL signature (): System.Guid use System.Data.SqlTypes.SqlGuid"
		alias
			"get_Value"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Data.SqlTypes.SqlGuid"
		alias
			"ToString"
		end

	frozen greater_than (x: SYSTEM_DATA_SQLTYPES_SQLGUID; y: SYSTEM_DATA_SQLTYPES_SQLGUID): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlGuid, System.Data.SqlTypes.SqlGuid): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlGuid"
		alias
			"GreaterThan"
		end

	frozen to_byte_array: ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Data.SqlTypes.SqlGuid"
		alias
			"ToByteArray"
		end

	frozen equals_sql_guid (x: SYSTEM_DATA_SQLTYPES_SQLGUID; y: SYSTEM_DATA_SQLTYPES_SQLGUID): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlGuid, System.Data.SqlTypes.SqlGuid): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlGuid"
		alias
			"Equals"
		end

	frozen less_than (x: SYSTEM_DATA_SQLTYPES_SQLGUID; y: SYSTEM_DATA_SQLTYPES_SQLGUID): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlGuid, System.Data.SqlTypes.SqlGuid): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlGuid"
		alias
			"LessThan"
		end

	frozen not_equals (x: SYSTEM_DATA_SQLTYPES_SQLGUID; y: SYSTEM_DATA_SQLTYPES_SQLGUID): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlGuid, System.Data.SqlTypes.SqlGuid): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlGuid"
		alias
			"NotEquals"
		end

	frozen to_sql_string: SYSTEM_DATA_SQLTYPES_SQLSTRING is
		external
			"IL signature (): System.Data.SqlTypes.SqlString use System.Data.SqlTypes.SqlGuid"
		alias
			"ToSqlString"
		end

	frozen greater_than_or_equal (x: SYSTEM_DATA_SQLTYPES_SQLGUID; y: SYSTEM_DATA_SQLTYPES_SQLGUID): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlGuid, System.Data.SqlTypes.SqlGuid): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlGuid"
		alias
			"GreaterThanOrEqual"
		end

	frozen to_sql_binary: SYSTEM_DATA_SQLTYPES_SQLBINARY is
		external
			"IL signature (): System.Data.SqlTypes.SqlBinary use System.Data.SqlTypes.SqlGuid"
		alias
			"ToSqlBinary"
		end

	frozen parse (s: STRING): SYSTEM_DATA_SQLTYPES_SQLGUID is
		external
			"IL static signature (System.String): System.Data.SqlTypes.SqlGuid use System.Data.SqlTypes.SqlGuid"
		alias
			"Parse"
		end

	frozen less_than_or_equal (x: SYSTEM_DATA_SQLTYPES_SQLGUID; y: SYSTEM_DATA_SQLTYPES_SQLGUID): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlGuid, System.Data.SqlTypes.SqlGuid): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlGuid"
		alias
			"LessThanOrEqual"
		end

	equals_object (value: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Data.SqlTypes.SqlGuid"
		alias
			"Equals"
		end

	frozen compare_to (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Data.SqlTypes.SqlGuid"
		alias
			"CompareTo"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.SqlTypes.SqlGuid"
		alias
			"GetHashCode"
		end

feature -- Binary Operators

	frozen infix ">=" (y: SYSTEM_DATA_SQLTYPES_SQLGUID): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlGuid): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlGuid"
		alias
			"op_GreaterThanOrEqual"
		end

	frozen infix "#==" (y: SYSTEM_DATA_SQLTYPES_SQLGUID): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlGuid): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlGuid"
		alias
			"op_Equality"
		end

	frozen infix "|=" (y: SYSTEM_DATA_SQLTYPES_SQLGUID): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlGuid): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlGuid"
		alias
			"op_Inequality"
		end

	frozen infix "<" (y: SYSTEM_DATA_SQLTYPES_SQLGUID): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlGuid): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlGuid"
		alias
			"op_LessThan"
		end

	frozen infix "<=" (y: SYSTEM_DATA_SQLTYPES_SQLGUID): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlGuid): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlGuid"
		alias
			"op_LessThanOrEqual"
		end

	frozen infix ">" (y: SYSTEM_DATA_SQLTYPES_SQLGUID): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlGuid): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlGuid"
		alias
			"op_GreaterThan"
		end

feature -- Specials

	frozen op_implicit (x: SYSTEM_GUID): SYSTEM_DATA_SQLTYPES_SQLGUID is
		external
			"IL static signature (System.Guid): System.Data.SqlTypes.SqlGuid use System.Data.SqlTypes.SqlGuid"
		alias
			"op_Implicit"
		end

	frozen op_explicit_sql_guid (x: SYSTEM_DATA_SQLTYPES_SQLGUID): SYSTEM_GUID is
		external
			"IL static signature (System.Data.SqlTypes.SqlGuid): System.Guid use System.Data.SqlTypes.SqlGuid"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_string (x: SYSTEM_DATA_SQLTYPES_SQLSTRING): SYSTEM_DATA_SQLTYPES_SQLGUID is
		external
			"IL static signature (System.Data.SqlTypes.SqlString): System.Data.SqlTypes.SqlGuid use System.Data.SqlTypes.SqlGuid"
		alias
			"op_Explicit"
		end

	frozen op_explicit (x: SYSTEM_DATA_SQLTYPES_SQLBINARY): SYSTEM_DATA_SQLTYPES_SQLGUID is
		external
			"IL static signature (System.Data.SqlTypes.SqlBinary): System.Data.SqlTypes.SqlGuid use System.Data.SqlTypes.SqlGuid"
		alias
			"op_Explicit"
		end

end -- class SYSTEM_DATA_SQLTYPES_SQLGUID
