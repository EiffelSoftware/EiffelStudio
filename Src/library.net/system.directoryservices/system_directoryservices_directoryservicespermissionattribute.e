indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.DirectoryServices.DirectoryServicesPermissionAttribute"

external class
	SYSTEM_DIRECTORYSERVICES_DIRECTORYSERVICESPERMISSIONATTRIBUTE

inherit
	SYSTEM_SECURITY_PERMISSIONS_CODEACCESSSECURITYATTRIBUTE

create
	make_directoryservicespermissionattribute

feature {NONE} -- Initialization

	frozen make_directoryservicespermissionattribute (action: SYSTEM_SECURITY_PERMISSIONS_SECURITYACTION) is
		external
			"IL creator signature (System.Security.Permissions.SecurityAction) use System.DirectoryServices.DirectoryServicesPermissionAttribute"
		end

feature -- Access

	frozen get_path: STRING is
		external
			"IL signature (): System.String use System.DirectoryServices.DirectoryServicesPermissionAttribute"
		alias
			"get_Path"
		end

	frozen get_permission_access: SYSTEM_DIRECTORYSERVICES_DIRECTORYSERVICESPERMISSIONACCESS is
		external
			"IL signature (): System.DirectoryServices.DirectoryServicesPermissionAccess use System.DirectoryServices.DirectoryServicesPermissionAttribute"
		alias
			"get_PermissionAccess"
		end

feature -- Element Change

	frozen set_permission_access (value: SYSTEM_DIRECTORYSERVICES_DIRECTORYSERVICESPERMISSIONACCESS) is
		external
			"IL signature (System.DirectoryServices.DirectoryServicesPermissionAccess): System.Void use System.DirectoryServices.DirectoryServicesPermissionAttribute"
		alias
			"set_PermissionAccess"
		end

	frozen set_path (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.DirectoryServices.DirectoryServicesPermissionAttribute"
		alias
			"set_Path"
		end

feature -- Basic Operations

	create_permission: SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.DirectoryServices.DirectoryServicesPermissionAttribute"
		alias
			"CreatePermission"
		end

end -- class SYSTEM_DIRECTORYSERVICES_DIRECTORYSERVICESPERMISSIONATTRIBUTE
