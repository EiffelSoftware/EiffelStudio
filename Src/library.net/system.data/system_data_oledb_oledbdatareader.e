indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.OleDb.OleDbDataReader"

frozen external class
	SYSTEM_DATA_OLEDB_OLEDBDATAREADER

inherit
	SYSTEM_DATA_IDATARECORD
		rename
			get_data as system_data_idata_record_get_data
		end
	SYSTEM_MARSHALBYREFOBJECT
		redefine
			finalize
		end
	SYSTEM_IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end
	SYSTEM_DATA_IDATAREADER
		rename
			get_data as system_data_idata_record_get_data
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
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

	frozen get_item (index: INTEGER): ANY is
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

	frozen get_item_string (name: STRING): ANY is
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

	frozen get_time_span (ordinal: INTEGER): SYSTEM_TIMESPAN is
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

	frozen get_ordinal (name: STRING): INTEGER is
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

	frozen get_name (index: INTEGER): STRING is
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

	frozen get_chars (ordinal: INTEGER; data_index: INTEGER_64; buffer: ARRAY [CHARACTER]; buffer_index: INTEGER; length: INTEGER): INTEGER_64 is
		external
			"IL signature (System.Int32, System.Int64, System.Char[], System.Int32, System.Int32): System.Int64 use System.Data.OleDb.OleDbDataReader"
		alias
			"GetChars"
		end

	frozen get_string (ordinal: INTEGER): STRING is
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

	frozen get_values (values: ARRAY [ANY]): INTEGER is
		external
			"IL signature (System.Object[]): System.Int32 use System.Data.OleDb.OleDbDataReader"
		alias
			"GetValues"
		end

	frozen get_field_type (index: INTEGER): SYSTEM_TYPE is
		external
			"IL signature (System.Int32): System.Type use System.Data.OleDb.OleDbDataReader"
		alias
			"GetFieldType"
		end

	frozen get_guid (ordinal: INTEGER): SYSTEM_GUID is
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

	frozen get_schema_table: SYSTEM_DATA_DATATABLE is
		external
			"IL signature (): System.Data.DataTable use System.Data.OleDb.OleDbDataReader"
		alias
			"GetSchemaTable"
		end

	frozen get_date_time (ordinal: INTEGER): SYSTEM_DATETIME is
		external
			"IL signature (System.Int32): System.DateTime use System.Data.OleDb.OleDbDataReader"
		alias
			"GetDateTime"
		end

	frozen get_bytes (ordinal: INTEGER; data_index: INTEGER_64; buffer: ARRAY [INTEGER_8]; buffer_index: INTEGER; length: INTEGER): INTEGER_64 is
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

	frozen get_data_type_name (index: INTEGER): STRING is
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

	frozen get_data (ordinal: INTEGER): SYSTEM_DATA_OLEDB_OLEDBDATAREADER is
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

	frozen get_decimal (ordinal: INTEGER): SYSTEM_DECIMAL is
		external
			"IL signature (System.Int32): System.Decimal use System.Data.OleDb.OleDbDataReader"
		alias
			"GetDecimal"
		end

	frozen get_value (ordinal: INTEGER): ANY is
		external
			"IL signature (System.Int32): System.Object use System.Data.OleDb.OleDbDataReader"
		alias
			"GetValue"
		end

feature {NONE} -- Implementation

	frozen system_data_idata_record_get_data (ordinal: INTEGER): SYSTEM_DATA_IDATAREADER is
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

	frozen system_collections_ienumerable_get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Data.OleDb.OleDbDataReader"
		alias
			"System.Collections.IEnumerable.GetEnumerator"
		end

end -- class SYSTEM_DATA_OLEDB_OLEDBDATAREADER
