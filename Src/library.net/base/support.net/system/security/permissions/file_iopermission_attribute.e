indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Permissions.FileIOPermissionAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	FILE_IOPERMISSION_ATTRIBUTE

inherit
	CODE_ACCESS_SECURITY_ATTRIBUTE

create
	make_file_iopermission_attribute

feature {NONE} -- Initialization

	frozen make_file_iopermission_attribute (action: SECURITY_ACTION) is
		external
			"IL creator signature (System.Security.Permissions.SecurityAction) use System.Security.Permissions.FileIOPermissionAttribute"
		end

feature -- Access

	frozen get_read: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Permissions.FileIOPermissionAttribute"
		alias
			"get_Read"
		end

	frozen get_append: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Permissions.FileIOPermissionAttribute"
		alias
			"get_Append"
		end

	frozen get_path_discovery: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Permissions.FileIOPermissionAttribute"
		alias
			"get_PathDiscovery"
		end

	frozen get_write: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Permissions.FileIOPermissionAttribute"
		alias
			"get_Write"
		end

feature -- Element Change

	frozen set_read (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Permissions.FileIOPermissionAttribute"
		alias
			"set_Read"
		end

	frozen set_write (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Permissions.FileIOPermissionAttribute"
		alias
			"set_Write"
		end

	frozen set_path_discovery (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Permissions.FileIOPermissionAttribute"
		alias
			"set_PathDiscovery"
		end

	frozen set_append (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Permissions.FileIOPermissionAttribute"
		alias
			"set_Append"
		end

	frozen set_all (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Permissions.FileIOPermissionAttribute"
		alias
			"set_All"
		end

feature -- Basic Operations

	create_permission: IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.FileIOPermissionAttribute"
		alias
			"CreatePermission"
		end

end -- class FILE_IOPERMISSION_ATTRIBUTE
