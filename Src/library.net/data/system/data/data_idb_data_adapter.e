indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.IDbDataAdapter"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	DATA_IDB_DATA_ADAPTER

inherit
	DATA_IDATA_ADAPTER

feature -- Access

	get_update_command: DATA_IDB_COMMAND is
		external
			"IL deferred signature (): System.Data.IDbCommand use System.Data.IDbDataAdapter"
		alias
			"get_UpdateCommand"
		end

	get_delete_command: DATA_IDB_COMMAND is
		external
			"IL deferred signature (): System.Data.IDbCommand use System.Data.IDbDataAdapter"
		alias
			"get_DeleteCommand"
		end

	get_select_command: DATA_IDB_COMMAND is
		external
			"IL deferred signature (): System.Data.IDbCommand use System.Data.IDbDataAdapter"
		alias
			"get_SelectCommand"
		end

	get_insert_command: DATA_IDB_COMMAND is
		external
			"IL deferred signature (): System.Data.IDbCommand use System.Data.IDbDataAdapter"
		alias
			"get_InsertCommand"
		end

feature -- Element Change

	set_delete_command (value: DATA_IDB_COMMAND) is
		external
			"IL deferred signature (System.Data.IDbCommand): System.Void use System.Data.IDbDataAdapter"
		alias
			"set_DeleteCommand"
		end

	set_update_command (value: DATA_IDB_COMMAND) is
		external
			"IL deferred signature (System.Data.IDbCommand): System.Void use System.Data.IDbDataAdapter"
		alias
			"set_UpdateCommand"
		end

	set_select_command (value: DATA_IDB_COMMAND) is
		external
			"IL deferred signature (System.Data.IDbCommand): System.Void use System.Data.IDbDataAdapter"
		alias
			"set_SelectCommand"
		end

	set_insert_command (value: DATA_IDB_COMMAND) is
		external
			"IL deferred signature (System.Data.IDbCommand): System.Void use System.Data.IDbDataAdapter"
		alias
			"set_InsertCommand"
		end

end -- class DATA_IDB_DATA_ADAPTER
