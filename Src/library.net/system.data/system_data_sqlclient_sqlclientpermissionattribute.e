indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.SqlClient.SqlClientPermissionAttribute"

frozen external class
	SYSTEM_DATA_SQLCLIENT_SQLCLIENTPERMISSIONATTRIBUTE

inherit
	SYSTEM_DATA_COMMON_DBDATAPERMISSIONATTRIBUTE

create
	make_sqlclientpermissionattribute

feature {NONE} -- Initialization

	frozen make_sqlclientpermissionattribute (action: SYSTEM_SECURITY_PERMISSIONS_SECURITYACTION) is
		external
			"IL creator signature (System.Security.Permissions.SecurityAction) use System.Data.SqlClient.SqlClientPermissionAttribute"
		end

feature -- Basic Operations

	create_permission: SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Data.SqlClient.SqlClientPermissionAttribute"
		alias
			"CreatePermission"
		end

end -- class SYSTEM_DATA_SQLCLIENT_SQLCLIENTPERMISSIONATTRIBUTE
