indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Permissions.ReflectionPermission"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	REFLECTION_PERMISSION

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
	make_reflection_permission_1,
	make_reflection_permission

feature {NONE} -- Initialization

	frozen make_reflection_permission_1 (flag: REFLECTION_PERMISSION_FLAG) is
		external
			"IL creator signature (System.Security.Permissions.ReflectionPermissionFlag) use System.Security.Permissions.ReflectionPermission"
		end

	frozen make_reflection_permission (state: PERMISSION_STATE) is
		external
			"IL creator signature (System.Security.Permissions.PermissionState) use System.Security.Permissions.ReflectionPermission"
		end

feature -- Access

	frozen get_flags: REFLECTION_PERMISSION_FLAG is
		external
			"IL signature (): System.Security.Permissions.ReflectionPermissionFlag use System.Security.Permissions.ReflectionPermission"
		alias
			"get_Flags"
		end

feature -- Element Change

	frozen set_flags (value: REFLECTION_PERMISSION_FLAG) is
		external
			"IL signature (System.Security.Permissions.ReflectionPermissionFlag): System.Void use System.Security.Permissions.ReflectionPermission"
		alias
			"set_Flags"
		end

feature -- Basic Operations

	intersect (target: IPERMISSION): IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.Permissions.ReflectionPermission"
		alias
			"Intersect"
		end

	from_xml (esd: SECURITY_ELEMENT) is
		external
			"IL signature (System.Security.SecurityElement): System.Void use System.Security.Permissions.ReflectionPermission"
		alias
			"FromXml"
		end

	to_xml: SECURITY_ELEMENT is
		external
			"IL signature (): System.Security.SecurityElement use System.Security.Permissions.ReflectionPermission"
		alias
			"ToXml"
		end

	frozen is_unrestricted: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.Permissions.ReflectionPermission"
		alias
			"IsUnrestricted"
		end

	copy_: IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.ReflectionPermission"
		alias
			"Copy"
		end

	is_subset_of (target: IPERMISSION): BOOLEAN is
		external
			"IL signature (System.Security.IPermission): System.Boolean use System.Security.Permissions.ReflectionPermission"
		alias
			"IsSubsetOf"
		end

	union (other: IPERMISSION): IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.Permissions.ReflectionPermission"
		alias
			"Union"
		end

end -- class REFLECTION_PERMISSION
