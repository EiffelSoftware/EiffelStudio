indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.Permissions.FileDialogPermission"

frozen external class
	SYSTEM_SECURITY_PERMISSIONS_FILEDIALOGPERMISSION

inherit
	SYSTEM_SECURITY_CODEACCESSPERMISSION
		redefine
			union,
			to_string
		end
	SYSTEM_SECURITY_IPERMISSION
	SYSTEM_SECURITY_ISECURITYENCODABLE
	SYSTEM_SECURITY_ISTACKWALK
	SYSTEM_SECURITY_PERMISSIONS_IUNRESTRICTEDPERMISSION

create
	make_filedialogpermission_1,
	make_filedialogpermission

feature {NONE} -- Initialization

	frozen make_filedialogpermission_1 (access: SYSTEM_SECURITY_PERMISSIONS_FILEDIALOGPERMISSIONACCESS) is
		external
			"IL creator signature (System.Security.Permissions.FileDialogPermissionAccess) use System.Security.Permissions.FileDialogPermission"
		end

	frozen make_filedialogpermission (state: SYSTEM_SECURITY_PERMISSIONS_PERMISSIONSTATE) is
		external
			"IL creator signature (System.Security.Permissions.PermissionState) use System.Security.Permissions.FileDialogPermission"
		end

feature -- Access

	frozen get_access: SYSTEM_SECURITY_PERMISSIONS_FILEDIALOGPERMISSIONACCESS is
		external
			"IL signature (): System.Security.Permissions.FileDialogPermissionAccess use System.Security.Permissions.FileDialogPermission"
		alias
			"get_Access"
		end

feature -- Element Change

	frozen set_access (value: SYSTEM_SECURITY_PERMISSIONS_FILEDIALOGPERMISSIONACCESS) is
		external
			"IL signature (System.Security.Permissions.FileDialogPermissionAccess): System.Void use System.Security.Permissions.FileDialogPermission"
		alias
			"set_Access"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Security.Permissions.FileDialogPermission"
		alias
			"ToString"
		end

	intersect (target: SYSTEM_SECURITY_IPERMISSION): SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.Permissions.FileDialogPermission"
		alias
			"Intersect"
		end

	from_xml (esd: SYSTEM_SECURITY_SECURITYELEMENT) is
		external
			"IL signature (System.Security.SecurityElement): System.Void use System.Security.Permissions.FileDialogPermission"
		alias
			"FromXml"
		end

	copy: SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.FileDialogPermission"
		alias
			"Copy"
		end

	union (target: SYSTEM_SECURITY_IPERMISSION): SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.Permissions.FileDialogPermission"
		alias
			"Union"
		end

	frozen is_unrestricted: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.Permissions.FileDialogPermission"
		alias
			"IsUnrestricted"
		end

	to_xml: SYSTEM_SECURITY_SECURITYELEMENT is
		external
			"IL signature (): System.Security.SecurityElement use System.Security.Permissions.FileDialogPermission"
		alias
			"ToXml"
		end

	is_subset_of (target: SYSTEM_SECURITY_IPERMISSION): BOOLEAN is
		external
			"IL signature (System.Security.IPermission): System.Boolean use System.Security.Permissions.FileDialogPermission"
		alias
			"IsSubsetOf"
		end

end -- class SYSTEM_SECURITY_PERMISSIONS_FILEDIALOGPERMISSION
