indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Permissions.FileDialogPermission"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	FILE_DIALOG_PERMISSION

inherit
	CODE_ACCESS_PERMISSION
		redefine
			union,
			to_string
		end
	IPERMISSION
	ISECURITY_ENCODABLE
	ISTACK_WALK
	IUNRESTRICTED_PERMISSION

create
	make_file_dialog_permission,
	make_file_dialog_permission_1

feature {NONE} -- Initialization

	frozen make_file_dialog_permission (state: PERMISSION_STATE) is
		external
			"IL creator signature (System.Security.Permissions.PermissionState) use System.Security.Permissions.FileDialogPermission"
		end

	frozen make_file_dialog_permission_1 (access: FILE_DIALOG_PERMISSION_ACCESS) is
		external
			"IL creator signature (System.Security.Permissions.FileDialogPermissionAccess) use System.Security.Permissions.FileDialogPermission"
		end

feature -- Access

	frozen get_access: FILE_DIALOG_PERMISSION_ACCESS is
		external
			"IL signature (): System.Security.Permissions.FileDialogPermissionAccess use System.Security.Permissions.FileDialogPermission"
		alias
			"get_Access"
		end

feature -- Element Change

	frozen set_access (value: FILE_DIALOG_PERMISSION_ACCESS) is
		external
			"IL signature (System.Security.Permissions.FileDialogPermissionAccess): System.Void use System.Security.Permissions.FileDialogPermission"
		alias
			"set_Access"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Permissions.FileDialogPermission"
		alias
			"ToString"
		end

	intersect (target: IPERMISSION): IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.Permissions.FileDialogPermission"
		alias
			"Intersect"
		end

	from_xml (esd: SECURITY_ELEMENT) is
		external
			"IL signature (System.Security.SecurityElement): System.Void use System.Security.Permissions.FileDialogPermission"
		alias
			"FromXml"
		end

	union (target: IPERMISSION): IPERMISSION is
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

	to_xml: SECURITY_ELEMENT is
		external
			"IL signature (): System.Security.SecurityElement use System.Security.Permissions.FileDialogPermission"
		alias
			"ToXml"
		end

	copy_: IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.FileDialogPermission"
		alias
			"Copy"
		end

	is_subset_of (target: IPERMISSION): BOOLEAN is
		external
			"IL signature (System.Security.IPermission): System.Boolean use System.Security.Permissions.FileDialogPermission"
		alias
			"IsSubsetOf"
		end

end -- class FILE_DIALOG_PERMISSION
