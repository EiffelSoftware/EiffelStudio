indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Permissions.PermissionSetAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	PERMISSION_SET_ATTRIBUTE

inherit
	CODE_ACCESS_SECURITY_ATTRIBUTE

create
	make_permission_set_attribute

feature {NONE} -- Initialization

	frozen make_permission_set_attribute (action: SECURITY_ACTION) is
		external
			"IL creator signature (System.Security.Permissions.SecurityAction) use System.Security.Permissions.PermissionSetAttribute"
		end

feature -- Access

	frozen get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Permissions.PermissionSetAttribute"
		alias
			"get_Name"
		end

	frozen get_unicode_encoded: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.Permissions.PermissionSetAttribute"
		alias
			"get_UnicodeEncoded"
		end

	frozen get_file: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Permissions.PermissionSetAttribute"
		alias
			"get_File"
		end

	frozen get_xml: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Permissions.PermissionSetAttribute"
		alias
			"get_XML"
		end

feature -- Element Change

	frozen set_unicode_encoded (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Security.Permissions.PermissionSetAttribute"
		alias
			"set_UnicodeEncoded"
		end

	frozen set_file (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Permissions.PermissionSetAttribute"
		alias
			"set_File"
		end

	frozen set_xml (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Permissions.PermissionSetAttribute"
		alias
			"set_XML"
		end

	frozen set_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Permissions.PermissionSetAttribute"
		alias
			"set_Name"
		end

feature -- Basic Operations

	create_permission: IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.PermissionSetAttribute"
		alias
			"CreatePermission"
		end

	frozen create_permission_set: PERMISSION_SET is
		external
			"IL signature (): System.Security.PermissionSet use System.Security.Permissions.PermissionSetAttribute"
		alias
			"CreatePermissionSet"
		end

end -- class PERMISSION_SET_ATTRIBUTE
