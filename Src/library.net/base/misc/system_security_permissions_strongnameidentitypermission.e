indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.Permissions.StrongNameIdentityPermission"

frozen external class
	SYSTEM_SECURITY_PERMISSIONS_STRONGNAMEIDENTITYPERMISSION

inherit
	SYSTEM_SECURITY_CODEACCESSPERMISSION
		redefine
			union
		end
	SYSTEM_SECURITY_IPERMISSION
	SYSTEM_SECURITY_ISECURITYENCODABLE
	SYSTEM_SECURITY_ISTACKWALK

create
	make_strongnameidentitypermission,
	make_strongnameidentitypermission_1

feature {NONE} -- Initialization

	frozen make_strongnameidentitypermission (state: INTEGER) is
			-- Valid values for `state' are:
			-- Unrestricted = 1
			-- None = 0
		require
			valid_permission_state: state = 1 or state = 0
		external
			"IL creator signature (enum System.Security.Permissions.PermissionState) use System.Security.Permissions.StrongNameIdentityPermission"
		end

	frozen make_strongnameidentitypermission_1 (blob: SYSTEM_SECURITY_PERMISSIONS_STRONGNAMEPUBLICKEYBLOB; name: STRING; version: SYSTEM_VERSION) is
		external
			"IL creator signature (System.Security.Permissions.StrongNamePublicKeyBlob, System.String, System.Version) use System.Security.Permissions.StrongNameIdentityPermission"
		end

feature -- Access

	frozen get_version: SYSTEM_VERSION is
		external
			"IL signature (): System.Version use System.Security.Permissions.StrongNameIdentityPermission"
		alias
			"get_Version"
		end

	frozen get_public_key: SYSTEM_SECURITY_PERMISSIONS_STRONGNAMEPUBLICKEYBLOB is
		external
			"IL signature (): System.Security.Permissions.StrongNamePublicKeyBlob use System.Security.Permissions.StrongNameIdentityPermission"
		alias
			"get_PublicKey"
		end

	frozen get_name: STRING is
		external
			"IL signature (): System.String use System.Security.Permissions.StrongNameIdentityPermission"
		alias
			"get_Name"
		end

feature -- Element Change

	frozen set_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Permissions.StrongNameIdentityPermission"
		alias
			"set_Name"
		end

	frozen set_version (value: SYSTEM_VERSION) is
		external
			"IL signature (System.Version): System.Void use System.Security.Permissions.StrongNameIdentityPermission"
		alias
			"set_Version"
		end

	frozen set_public_key (value: SYSTEM_SECURITY_PERMISSIONS_STRONGNAMEPUBLICKEYBLOB) is
		external
			"IL signature (System.Security.Permissions.StrongNamePublicKeyBlob): System.Void use System.Security.Permissions.StrongNameIdentityPermission"
		alias
			"set_PublicKey"
		end

feature -- Basic Operations

	from_xml (e: SYSTEM_SECURITY_SECURITYELEMENT) is
		external
			"IL signature (System.Security.SecurityElement): System.Void use System.Security.Permissions.StrongNameIdentityPermission"
		alias
			"FromXml"
		end

	to_xml: SYSTEM_SECURITY_SECURITYELEMENT is
		external
			"IL signature (): System.Security.SecurityElement use System.Security.Permissions.StrongNameIdentityPermission"
		alias
			"ToXml"
		end

	intersect (target: SYSTEM_SECURITY_IPERMISSION): SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.Permissions.StrongNameIdentityPermission"
		alias
			"Intersect"
		end

	is_subset_of (target: SYSTEM_SECURITY_IPERMISSION): BOOLEAN is
		external
			"IL signature (System.Security.IPermission): System.Boolean use System.Security.Permissions.StrongNameIdentityPermission"
		alias
			"IsSubsetOf"
		end

	union (target: SYSTEM_SECURITY_IPERMISSION): SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.Permissions.StrongNameIdentityPermission"
		alias
			"Union"
		end

	copy: SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.StrongNameIdentityPermission"
		alias
			"Copy"
		end

end -- class SYSTEM_SECURITY_PERMISSIONS_STRONGNAMEIDENTITYPERMISSION
