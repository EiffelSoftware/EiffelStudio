indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Permissions.UrlIdentityPermission"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	URL_IDENTITY_PERMISSION

inherit
	CODE_ACCESS_PERMISSION
		redefine
			union
		end
	IPERMISSION
	ISECURITY_ENCODABLE
	ISTACK_WALK

create
	make_url_identity_permission_1,
	make_url_identity_permission

feature {NONE} -- Initialization

	frozen make_url_identity_permission_1 (site: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Security.Permissions.UrlIdentityPermission"
		end

	frozen make_url_identity_permission (state: PERMISSION_STATE) is
		external
			"IL creator signature (System.Security.Permissions.PermissionState) use System.Security.Permissions.UrlIdentityPermission"
		end

feature -- Access

	frozen get_url: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Permissions.UrlIdentityPermission"
		alias
			"get_Url"
		end

feature -- Element Change

	frozen set_url (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.Permissions.UrlIdentityPermission"
		alias
			"set_Url"
		end

feature -- Basic Operations

	from_xml (esd: SECURITY_ELEMENT) is
		external
			"IL signature (System.Security.SecurityElement): System.Void use System.Security.Permissions.UrlIdentityPermission"
		alias
			"FromXml"
		end

	to_xml: SECURITY_ELEMENT is
		external
			"IL signature (): System.Security.SecurityElement use System.Security.Permissions.UrlIdentityPermission"
		alias
			"ToXml"
		end

	intersect (target: IPERMISSION): IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.Permissions.UrlIdentityPermission"
		alias
			"Intersect"
		end

	copy_: IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.UrlIdentityPermission"
		alias
			"Copy"
		end

	is_subset_of (target: IPERMISSION): BOOLEAN is
		external
			"IL signature (System.Security.IPermission): System.Boolean use System.Security.Permissions.UrlIdentityPermission"
		alias
			"IsSubsetOf"
		end

	union (target: IPERMISSION): IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.Permissions.UrlIdentityPermission"
		alias
			"Union"
		end

end -- class URL_IDENTITY_PERMISSION
