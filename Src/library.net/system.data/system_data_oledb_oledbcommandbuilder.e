indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.OleDb.OleDbCommandBuilder"

frozen external class
	SYSTEM_DATA_OLEDB_OLEDBCOMMANDBUILDER

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_COMPONENTMODEL_COMPONENT
		redefine
			dispose_boolean
		end
	SYSTEM_IDISPOSABLE

create
	make_oledbcommandbuilder,
	make_oledbcommandbuilder_1

feature {NONE} -- Initialization

	frozen make_oledbcommandbuilder is
		external
			"IL creator use System.Data.OleDb.OleDbCommandBuilder"
		end

	frozen make_oledbcommandbuilder_1 (adapter: SYSTEM_DATA_OLEDB_OLEDBDATAADAPTER) is
		external
			"IL creator signature (System.Data.OleDb.OleDbDataAdapter) use System.Data.OleDb.OleDbCommandBuilder"
		end

feature -- Access

	frozen get_data_adapter: SYSTEM_DATA_OLEDB_OLEDBDATAADAPTER is
		external
			"IL signature (): System.Data.OleDb.OleDbDataAdapter use System.Data.OleDb.OleDbCommandBuilder"
		alias
			"get_DataAdapter"
		end

	frozen get_quote_prefix: STRING is
		external
			"IL signature (): System.String use System.Data.OleDb.OleDbCommandBuilder"
		alias
			"get_QuotePrefix"
		end

	frozen get_quote_suffix: STRING is
		external
			"IL signature (): System.String use System.Data.OleDb.OleDbCommandBuilder"
		alias
			"get_QuoteSuffix"
		end

feature -- Element Change

	frozen set_quote_prefix (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.OleDb.OleDbCommandBuilder"
		alias
			"set_QuotePrefix"
		end

	frozen set_data_adapter (value: SYSTEM_DATA_OLEDB_OLEDBDATAADAPTER) is
		external
			"IL signature (System.Data.OleDb.OleDbDataAdapter): System.Void use System.Data.OleDb.OleDbCommandBuilder"
		alias
			"set_DataAdapter"
		end

	frozen set_quote_suffix (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.OleDb.OleDbCommandBuilder"
		alias
			"set_QuoteSuffix"
		end

feature -- Basic Operations

	frozen get_update_command: SYSTEM_DATA_OLEDB_OLEDBCOMMAND is
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

	frozen get_delete_command: SYSTEM_DATA_OLEDB_OLEDBCOMMAND is
		external
			"IL signature (): System.Data.OleDb.OleDbCommand use System.Data.OleDb.OleDbCommandBuilder"
		alias
			"GetDeleteCommand"
		end

	frozen get_insert_command: SYSTEM_DATA_OLEDB_OLEDBCOMMAND is
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

end -- class SYSTEM_DATA_OLEDB_OLEDBCOMMANDBUILDER
