indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.Common.DBDataPermission"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	DATA_DBDATA_PERMISSION

inherit
	CODE_ACCESS_PERMISSION
		redefine
			union
		end
	IPERMISSION
	ISECURITY_ENCODABLE
	ISTACK_WALK
	IUNRESTRICTED_PERMISSION

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

	intersect (target: IPERMISSION): IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Data.Common.DBDataPermission"
		alias
			"Intersect"
		end

	from_xml (security_element: SECURITY_ELEMENT) is
		external
			"IL signature (System.Security.SecurityElement): System.Void use System.Data.Common.DBDataPermission"
		alias
			"FromXml"
		end

	to_xml: SECURITY_ELEMENT is
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

	copy_: IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Data.Common.DBDataPermission"
		alias
			"Copy"
		end

	is_subset_of (target: IPERMISSION): BOOLEAN is
		external
			"IL signature (System.Security.IPermission): System.Boolean use System.Data.Common.DBDataPermission"
		alias
			"IsSubsetOf"
		end

	union (target: IPERMISSION): IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Data.Common.DBDataPermission"
		alias
			"Union"
		end

end -- class DATA_DBDATA_PERMISSION
