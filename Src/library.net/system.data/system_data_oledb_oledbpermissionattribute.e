indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.OleDb.OleDbPermissionAttribute"

frozen external class
	SYSTEM_DATA_OLEDB_OLEDBPERMISSIONATTRIBUTE

inherit
	SYSTEM_DATA_COMMON_DBDATAPERMISSIONATTRIBUTE

create
	make_oledbpermissionattribute

feature {NONE} -- Initialization

	frozen make_oledbpermissionattribute (action: SYSTEM_SECURITY_PERMISSIONS_SECURITYACTION) is
		external
			"IL creator signature (System.Security.Permissions.SecurityAction) use System.Data.OleDb.OleDbPermissionAttribute"
		end

feature -- Access

	frozen get_provider: STRING is
		external
			"IL signature (): System.String use System.Data.OleDb.OleDbPermissionAttribute"
		alias
			"get_Provider"
		end

feature -- Element Change

	frozen set_provider (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.OleDb.OleDbPermissionAttribute"
		alias
			"set_Provider"
		end

feature -- Basic Operations

	create_permission: SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Data.OleDb.OleDbPermissionAttribute"
		alias
			"CreatePermission"
		end

end -- class SYSTEM_DATA_OLEDB_OLEDBPERMISSIONATTRIBUTE
