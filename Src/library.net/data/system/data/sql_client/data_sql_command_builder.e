indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.SqlClient.SqlCommandBuilder"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	DATA_SQL_COMMAND_BUILDER

inherit
	SYSTEM_DLL_COMPONENT
		redefine
			dispose_boolean
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE

create
	make_data_sql_command_builder_1,
	make_data_sql_command_builder

feature {NONE} -- Initialization

	frozen make_data_sql_command_builder_1 (adapter: DATA_SQL_DATA_ADAPTER) is
		external
			"IL creator signature (System.Data.SqlClient.SqlDataAdapter) use System.Data.SqlClient.SqlCommandBuilder"
		end

	frozen make_data_sql_command_builder is
		external
			"IL creator use System.Data.SqlClient.SqlCommandBuilder"
		end

feature -- Access

	frozen get_data_adapter: DATA_SQL_DATA_ADAPTER is
		external
			"IL signature (): System.Data.SqlClient.SqlDataAdapter use System.Data.SqlClient.SqlCommandBuilder"
		alias
			"get_DataAdapter"
		end

	frozen get_quote_prefix: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.SqlClient.SqlCommandBuilder"
		alias
			"get_QuotePrefix"
		end

	frozen get_quote_suffix: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.SqlClient.SqlCommandBuilder"
		alias
			"get_QuoteSuffix"
		end

feature -- Element Change

	frozen set_quote_prefix (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.SqlClient.SqlCommandBuilder"
		alias
			"set_QuotePrefix"
		end

	frozen set_data_adapter (value: DATA_SQL_DATA_ADAPTER) is
		external
			"IL signature (System.Data.SqlClient.SqlDataAdapter): System.Void use System.Data.SqlClient.SqlCommandBuilder"
		alias
			"set_DataAdapter"
		end

	frozen set_quote_suffix (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.SqlClient.SqlCommandBuilder"
		alias
			"set_QuoteSuffix"
		end

feature -- Basic Operations

	frozen get_update_command: DATA_SQL_COMMAND is
		external
			"IL signature (): System.Data.SqlClient.SqlCommand use System.Data.SqlClient.SqlCommandBuilder"
		alias
			"GetUpdateCommand"
		end

	frozen derive_parameters (command: DATA_SQL_COMMAND) is
		external
			"IL static signature (System.Data.SqlClient.SqlCommand): System.Void use System.Data.SqlClient.SqlCommandBuilder"
		alias
			"DeriveParameters"
		end

	frozen get_delete_command: DATA_SQL_COMMAND is
		external
			"IL signature (): System.Data.SqlClient.SqlCommand use System.Data.SqlClient.SqlCommandBuilder"
		alias
			"GetDeleteCommand"
		end

	frozen refresh_schema is
		external
			"IL signature (): System.Void use System.Data.SqlClient.SqlCommandBuilder"
		alias
			"RefreshSchema"
		end

	frozen get_insert_command: DATA_SQL_COMMAND is
		external
			"IL signature (): System.Data.SqlClient.SqlCommand use System.Data.SqlClient.SqlCommandBuilder"
		alias
			"GetInsertCommand"
		end

feature {NONE} -- Implementation

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Data.SqlClient.SqlCommandBuilder"
		alias
			"Dispose"
		end

end -- class DATA_SQL_COMMAND_BUILDER
