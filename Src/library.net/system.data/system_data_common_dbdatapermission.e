indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.Common.DBDataPermission"

deferred external class
	SYSTEM_DATA_COMMON_DBDATAPERMISSION

inherit
	SYSTEM_SECURITY_IPERMISSION
	SYSTEM_SECURITY_PERMISSIONS_IUNRESTRICTEDPERMISSION
	SYSTEM_SECURITY_ISECURITYENCODABLE
	SYSTEM_SECURITY_CODEACCESSPERMISSION
		redefine
			union
		end
	SYSTEM_SECURITY_ISTACKWALK

feature -- Access

	frozen get_allow_blank_password: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.Common.DBDataPermission"
		alias
			"get_AllowBlankPassword"
		end

feature -- Element Change

	frozen set_allow_blank_password (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Data.Common.DBDataPermission"
		alias
			"set_AllowBlankPassword"
		end

feature -- Basic Operations

	intersect (target: SYSTEM_SECURITY_IPERMISSION): SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Data.Common.DBDataPermission"
		alias
			"Intersect"
		end

	from_xml (security_element: SYSTEM_SECURITY_SECURITYELEMENT) is
		external
			"IL signature (System.Security.SecurityElement): System.Void use System.Data.Common.DBDataPermission"
		alias
			"FromXml"
		end

	to_xml: SYSTEM_SECURITY_SECURITYELEMENT is
		external
			"IL signature (): System.Security.SecurityElement use System.Data.Common.DBDataPermission"
		alias
			"ToXml"
		end

	frozen is_unrestricted: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.Common.DBDataPermission"
		alias
			"IsUnrestricted"
		end

	is_subset_of (target: SYSTEM_SECURITY_IPERMISSION): BOOLEAN is
		external
			"IL signature (System.Security.IPermission): System.Boolean use System.Data.Common.DBDataPermission"
		alias
			"IsSubsetOf"
		end

	union (target: SYSTEM_SECURITY_IPERMISSION): SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Data.Common.DBDataPermission"
		alias
			"Union"
		end

	copy: SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Data.Common.DBDataPermission"
		alias
			"Copy"
		end

end -- class SYSTEM_DATA_COMMON_DBDATAPERMISSION
