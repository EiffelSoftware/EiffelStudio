indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.SqlClient.SqlClientPermission"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	DATA_SQL_CLIENT_PERMISSION

inherit
	DATA_DBDATA_PERMISSION
	IPERMISSION
	ISECURITY_ENCODABLE
	ISTACK_WALK
	IUNRESTRICTED_PERMISSION

create
	make_data_sql_client_permission_1,
	make_data_sql_client_permission_2,
	make_data_sql_client_permission

feature {NONE} -- Initialization

	frozen make_data_sql_client_permission_1 (state: PERMISSION_STATE) is
		external
			"IL creator signature (System.Security.Permissions.PermissionState) use System.Data.SqlClient.SqlClientPermission"
		end

	frozen make_data_sql_client_permission_2 (state: PERMISSION_STATE; allow_blank_password: BOOLEAN) is
		external
			"IL creator signature (System.Security.Permissions.PermissionState, System.Boolean) use System.Data.SqlClient.SqlClientPermission"
		end

	frozen make_data_sql_client_permission is
		external
			"IL creator use System.Data.SqlClient.SqlClientPermission"
		end

end -- class DATA_SQL_CLIENT_PERMISSION
