indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.SqlClient.SqlCommandBuilder"

frozen external class
	SYSTEM_DATA_SQLCLIENT_SQLCOMMANDBUILDER

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_COMPONENTMODEL_COMPONENT
		redefine
			dispose_boolean
		end
	SYSTEM_IDISPOSABLE

create
	make_sqlcommandbuilder_1,
	make_sqlcommandbuilder

feature {NONE} -- Initialization

	frozen make_sqlcommandbuilder_1 (adapter: SYSTEM_DATA_SQLCLIENT_SQLDATAADAPTER) is
		external
			"IL creator signature (System.Data.SqlClient.SqlDataAdapter) use System.Data.SqlClient.SqlCommandBuilder"
		end

	frozen make_sqlcommandbuilder is
		external
			"IL creator use System.Data.SqlClient.SqlCommandBuilder"
		end

feature -- Access

	frozen get_data_adapter: SYSTEM_DATA_SQLCLIENT_SQLDATAADAPTER is
		external
			"IL signature (): System.Data.SqlClient.SqlDataAdapter use System.Data.SqlClient.SqlCommandBuilder"
		alias
			"get_DataAdapter"
		end

	frozen get_quote_prefix: STRING is
		external
			"IL signature (): System.String use System.Data.SqlClient.SqlCommandBuilder"
		alias
			"get_QuotePrefix"
		end

	frozen get_quote_suffix: STRING is
		external
			"IL signature (): System.String use System.Data.SqlClient.SqlCommandBuilder"
		alias
			"get_QuoteSuffix"
		end

feature -- Element Change

	frozen set_quote_prefix (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.SqlClient.SqlCommandBuilder"
		alias
			"set_QuotePrefix"
		end

	frozen set_data_adapter (value: SYSTEM_DATA_SQLCLIENT_SQLDATAADAPTER) is
		external
			"IL signature (System.Data.SqlClient.SqlDataAdapter): System.Void use System.Data.SqlClient.SqlCommandBuilder"
		alias
			"set_DataAdapter"
		end

	frozen set_quote_suffix (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.SqlClient.SqlCommandBuilder"
		alias
			"set_QuoteSuffix"
		end

feature -- Basic Operations

	frozen get_update_command: SYSTEM_DATA_SQLCLIENT_SQLCOMMAND is
		external
			"IL signature (): System.Data.SqlClient.SqlCommand use System.Data.SqlClient.SqlCommandBuilder"
		alias
			"GetUpdateCommand"
		end

	frozen refresh_schema is
		external
			"IL signature (): System.Void use System.Data.SqlClient.SqlCommandBuilder"
		alias
			"RefreshSchema"
		end

	frozen get_delete_command: SYSTEM_DATA_SQLCLIENT_SQLCOMMAND is
		external
			"IL signature (): System.Data.SqlClient.SqlCommand use System.Data.SqlClient.SqlCommandBuilder"
		alias
			"GetDeleteCommand"
		end

	frozen get_insert_command: SYSTEM_DATA_SQLCLIENT_SQLCOMMAND is
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

end -- class SYSTEM_DATA_SQLCLIENT_SQLCOMMANDBUILDER
