indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.OleDb.OleDbPermission"

frozen external class
	SYSTEM_DATA_OLEDB_OLEDBPERMISSION

inherit
	SYSTEM_SECURITY_IPERMISSION
	SYSTEM_SECURITY_PERMISSIONS_IUNRESTRICTEDPERMISSION
	SYSTEM_SECURITY_ISECURITYENCODABLE
	SYSTEM_DATA_COMMON_DBDATAPERMISSION
		redefine
			from_xml,
			to_xml,
			is_subset_of,
			union,
			intersect,
			copy
		end
	SYSTEM_SECURITY_ISTACKWALK

create
	make_oledbpermission_3,
	make_oledbpermission_2,
	make_oledbpermission,
	make_oledbpermission_1

feature {NONE} -- Initialization

	frozen make_oledbpermission_3 (connection_string_properties: SYSTEM_COLLECTIONS_HASHTABLE; allow_blank_password: BOOLEAN) is
		external
			"IL creator signature (System.Collections.Hashtable, System.Boolean) use System.Data.OleDb.OleDbPermission"
		end

	frozen make_oledbpermission_2 (state: SYSTEM_SECURITY_PERMISSIONS_PERMISSIONSTATE; allow_blank_password: BOOLEAN) is
		external
			"IL creator signature (System.Security.Permissions.PermissionState, System.Boolean) use System.Data.OleDb.OleDbPermission"
		end

	frozen make_oledbpermission is
		external
			"IL creator use System.Data.OleDb.OleDbPermission"
		end

	frozen make_oledbpermission_1 (state: SYSTEM_SECURITY_PERMISSIONS_PERMISSIONSTATE) is
		external
			"IL creator signature (System.Security.Permissions.PermissionState) use System.Data.OleDb.OleDbPermission"
		end

feature -- Access

	frozen get_provider: STRING is
		external
			"IL signature (): System.String use System.Data.OleDb.OleDbPermission"
		alias
			"get_Provider"
		end

feature -- Element Change

	frozen set_provider (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.OleDb.OleDbPermission"
		alias
			"set_Provider"
		end

feature -- Basic Operations

	from_xml (security_element: SYSTEM_SECURITY_SECURITYELEMENT) is
		external
			"IL signature (System.Security.SecurityElement): System.Void use System.Data.OleDb.OleDbPermission"
		alias
			"FromXml"
		end

	to_xml: SYSTEM_SECURITY_SECURITYELEMENT is
		external
			"IL signature (): System.Security.SecurityElement use System.Data.OleDb.OleDbPermission"
		alias
			"ToXml"
		end

	intersect (target: SYSTEM_SECURITY_IPERMISSION): SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Data.OleDb.OleDbPermission"
		alias
			"Intersect"
		end

	is_subset_of (target: SYSTEM_SECURITY_IPERMISSION): BOOLEAN is
		external
			"IL signature (System.Security.IPermission): System.Boolean use System.Data.OleDb.OleDbPermission"
		alias
			"IsSubsetOf"
		end

	union (target: SYSTEM_SECURITY_IPERMISSION): SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Data.OleDb.OleDbPermission"
		alias
			"Union"
		end

	copy: SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Data.OleDb.OleDbPermission"
		alias
			"Copy"
		end

end -- class SYSTEM_DATA_OLEDB_OLEDBPERMISSION
