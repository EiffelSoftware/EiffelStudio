indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.SqlClient.SqlClientPermission"

frozen external class
	SYSTEM_DATA_SQLCLIENT_SQLCLIENTPERMISSION

inherit
	SYSTEM_SECURITY_IPERMISSION
	SYSTEM_SECURITY_PERMISSIONS_IUNRESTRICTEDPERMISSION
	SYSTEM_SECURITY_ISECURITYENCODABLE
	SYSTEM_DATA_COMMON_DBDATAPERMISSION
		redefine
			is_subset_of
		end
	SYSTEM_SECURITY_ISTACKWALK

create
	make_sqlclientpermission_2,
	make_sqlclientpermission_3,
	make_sqlclientpermission,
	make_sqlclientpermission_1

feature {NONE} -- Initialization

	frozen make_sqlclientpermission_2 (state: SYSTEM_SECURITY_PERMISSIONS_PERMISSIONSTATE; allow_blank_password: BOOLEAN) is
		external
			"IL creator signature (System.Security.Permissions.PermissionState, System.Boolean) use System.Data.SqlClient.SqlClientPermission"
		end

	frozen make_sqlclientpermission_3 (connection_string_properties: SYSTEM_COLLECTIONS_HASHTABLE; allow_blank_password: BOOLEAN) is
		external
			"IL creator signature (System.Collections.Hashtable, System.Boolean) use System.Data.SqlClient.SqlClientPermission"
		end

	frozen make_sqlclientpermission is
		external
			"IL creator use System.Data.SqlClient.SqlClientPermission"
		end

	frozen make_sqlclientpermission_1 (state: SYSTEM_SECURITY_PERMISSIONS_PERMISSIONSTATE) is
		external
			"IL creator signature (System.Security.Permissions.PermissionState) use System.Data.SqlClient.SqlClientPermission"
		end

feature -- Basic Operations

	is_subset_of (target: SYSTEM_SECURITY_IPERMISSION): BOOLEAN is
		external
			"IL signature (System.Security.IPermission): System.Boolean use System.Data.SqlClient.SqlClientPermission"
		alias
			"IsSubsetOf"
		end

end -- class SYSTEM_DATA_SQLCLIENT_SQLCLIENTPERMISSION
