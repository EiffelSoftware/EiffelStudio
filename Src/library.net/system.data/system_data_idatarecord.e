indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.IDataRecord"

deferred external class
	SYSTEM_DATA_IDATARECORD

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	get_item (i: INTEGER): ANY is
		external
			"IL deferred signature (System.Int32): System.Object use System.Data.IDataRecord"
		alias
			"get_Item"
		end

	get_item_string (name: STRING): ANY is
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

	get_data (i: INTEGER): SYSTEM_DATA_IDATAREADER is
		external
			"IL deferred signature (System.Int32): System.Data.IDataReader use System.Data.IDataRecord"
		alias
			"GetData"
		end

	get_ordinal (name: STRING): INTEGER is
		external
			"IL deferred signature (System.String): System.Int32 use System.Data.IDataRecord"
		alias
			"GetOrdinal"
		end

	get_name (i: INTEGER): STRING is
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

	get_chars (i: INTEGER; fieldoffset: INTEGER_64; buffer: ARRAY [CHARACTER]; bufferoffset: INTEGER; length: INTEGER): INTEGER_64 is
		external
			"IL deferred signature (System.Int32, System.Int64, System.Char[], System.Int32, System.Int32): System.Int64 use System.Data.IDataRecord"
		alias
			"GetChars"
		end

	get_string (i: INTEGER): STRING is
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

	get_values (values: ARRAY [ANY]): INTEGER is
		external
			"IL deferred signature (System.Object[]): System.Int32 use System.Data.IDataRecord"
		alias
			"GetValues"
		end

	get_field_type (i: INTEGER): SYSTEM_TYPE is
		external
			"IL deferred signature (System.Int32): System.Type use System.Data.IDataRecord"
		alias
			"GetFieldType"
		end

	get_guid (i: INTEGER): SYSTEM_GUID is
		external
			"IL deferred signature (System.Int32): System.Guid use System.Data.IDataRecord"
		alias
			"GetGuid"
		end

	get_date_time (i: INTEGER): SYSTEM_DATETIME is
		external
			"IL deferred signature (System.Int32): System.DateTime use System.Data.IDataRecord"
		alias
			"GetDateTime"
		end

	get_bytes (i: INTEGER; field_offset: INTEGER_64; buffer: ARRAY [INTEGER_8]; bufferoffset: INTEGER; length: INTEGER): INTEGER_64 is
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

	get_data_type_name (i: INTEGER): STRING is
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

	get_decimal (i: INTEGER): SYSTEM_DECIMAL is
		external
			"IL deferred signature (System.Int32): System.Decimal use System.Data.IDataRecord"
		alias
			"GetDecimal"
		end

	get_value (i: INTEGER): ANY is
		external
			"IL deferred signature (System.Int32): System.Object use System.Data.IDataRecord"
		alias
			"GetValue"
		end

end -- class SYSTEM_DATA_IDATARECORD
