indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.IDbDataAdapter"

deferred external class
	SYSTEM_DATA_IDBDATAADAPTER

inherit
	SYSTEM_DATA_IDATAADAPTER

feature -- Access

	get_update_command: SYSTEM_DATA_IDBCOMMAND is
		external
			"IL deferred signature (): System.Data.IDbCommand use System.Data.IDbDataAdapter"
		alias
			"get_UpdateCommand"
		end

	get_delete_command: SYSTEM_DATA_IDBCOMMAND is
		external
			"IL deferred signature (): System.Data.IDbCommand use System.Data.IDbDataAdapter"
		alias
			"get_DeleteCommand"
		end

	get_select_command: SYSTEM_DATA_IDBCOMMAND is
		external
			"IL deferred signature (): System.Data.IDbCommand use System.Data.IDbDataAdapter"
		alias
			"get_SelectCommand"
		end

	get_insert_command: SYSTEM_DATA_IDBCOMMAND is
		external
			"IL deferred signature (): System.Data.IDbCommand use System.Data.IDbDataAdapter"
		alias
			"get_InsertCommand"
		end

feature -- Element Change

	set_delete_command (value: SYSTEM_DATA_IDBCOMMAND) is
		external
			"IL deferred signature (System.Data.IDbCommand): System.Void use System.Data.IDbDataAdapter"
		alias
			"set_DeleteCommand"
		end

	set_update_command (value: SYSTEM_DATA_IDBCOMMAND) is
		external
			"IL deferred signature (System.Data.IDbCommand): System.Void use System.Data.IDbDataAdapter"
		alias
			"set_UpdateCommand"
		end

	set_select_command (value: SYSTEM_DATA_IDBCOMMAND) is
		external
			"IL deferred signature (System.Data.IDbCommand): System.Void use System.Data.IDbDataAdapter"
		alias
			"set_SelectCommand"
		end

	set_insert_command (value: SYSTEM_DATA_IDBCOMMAND) is
		external
			"IL deferred signature (System.Data.IDbCommand): System.Void use System.Data.IDbDataAdapter"
		alias
			"set_InsertCommand"
		end

end -- class SYSTEM_DATA_IDBDATAADAPTER
