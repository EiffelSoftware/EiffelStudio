indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.Permissions.PrincipalPermission"

frozen external class
	SYSTEM_SECURITY_PERMISSIONS_PRINCIPALPERMISSION

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_SECURITY_IPERMISSION
	SYSTEM_SECURITY_ISECURITYENCODABLE
	SYSTEM_SECURITY_PERMISSIONS_IUNRESTRICTEDPERMISSION

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (name: STRING; role: STRING; is_authenticated: BOOLEAN) is
		external
			"IL creator signature (System.String, System.String, System.Boolean) use System.Security.Permissions.PrincipalPermission"
		end

	frozen make (state: INTEGER) is
			-- Valid values for `state' are:
			-- Unrestricted = 1
			-- None = 0
		require
			valid_permission_state: state = 1 or state = 0
		external
			"IL creator signature (enum System.Security.Permissions.PermissionState) use System.Security.Permissions.PrincipalPermission"
		end

	frozen make_1 (name: STRING; role: STRING) is
		external
			"IL creator signature (System.String, System.String) use System.Security.Permissions.PrincipalPermission"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Security.Permissions.PrincipalPermission"
		alias
			"ToString"
		end

	frozen intersect (target: SYSTEM_SECURITY_IPERMISSION): SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.Permissions.PrincipalPermission"
		alias
			"Intersect"
		end

	frozen from_xml (elem: SYSTEM_SECURITY_SECURITYELEMENT) is
		external
			"IL signature (System.Security.SecurityElement): System.Void use System.Security.Permissions.PrincipalPermission"
		alias
			"FromXml"
		end

	frozen copy: SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.PrincipalPermission"
		alias
			"Copy"
		end

	frozen union (other: SYSTEM_SECURITY_IPERMISSION): SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.Permissions.PrincipalPermission"
		alias
			"Union"
		end

	frozen is_unrestricted: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.Permissions.PrincipalPermission"
		alias
			"IsUnrestricted"
		end

	frozen to_xml: SYSTEM_SECURITY_SECURITYELEMENT is
		external
			"IL signature (): System.Security.SecurityElement use System.Security.Permissions.PrincipalPermission"
		alias
			"ToXml"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Security.Permissions.PrincipalPermission"
		alias
			"Equals"
		end

	frozen is_subset_of (target: SYSTEM_SECURITY_IPERMISSION): BOOLEAN is
		external
			"IL signature (System.Security.IPermission): System.Boolean use System.Security.Permissions.PrincipalPermission"
		alias
			"IsSubsetOf"
		end

	frozen demand is
		external
			"IL signature (): System.Void use System.Security.Permissions.PrincipalPermission"
		alias
			"Demand"
		end

	frozen demand_immediate is
		external
			"IL signature (): System.Void use System.Security.Permissions.PrincipalPermission"
		alias
			"DemandImmediate"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Security.Permissions.PrincipalPermission"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Security.Permissions.PrincipalPermission"
		alias
			"Finalize"
		end

end -- class SYSTEM_SECURITY_PERMISSIONS_PRINCIPALPERMISSION
