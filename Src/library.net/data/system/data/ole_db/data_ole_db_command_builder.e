indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.OleDb.OleDbCommandBuilder"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	DATA_OLE_DB_COMMAND_BUILDER

inherit
	SYSTEM_DLL_COMPONENT
		redefine
			dispose_boolean
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE

create
	make_data_ole_db_command_builder_1,
	make_data_ole_db_command_builder

feature {NONE} -- Initialization

	frozen make_data_ole_db_command_builder_1 (adapter: DATA_OLE_DB_DATA_ADAPTER) is
		external
			"IL creator signature (System.Data.OleDb.OleDbDataAdapter) use System.Data.OleDb.OleDbCommandBuilder"
		end

	frozen make_data_ole_db_command_builder is
		external
			"IL creator use System.Data.OleDb.OleDbCommandBuilder"
		end

feature -- Access

	frozen get_data_adapter: DATA_OLE_DB_DATA_ADAPTER is
		external
			"IL signature (): System.Data.OleDb.OleDbDataAdapter use System.Data.OleDb.OleDbCommandBuilder"
		alias
			"get_DataAdapter"
		end

	frozen get_quote_prefix: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.OleDb.OleDbCommandBuilder"
		alias
			"get_QuotePrefix"
		end

	frozen get_quote_suffix: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.OleDb.OleDbCommandBuilder"
		alias
			"get_QuoteSuffix"
		end

feature -- Element Change

	frozen set_quote_prefix (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.OleDb.OleDbCommandBuilder"
		alias
			"set_QuotePrefix"
		end

	frozen set_data_adapter (value: DATA_OLE_DB_DATA_ADAPTER) is
		external
			"IL signature (System.Data.OleDb.OleDbDataAdapter): System.Void use System.Data.OleDb.OleDbCommandBuilder"
		alias
			"set_DataAdapter"
		end

	frozen set_quote_suffix (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.OleDb.OleDbCommandBuilder"
		alias
			"set_QuoteSuffix"
		end

feature -- Basic Operations

	frozen derive_parameters (command: DATA_OLE_DB_COMMAND) is
		external
			"IL static signature (System.Data.OleDb.OleDbCommand): System.Void use System.Data.OleDb.OleDbCommandBuilder"
		alias
			"DeriveParameters"
		end

	frozen get_update_command: DATA_OLE_DB_COMMAND is
		external
			"IL signature (): System.Data.OleDb.OleDbCommand use System.Data.OleDb.OleDbCommandBuilder"
		alias
			"GetUpdateCommand"
		end

	frozen refresh_schema is
		external
			"IL signature (): System.Void use System.Data.OleDb.OleDbCommandBuilder"
		alias
			"RefreshSchema"
		end

	frozen get_delete_command: DATA_OLE_DB_COMMAND is
		external
			"IL signature (): System.Data.OleDb.OleDbCommand use System.Data.OleDb.OleDbCommandBuilder"
		alias
			"GetDeleteCommand"
		end

	frozen get_insert_command: DATA_OLE_DB_COMMAND is
		external
			"IL signature (): System.Data.OleDb.OleDbCommand use System.Data.OleDb.OleDbCommandBuilder"
		alias
			"GetInsertCommand"
		end

feature {NONE} -- Implementation

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Data.OleDb.OleDbCommandBuilder"
		alias
			"Dispose"
		end

end -- class DATA_OLE_DB_COMMAND_BUILDER
