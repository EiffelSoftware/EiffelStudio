indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.OleDb.OleDbPermission"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	DATA_OLE_DB_PERMISSION

inherit
	DATA_DBDATA_PERMISSION
		redefine
			from_xml,
			to_xml,
			is_subset_of,
			union,
			intersect,
			copy_
		end
	IPERMISSION
	ISECURITY_ENCODABLE
	ISTACK_WALK
	IUNRESTRICTED_PERMISSION

create
	make_data_ole_db_permission,
	make_data_ole_db_permission_1,
	make_data_ole_db_permission_2

feature {NONE} -- Initialization

	frozen make_data_ole_db_permission is
		external
			"IL creator use System.Data.OleDb.OleDbPermission"
		end

	frozen make_data_ole_db_permission_1 (state: PERMISSION_STATE) is
		external
			"IL creator signature (System.Security.Permissions.PermissionState) use System.Data.OleDb.OleDbPermission"
		end

	frozen make_data_ole_db_permission_2 (state: PERMISSION_STATE; allow_blank_password: BOOLEAN) is
		external
			"IL creator signature (System.Security.Permissions.PermissionState, System.Boolean) use System.Data.OleDb.OleDbPermission"
		end

feature -- Access

	frozen get_provider: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.OleDb.OleDbPermission"
		alias
			"get_Provider"
		end

feature -- Element Change

	frozen set_provider (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.OleDb.OleDbPermission"
		alias
			"set_Provider"
		end

feature -- Basic Operations

	from_xml (security_element: SECURITY_ELEMENT) is
		external
			"IL signature (System.Security.SecurityElement): System.Void use System.Data.OleDb.OleDbPermission"
		alias
			"FromXml"
		end

	to_xml: SECURITY_ELEMENT is
		external
			"IL signature (): System.Security.SecurityElement use System.Data.OleDb.OleDbPermission"
		alias
			"ToXml"
		end

	intersect (target: IPERMISSION): IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Data.OleDb.OleDbPermission"
		alias
			"Intersect"
		end

	copy_: IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Data.OleDb.OleDbPermission"
		alias
			"Copy"
		end

	is_subset_of (target: IPERMISSION): BOOLEAN is
		external
			"IL signature (System.Security.IPermission): System.Boolean use System.Data.OleDb.OleDbPermission"
		alias
			"IsSubsetOf"
		end

	union (target: IPERMISSION): IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Data.OleDb.OleDbPermission"
		alias
			"Union"
		end

end -- class DATA_OLE_DB_PERMISSION
