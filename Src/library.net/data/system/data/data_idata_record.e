indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.IDataRecord"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	DATA_IDATA_RECORD

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_item (i: INTEGER): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.Int32): System.Object use System.Data.IDataRecord"
		alias
			"get_Item"
		end

	get_item_string (name: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.String): System.Object use System.Data.IDataRecord"
		alias
			"get_Item"
		end

	get_field_count: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.Data.IDataRecord"
		alias
			"get_FieldCount"
		end

feature -- Basic Operations

	get_int64 (i: INTEGER): INTEGER_64 is
		external
			"IL deferred signature (System.Int32): System.Int64 use System.Data.IDataRecord"
		alias
			"GetInt64"
		end

	get_int16 (i: INTEGER): INTEGER_16 is
		external
			"IL deferred signature (System.Int32): System.Int16 use System.Data.IDataRecord"
		alias
			"GetInt16"
		end

	get_data (i: INTEGER): DATA_IDATA_READER is
		external
			"IL deferred signature (System.Int32): System.Data.IDataReader use System.Data.IDataRecord"
		alias
			"GetData"
		end

	get_ordinal (name: SYSTEM_STRING): INTEGER is
		external
			"IL deferred signature (System.String): System.Int32 use System.Data.IDataRecord"
		alias
			"GetOrdinal"
		end

	get_name (i: INTEGER): SYSTEM_STRING is
		external
			"IL deferred signature (System.Int32): System.String use System.Data.IDataRecord"
		alias
			"GetName"
		end

	get_int32 (i: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Int32): System.Int32 use System.Data.IDataRecord"
		alias
			"GetInt32"
		end

	get_chars (i: INTEGER; fieldoffset: INTEGER_64; buffer: NATIVE_ARRAY [CHARACTER]; bufferoffset: INTEGER; length: INTEGER): INTEGER_64 is
		external
			"IL deferred signature (System.Int32, System.Int64, System.Char[], System.Int32, System.Int32): System.Int64 use System.Data.IDataRecord"
		alias
			"GetChars"
		end

	get_string (i: INTEGER): SYSTEM_STRING is
		external
			"IL deferred signature (System.Int32): System.String use System.Data.IDataRecord"
		alias
			"GetString"
		end

	get_byte (i: INTEGER): INTEGER_8 is
		external
			"IL deferred signature (System.Int32): System.Byte use System.Data.IDataRecord"
		alias
			"GetByte"
		end

	get_boolean (i: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.Int32): System.Boolean use System.Data.IDataRecord"
		alias
			"GetBoolean"
		end

	get_values (values: NATIVE_ARRAY [SYSTEM_OBJECT]): INTEGER is
		external
			"IL deferred signature (System.Object[]): System.Int32 use System.Data.IDataRecord"
		alias
			"GetValues"
		end

	get_field_type (i: INTEGER): TYPE is
		external
			"IL deferred signature (System.Int32): System.Type use System.Data.IDataRecord"
		alias
			"GetFieldType"
		end

	get_guid (i: INTEGER): GUID is
		external
			"IL deferred signature (System.Int32): System.Guid use System.Data.IDataRecord"
		alias
			"GetGuid"
		end

	get_date_time (i: INTEGER): SYSTEM_DATE_TIME is
		external
			"IL deferred signature (System.Int32): System.DateTime use System.Data.IDataRecord"
		alias
			"GetDateTime"
		end

	get_bytes (i: INTEGER; field_offset: INTEGER_64; buffer: NATIVE_ARRAY [INTEGER_8]; bufferoffset: INTEGER; length: INTEGER): INTEGER_64 is
		external
			"IL deferred signature (System.Int32, System.Int64, System.Byte[], System.Int32, System.Int32): System.Int64 use System.Data.IDataRecord"
		alias
			"GetBytes"
		end

	get_char (i: INTEGER): CHARACTER is
		external
			"IL deferred signature (System.Int32): System.Char use System.Data.IDataRecord"
		alias
			"GetChar"
		end

	get_data_type_name (i: INTEGER): SYSTEM_STRING is
		external
			"IL deferred signature (System.Int32): System.String use System.Data.IDataRecord"
		alias
			"GetDataTypeName"
		end

	get_float (i: INTEGER): REAL is
		external
			"IL deferred signature (System.Int32): System.Single use System.Data.IDataRecord"
		alias
			"GetFloat"
		end

	is_dbnull (i: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.Int32): System.Boolean use System.Data.IDataRecord"
		alias
			"IsDBNull"
		end

	get_double (i: INTEGER): DOUBLE is
		external
			"IL deferred signature (System.Int32): System.Double use System.Data.IDataRecord"
		alias
			"GetDouble"
		end

	get_decimal (i: INTEGER): DECIMAL is
		external
			"IL deferred signature (System.Int32): System.Decimal use System.Data.IDataRecord"
		alias
			"GetDecimal"
		end

	get_value (i: INTEGER): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.Int32): System.Object use System.Data.IDataRecord"
		alias
			"GetValue"
		end

end -- class DATA_IDATA_RECORD
