indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Permissions.PrincipalPermission"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	PRINCIPAL_PERMISSION

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	IPERMISSION
	ISECURITY_ENCODABLE
	IUNRESTRICTED_PERMISSION

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (name: SYSTEM_STRING; role: SYSTEM_STRING; is_authenticated: BOOLEAN) is
		external
			"IL creator signature (System.String, System.String, System.Boolean) use System.Security.Permissions.PrincipalPermission"
		end

	frozen make (state: PERMISSION_STATE) is
		external
			"IL creator signature (System.Security.Permissions.PermissionState) use System.Security.Permissions.PrincipalPermission"
		end

	frozen make_1 (name: SYSTEM_STRING; role: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String) use System.Security.Permissions.PrincipalPermission"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Permissions.PrincipalPermission"
		alias
			"ToString"
		end

	frozen intersect (target: IPERMISSION): IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.Permissions.PrincipalPermission"
		alias
			"Intersect"
		end

	frozen from_xml (elem: SECURITY_ELEMENT) is
		external
			"IL signature (System.Security.SecurityElement): System.Void use System.Security.Permissions.PrincipalPermission"
		alias
			"FromXml"
		end

	frozen union (other: IPERMISSION): IPERMISSION is
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

	frozen to_xml: SECURITY_ELEMENT is
		external
			"IL signature (): System.Security.SecurityElement use System.Security.Permissions.PrincipalPermission"
		alias
			"ToXml"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Security.Permissions.PrincipalPermission"
		alias
			"Equals"
		end

	frozen copy_: IPERMISSION is
		external
			"IL signature (): System.Security.IPermission use System.Security.Permissions.PrincipalPermission"
		alias
			"Copy"
		end

	frozen is_subset_of (target: IPERMISSION): BOOLEAN is
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

end -- class PRINCIPAL_PERMISSION
