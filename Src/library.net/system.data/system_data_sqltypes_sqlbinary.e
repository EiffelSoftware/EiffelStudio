indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.SqlTypes.SqlBinary"

frozen expanded external class
	SYSTEM_DATA_SQLTYPES_SQLBINARY

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

	frozen make_sqlbinary (value: ARRAY [INTEGER_8]) is
		external
			"IL creator signature (System.Byte[]) use System.Data.SqlTypes.SqlBinary"
		end

feature -- Access

	frozen get_item (index: INTEGER): INTEGER_8 is
		external
			"IL signature (System.Int32): System.Byte use System.Data.SqlTypes.SqlBinary"
		alias
			"get_Item"
		end

	frozen null: SYSTEM_DATA_SQLTYPES_SQLBINARY is
		external
			"IL static_field signature :System.Data.SqlTypes.SqlBinary use System.Data.SqlTypes.SqlBinary"
		alias
			"Null"
		end

	frozen get_length: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.SqlTypes.SqlBinary"
		alias
			"get_Length"
		end

	frozen get_is_null: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.SqlTypes.SqlBinary"
		alias
			"get_IsNull"
		end

	frozen get_value: ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Data.SqlTypes.SqlBinary"
		alias
			"get_Value"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Data.SqlTypes.SqlBinary"
		alias
			"ToString"
		end

	frozen greater_than (x: SYSTEM_DATA_SQLTYPES_SQLBINARY; y: SYSTEM_DATA_SQLTYPES_SQLBINARY): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlBinary, System.Data.SqlTypes.SqlBinary): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBinary"
		alias
			"GreaterThan"
		end

	frozen concat (x: SYSTEM_DATA_SQLTYPES_SQLBINARY; y: SYSTEM_DATA_SQLTYPES_SQLBINARY): SYSTEM_DATA_SQLTYPES_SQLBINARY is
		external
			"IL static signature (System.Data.SqlTypes.SqlBinary, System.Data.SqlTypes.SqlBinary): System.Data.SqlTypes.SqlBinary use System.Data.SqlTypes.SqlBinary"
		alias
			"Concat"
		end

	frozen less_than (x: SYSTEM_DATA_SQLTYPES_SQLBINARY; y: SYSTEM_DATA_SQLTYPES_SQLBINARY): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlBinary, System.Data.SqlTypes.SqlBinary): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBinary"
		alias
			"LessThan"
		end

	frozen not_equals (x: SYSTEM_DATA_SQLTYPES_SQLBINARY; y: SYSTEM_DATA_SQLTYPES_SQLBINARY): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlBinary, System.Data.SqlTypes.SqlBinary): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBinary"
		alias
			"NotEquals"
		end

	frozen greater_than_or_equal (x: SYSTEM_DATA_SQLTYPES_SQLBINARY; y: SYSTEM_DATA_SQLTYPES_SQLBINARY): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlBinary, System.Data.SqlTypes.SqlBinary): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBinary"
		alias
			"GreaterThanOrEqual"
		end

	equals_object (value: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Data.SqlTypes.SqlBinary"
		alias
			"Equals"
		end

	frozen less_than_or_equal (x: SYSTEM_DATA_SQLTYPES_SQLBINARY; y: SYSTEM_DATA_SQLTYPES_SQLBINARY): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlBinary, System.Data.SqlTypes.SqlBinary): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBinary"
		alias
			"LessThanOrEqual"
		end

	frozen equals_sql_binary (x: SYSTEM_DATA_SQLTYPES_SQLBINARY; y: SYSTEM_DATA_SQLTYPES_SQLBINARY): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlBinary, System.Data.SqlTypes.SqlBinary): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBinary"
		alias
			"Equals"
		end

	frozen compare_to (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Data.SqlTypes.SqlBinary"
		alias
			"CompareTo"
		end

	frozen to_sql_guid: SYSTEM_DATA_SQLTYPES_SQLGUID is
		external
			"IL signature (): System.Data.SqlTypes.SqlGuid use System.Data.SqlTypes.SqlBinary"
		alias
			"ToSqlGuid"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.SqlTypes.SqlBinary"
		alias
			"GetHashCode"
		end

feature -- Binary Operators

	frozen infix ">=" (y: SYSTEM_DATA_SQLTYPES_SQLBINARY): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlBinary): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBinary"
		alias
			"op_GreaterThanOrEqual"
		end

	frozen infix "#==" (y: SYSTEM_DATA_SQLTYPES_SQLBINARY): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlBinary): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBinary"
		alias
			"op_Equality"
		end

	frozen infix "|=" (y: SYSTEM_DATA_SQLTYPES_SQLBINARY): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlBinary): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBinary"
		alias
			"op_Inequality"
		end

	frozen infix "+" (y: SYSTEM_DATA_SQLTYPES_SQLBINARY): SYSTEM_DATA_SQLTYPES_SQLBINARY is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlBinary): System.Data.SqlTypes.SqlBinary use System.Data.SqlTypes.SqlBinary"
		alias
			"op_Addition"
		end

	frozen infix "<" (y: SYSTEM_DATA_SQLTYPES_SQLBINARY): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlBinary): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBinary"
		alias
			"op_LessThan"
		end

	frozen infix "<=" (y: SYSTEM_DATA_SQLTYPES_SQLBINARY): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlBinary): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBinary"
		alias
			"op_LessThanOrEqual"
		end

	frozen infix ">" (y: SYSTEM_DATA_SQLTYPES_SQLBINARY): SYSTEM_DATA_SQLTYPES_SQLBOOLEAN is
		external
			"IL operator  signature (System.Data.SqlTypes.SqlBinary): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlBinary"
		alias
			"op_GreaterThan"
		end

feature -- Specials

	frozen op_explicit_sql_binary (x: SYSTEM_DATA_SQLTYPES_SQLBINARY): ARRAY [INTEGER_8] is
		external
			"IL static signature (System.Data.SqlTypes.SqlBinary): System.Byte[] use System.Data.SqlTypes.SqlBinary"
		alias
			"op_Explicit"
		end

	frozen op_implicit (x: ARRAY [INTEGER_8]): SYSTEM_DATA_SQLTYPES_SQLBINARY is
		external
			"IL static signature (System.Byte[]): System.Data.SqlTypes.SqlBinary use System.Data.SqlTypes.SqlBinary"
		alias
			"op_Implicit"
		end

	frozen op_explicit (x: SYSTEM_DATA_SQLTYPES_SQLGUID): SYSTEM_DATA_SQLTYPES_SQLBINARY is
		external
			"IL static signature (System.Data.SqlTypes.SqlGuid): System.Data.SqlTypes.SqlBinary use System.Data.SqlTypes.SqlBinary"
		alias
			"op_Explicit"
		end

end -- class SYSTEM_DATA_SQLTYPES_SQLBINARY
