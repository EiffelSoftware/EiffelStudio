indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Permissions.StrongNameIdentityPermission"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	STRONG_NAME_IDENTITY_PERMISSION

inherit
	CODE_ACCESS_PERMISSION
		redefine
			union
		end
	IPERMISSION
	ISECURITY_ENCODABLE
	ISTACK_WALK

create
	make_strong_name_identity_permission,
	make_strong_name_identity_permission_1

feature {NONE} -- Initialization

	frozen make_strong_name_identity_permission (state: PERMISSION_STATE) is
		external
			"IL creator signature (System.Security.Permissions.PermissionState) use System.Security.Permissions.StrongNameIdentityPermission"
		end

	frozen make_strong_name_identity_permission_1 (blob: STRONG_NAME_PUBLIC_KEY_BLOB; name: SYSTEM_STRING; version: VERSION) is
		external
			"IL creator signature (System.Security.Permissions.StrongNamePublicKeyBlob, System.String, System.Version) use System.Security.Permissions.StrongNameIdentityPermission"
		end

feature -- Access

	frozen get_version: VERSION is
		external
			"IL signature (): System.Version use System.Security.Permissions.StrongNameIdentityPermission"
		alias
			"get_Version"
		end

	frozen get_public_key: STRONG_NAME_PUBLIC_KEY_BLOB is
		external
			"IL signature (): System.Security.Permissions.StrongNamePublicKeyBlob use System.Security.Permissions.StrongNameIdentityPermission"
		alias
			"get_PublicKey"
		end

	frozen get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Permissions.StrongNameIdentityPermission"
		alias
			"get_Name"
		end

feature -- Element Change

	frozen set_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Permissions.StrongNameIdentityPermission"
		alias
			"set_Name"
		end

	frozen set_version (value: VERSION) is
		external
			"IL signature (System.Version): System.Void use System.Security.Permissions.StrongNameIdentityPermission"
		alias
			"set_Version"
		end

	frozen set_public_key (value: STRONG_NAME_PUBLIC_KEY_BLOB) is
		external
			"IL signature (System.Security.Permissions.StrongNamePublicKeyBlob): System.Void use System.Security.Permissions.StrongNameIdentityPermission"
		alias
			"set_PublicKey"
		end

feature -- Basic Operations

	from_xml (e: SECURITY_ELEMENT) is
		external
			"IL signature (System.Security.SecurityElement): System.Void use System.Security.Permissions.StrongNameIdentityPermission"
		alias
			"FromXml"
		end

	to_xml: SECURITY_ELEMENT is
		external
			"IL signature (): System.Security.SecurityElement use System.Security.Permissions.StrongNameIdentityPermission"
		alias
			"ToXml"
		end

	intersect (target: IPERMISSION): IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.Permissions.StrongNameIdentityPermission"
		alias
			"Intersect"
		end

	copy_: IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.StrongNameIdentityPermission"
		alias
			"Copy"
		end

	is_subset_of (target: IPERMISSION): BOOLEAN is
		external
			"IL signature (System.Security.IPermission): System.Boolean use System.Security.Permissions.StrongNameIdentityPermission"
		alias
			"IsSubsetOf"
		end

	union (target: IPERMISSION): IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.Permissions.StrongNameIdentityPermission"
		alias
			"Union"
		end

end -- class STRONG_NAME_IDENTITY_PERMISSION
