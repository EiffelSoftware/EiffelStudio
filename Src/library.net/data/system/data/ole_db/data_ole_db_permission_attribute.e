indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.OleDb.OleDbPermissionAttribute"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	DATA_OLE_DB_PERMISSION_ATTRIBUTE

inherit
	DATA_DBDATA_PERMISSION_ATTRIBUTE

create
	make_data_ole_db_permission_attribute

feature {NONE} -- Initialization

	frozen make_data_ole_db_permission_attribute (action: SECURITY_ACTION) is
		external
			"IL creator signature (System.Security.Permissions.SecurityAction) use System.Data.OleDb.OleDbPermissionAttribute"
		end

feature -- Access

	frozen get_provider: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.OleDb.OleDbPermissionAttribute"
		alias
			"get_Provider"
		end

feature -- Element Change

	frozen set_provider (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.OleDb.OleDbPermissionAttribute"
		alias
			"set_Provider"
		end

feature -- Basic Operations

	create_permission: IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Data.OleDb.OleDbPermissionAttribute"
		alias
			"CreatePermission"
		end

end -- class DATA_OLE_DB_PERMISSION_ATTRIBUTE
