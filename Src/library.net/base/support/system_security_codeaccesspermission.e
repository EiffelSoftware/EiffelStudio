indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.CodeAccessPermission"

deferred external class
	SYSTEM_SECURITY_CODEACCESSPERMISSION

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
	SYSTEM_SECURITY_ISTACKWALK

feature -- Basic Operations

	union (other: SYSTEM_SECURITY_IPERMISSION): SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (System.Security.IPermission): System.Security.IPermission use System.Security.CodeAccessPermission"
		alias
			"Union"
		end

	frozen revert_all is
		external
			"IL static signature (): System.Void use System.Security.CodeAccessPermission"
		alias
			"RevertAll"
		end

	is_subset_of (target: SYSTEM_SECURITY_IPERMISSION): BOOLEAN is
		external
			"IL deferred signature (System.Security.IPermission): System.Boolean use System.Security.CodeAccessPermission"
		alias
			"IsSubsetOf"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Security.CodeAccessPermission"
		alias
			"Equals"
		end

	copy: SYSTEM_SECURITY_IPERMISSION is
		external
			"IL deferred signature (): System.Security.IPermission use System.Security.CodeAccessPermission"
		alias
			"Copy"
		end

	frozen revert_permit_only is
		external
			"IL static signature (): System.Void use System.Security.CodeAccessPermission"
		alias
			"RevertPermitOnly"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Security.CodeAccessPermission"
		alias
			"GetHashCode"
		end

	frozen deny is
		external
			"IL signature (): System.Void use System.Security.CodeAccessPermission"
		alias
			"Deny"
		end

	intersect (target: SYSTEM_SECURITY_IPERMISSION): SYSTEM_SECURITY_IPERMISSION is
		external
			"IL deferred signature (System.Security.IPermission): System.Security.IPermission use System.Security.CodeAccessPermission"
		alias
			"Intersect"
		end

	from_xml (elem: SYSTEM_SECURITY_SECURITYELEMENT) is
		external
			"IL deferred signature (System.Security.SecurityElement): System.Void use System.Security.CodeAccessPermission"
		alias
			"FromXml"
		end

	frozen revert_deny is
		external
			"IL static signature (): System.Void use System.Security.CodeAccessPermission"
		alias
			"RevertDeny"
		end

	frozen permit_only is
		external
			"IL signature (): System.Void use System.Security.CodeAccessPermission"
		alias
			"PermitOnly"
		end

	frozen revert_assert is
		external
			"IL static signature (): System.Void use System.Security.CodeAccessPermission"
		alias
			"RevertAssert"
		end

	to_xml: SYSTEM_SECURITY_SECURITYELEMENT is
		external
			"IL deferred signature (): System.Security.SecurityElement use System.Security.CodeAccessPermission"
		alias
			"ToXml"
		end

	frozen assert is
		external
			"IL signature (): System.Void use System.Security.CodeAccessPermission"
		alias
			"Assert"
		end

	frozen demand is
		external
			"IL signature (): System.Void use System.Security.CodeAccessPermission"
		alias
			"Demand"
		end

	frozen demand_immediate is
		external
			"IL signature (): System.Void use System.Security.CodeAccessPermission"
		alias
			"DemandImmediate"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Security.CodeAccessPermission"
		alias
			"ToString"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Security.CodeAccessPermission"
		alias
			"Finalize"
		end

end -- class SYSTEM_SECURITY_CODEACCESSPERMISSION
