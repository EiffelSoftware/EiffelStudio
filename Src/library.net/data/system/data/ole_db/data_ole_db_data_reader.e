indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.OleDb.OleDbDataReader"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	DATA_OLE_DB_DATA_READER

inherit
	MARSHAL_BY_REF_OBJECT
		redefine
			finalize
		end
	DATA_IDATA_READER
		rename
			get_data as system_data_idata_record_get_data,
			dispose as system_idisposable_dispose
		end
	IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end
	DATA_IDATA_RECORD
		rename
			get_data as system_data_idata_record_get_data
		end
	IENUMERABLE
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
		end

create {NONE}

feature -- Access

	frozen get_records_affected: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.OleDb.OleDbDataReader"
		alias
			"get_RecordsAffected"
		end

	frozen get_item (index: INTEGER): SYSTEM_OBJECT is
		external
			"IL signature (System.Int32): System.Object use System.Data.OleDb.OleDbDataReader"
		alias
			"get_Item"
		end

	frozen get_depth: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.OleDb.OleDbDataReader"
		alias
			"get_Depth"
		end

	frozen get_item_string (name: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL signature (System.String): System.Object use System.Data.OleDb.OleDbDataReader"
		alias
			"get_Item"
		end

	frozen get_field_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.OleDb.OleDbDataReader"
		alias
			"get_FieldCount"
		end

	frozen get_is_closed: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.OleDb.OleDbDataReader"
		alias
			"get_IsClosed"
		end

feature -- Basic Operations

	frozen get_int64 (ordinal: INTEGER): INTEGER_64 is
		external
			"IL signature (System.Int32): System.Int64 use System.Data.OleDb.OleDbDataReader"
		alias
			"GetInt64"
		end

	frozen get_int16 (ordinal: INTEGER): INTEGER_16 is
		external
			"IL signature (System.Int32): System.Int16 use System.Data.OleDb.OleDbDataReader"
		alias
			"GetInt16"
		end

	frozen get_time_span (ordinal: INTEGER): TIME_SPAN is
		external
			"IL signature (System.Int32): System.TimeSpan use System.Data.OleDb.OleDbDataReader"
		alias
			"GetTimeSpan"
		end

	frozen read: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.OleDb.OleDbDataReader"
		alias
			"Read"
		end

	frozen get_ordinal (name: SYSTEM_STRING): INTEGER is
		external
			"IL signature (System.String): System.Int32 use System.Data.OleDb.OleDbDataReader"
		alias
			"GetOrdinal"
		end

	frozen close is
		external
			"IL signature (): System.Void use System.Data.OleDb.OleDbDataReader"
		alias
			"Close"
		end

	frozen get_name (index: INTEGER): SYSTEM_STRING is
		external
			"IL signature (System.Int32): System.String use System.Data.OleDb.OleDbDataReader"
		alias
			"GetName"
		end

	frozen get_int32 (ordinal: INTEGER): INTEGER is
		external
			"IL signature (System.Int32): System.Int32 use System.Data.OleDb.OleDbDataReader"
		alias
			"GetInt32"
		end

	frozen get_chars (ordinal: INTEGER; data_index: INTEGER_64; buffer: NATIVE_ARRAY [CHARACTER]; buffer_index: INTEGER; length: INTEGER): INTEGER_64 is
		external
			"IL signature (System.Int32, System.Int64, System.Char[], System.Int32, System.Int32): System.Int64 use System.Data.OleDb.OleDbDataReader"
		alias
			"GetChars"
		end

	frozen get_string (ordinal: INTEGER): SYSTEM_STRING is
		external
			"IL signature (System.Int32): System.String use System.Data.OleDb.OleDbDataReader"
		alias
			"GetString"
		end

	frozen get_byte (ordinal: INTEGER): INTEGER_8 is
		external
			"IL signature (System.Int32): System.Byte use System.Data.OleDb.OleDbDataReader"
		alias
			"GetByte"
		end

	frozen get_boolean (ordinal: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use System.Data.OleDb.OleDbDataReader"
		alias
			"GetBoolean"
		end

	frozen get_values (values: NATIVE_ARRAY [SYSTEM_OBJECT]): INTEGER is
		external
			"IL signature (System.Object[]): System.Int32 use System.Data.OleDb.OleDbDataReader"
		alias
			"GetValues"
		end

	frozen get_field_type (index: INTEGER): TYPE is
		external
			"IL signature (System.Int32): System.Type use System.Data.OleDb.OleDbDataReader"
		alias
			"GetFieldType"
		end

	frozen get_guid (ordinal: INTEGER): GUID is
		external
			"IL signature (System.Int32): System.Guid use System.Data.OleDb.OleDbDataReader"
		alias
			"GetGuid"
		end

	frozen next_result: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.OleDb.OleDbDataReader"
		alias
			"NextResult"
		end

	frozen get_schema_table: DATA_DATA_TABLE is
		external
			"IL signature (): System.Data.DataTable use System.Data.OleDb.OleDbDataReader"
		alias
			"GetSchemaTable"
		end

	frozen get_date_time (ordinal: INTEGER): SYSTEM_DATE_TIME is
		external
			"IL signature (System.Int32): System.DateTime use System.Data.OleDb.OleDbDataReader"
		alias
			"GetDateTime"
		end

	frozen get_bytes (ordinal: INTEGER; data_index: INTEGER_64; buffer: NATIVE_ARRAY [INTEGER_8]; buffer_index: INTEGER; length: INTEGER): INTEGER_64 is
		external
			"IL signature (System.Int32, System.Int64, System.Byte[], System.Int32, System.Int32): System.Int64 use System.Data.OleDb.OleDbDataReader"
		alias
			"GetBytes"
		end

	frozen get_char (ordinal: INTEGER): CHARACTER is
		external
			"IL signature (System.Int32): System.Char use System.Data.OleDb.OleDbDataReader"
		alias
			"GetChar"
		end

	frozen get_data_type_name (index: INTEGER): SYSTEM_STRING is
		external
			"IL signature (System.Int32): System.String use System.Data.OleDb.OleDbDataReader"
		alias
			"GetDataTypeName"
		end

	frozen get_float (ordinal: INTEGER): REAL is
		external
			"IL signature (System.Int32): System.Single use System.Data.OleDb.OleDbDataReader"
		alias
			"GetFloat"
		end

	frozen get_data (ordinal: INTEGER): DATA_OLE_DB_DATA_READER is
		external
			"IL signature (System.Int32): System.Data.OleDb.OleDbDataReader use System.Data.OleDb.OleDbDataReader"
		alias
			"GetData"
		end

	frozen is_dbnull (ordinal: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use System.Data.OleDb.OleDbDataReader"
		alias
			"IsDBNull"
		end

	frozen get_double (ordinal: INTEGER): DOUBLE is
		external
			"IL signature (System.Int32): System.Double use System.Data.OleDb.OleDbDataReader"
		alias
			"GetDouble"
		end

	frozen get_decimal (ordinal: INTEGER): DECIMAL is
		external
			"IL signature (System.Int32): System.Decimal use System.Data.OleDb.OleDbDataReader"
		alias
			"GetDecimal"
		end

	frozen get_value (ordinal: INTEGER): SYSTEM_OBJECT is
		external
			"IL signature (System.Int32): System.Object use System.Data.OleDb.OleDbDataReader"
		alias
			"GetValue"
		end

feature {NONE} -- Implementation

	frozen system_data_idata_record_get_data (ordinal: INTEGER): DATA_IDATA_READER is
		external
			"IL signature (System.Int32): System.Data.IDataReader use System.Data.OleDb.OleDbDataReader"
		alias
			"System.Data.IDataRecord.GetData"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Data.OleDb.OleDbDataReader"
		alias
			"Finalize"
		end

	frozen system_idisposable_dispose is
		external
			"IL signature (): System.Void use System.Data.OleDb.OleDbDataReader"
		alias
			"System.IDisposable.Dispose"
		end

	frozen system_collections_ienumerable_get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Data.OleDb.OleDbDataReader"
		alias
			"System.Collections.IEnumerable.GetEnumerator"
		end

end -- class DATA_OLE_DB_DATA_READER
