indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.Permissions.PermissionSetAttribute"

frozen external class
	SYSTEM_SECURITY_PERMISSIONS_PERMISSIONSETATTRIBUTE

inherit
	SYSTEM_SECURITY_PERMISSIONS_CODEACCESSSECURITYATTRIBUTE

create
	make_permissionsetattribute

feature {NONE} -- Initialization

	frozen make_permissionsetattribute (action: INTEGER) is
			-- Valid values for `action' are:
			-- Demand = 2
			-- Assert = 3
			-- Deny = 4
			-- PermitOnly = 5
			-- LinkDemand = 6
			-- InheritanceDemand = 7
			-- RequestMinimum = 8
			-- RequestOptional = 9
			-- RequestRefuse = 10
		require
			valid_security_action: action = 2 or action = 3 or action = 4 or action = 5 or action = 6 or action = 7 or action = 8 or action = 9 or action = 10
		external
			"IL creator signature (enum System.Security.Permissions.SecurityAction) use System.Security.Permissions.PermissionSetAttribute"
		end

feature -- Access

	frozen get_name: STRING is
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

	frozen get_file: STRING is
		external
			"IL signature (): System.String use System.Security.Permissions.PermissionSetAttribute"
		alias
			"get_File"
		end

	frozen get_xml: STRING is
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

	frozen set_file (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Permissions.PermissionSetAttribute"
		alias
			"set_File"
		end

	frozen set_xml (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Permissions.PermissionSetAttribute"
		alias
			"set_XML"
		end

	frozen set_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Permissions.PermissionSetAttribute"
		alias
			"set_Name"
		end

feature -- Basic Operations

	create_permission: SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.PermissionSetAttribute"
		alias
			"CreatePermission"
		end

	frozen create_permission_set: SYSTEM_SECURITY_PERMISSIONSET is
		external
			"IL signature (): System.Security.PermissionSet use System.Security.Permissions.PermissionSetAttribute"
		alias
			"CreatePermissionSet"
		end

end -- class SYSTEM_SECURITY_PERMISSIONS_PERMISSIONSETATTRIBUTE
