indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.SqlClient.SqlClientPermissionAttribute"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	DATA_SQL_CLIENT_PERMISSION_ATTRIBUTE

inherit
	DATA_DBDATA_PERMISSION_ATTRIBUTE

create
	make_data_sql_client_permission_attribute

feature {NONE} -- Initialization

	frozen make_data_sql_client_permission_attribute (action: SECURITY_ACTION) is
		external
			"IL creator signature (System.Security.Permissions.SecurityAction) use System.Data.SqlClient.SqlClientPermissionAttribute"
		end

feature -- Basic Operations

	create_permission: IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Data.SqlClient.SqlClientPermissionAttribute"
		alias
			"CreatePermission"
		end

end -- class DATA_SQL_CLIENT_PERMISSION_ATTRIBUTE
