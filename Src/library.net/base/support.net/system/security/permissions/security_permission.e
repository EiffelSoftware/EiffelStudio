indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Permissions.SecurityPermission"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SECURITY_PERMISSION

inherit
	CODE_ACCESS_PERMISSION
		redefine
			union
		end
	IPERMISSION
	ISECURITY_ENCODABLE
	ISTACK_WALK
	IUNRESTRICTED_PERMISSION

create
	make_security_permission_1,
	make_security_permission

feature {NONE} -- Initialization

	frozen make_security_permission_1 (flag: SECURITY_PERMISSION_FLAG) is
		external
			"IL creator signature (System.Security.Permissions.SecurityPermissionFlag) use System.Security.Permissions.SecurityPermission"
		end

	frozen make_security_permission (state: PERMISSION_STATE) is
		external
			"IL creator signature (System.Security.Permissions.PermissionState) use System.Security.Permissions.SecurityPermission"
		end

feature -- Access

	frozen get_flags: SECURITY_PERMISSION_FLAG is
		external
			"IL signature (): System.Security.Permissions.SecurityPermissionFlag use System.Security.Permissions.SecurityPermission"
		alias
			"get_Flags"
		end

feature -- Element Change

	frozen set_flags (value: SECURITY_PERMISSION_FLAG) is
		external
			"IL signature (System.Security.Permissions.SecurityPermissionFlag): System.Void use System.Security.Permissions.SecurityPermission"
		alias
			"set_Flags"
		end

feature -- Basic Operations

	intersect (target: IPERMISSION): IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.Permissions.SecurityPermission"
		alias
			"Intersect"
		end

	from_xml (esd: SECURITY_ELEMENT) is
		external
			"IL signature (System.Security.SecurityElement): System.Void use System.Security.Permissions.SecurityPermission"
		alias
			"FromXml"
		end

	to_xml: SECURITY_ELEMENT is
		external
			"IL signature (): System.Security.SecurityElement use System.Security.Permissions.SecurityPermission"
		alias
			"ToXml"
		end

	frozen is_unrestricted: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.Permissions.SecurityPermission"
		alias
			"IsUnrestricted"
		end

	copy_: IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.SecurityPermission"
		alias
			"Copy"
		end

	is_subset_of (target: IPERMISSION): BOOLEAN is
		external
			"IL signature (System.Security.IPermission): System.Boolean use System.Security.Permissions.SecurityPermission"
		alias
			"IsSubsetOf"
		end

	union (target: IPERMISSION): IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.Permissions.SecurityPermission"
		alias
			"Union"
		end

end -- class SECURITY_PERMISSION
