indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.CodeAccessPermission"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	CODE_ACCESS_PERMISSION

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
	ISTACK_WALK

feature -- Basic Operations

	copy_: IPERMISSION is
		external
			"IL deferred signature (): System.Security.IPermission use System.Security.CodeAccessPermission"
		alias
			"Copy"
		end

	union (other: IPERMISSION): IPERMISSION is
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

	is_subset_of (target: IPERMISSION): BOOLEAN is
		external
			"IL deferred signature (System.Security.IPermission): System.Boolean use System.Security.CodeAccessPermission"
		alias
			"IsSubsetOf"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Security.CodeAccessPermission"
		alias
			"Equals"
		end

	frozen deny is
		external
			"IL signature (): System.Void use System.Security.CodeAccessPermission"
		alias
			"Deny"
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

	intersect (target: IPERMISSION): IPERMISSION is
		external
			"IL deferred signature (System.Security.IPermission): System.Security.IPermission use System.Security.CodeAccessPermission"
		alias
			"Intersect"
		end

	from_xml (elem: SECURITY_ELEMENT) is
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

	to_xml: SECURITY_ELEMENT is
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

	to_string: SYSTEM_STRING is
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

end -- class CODE_ACCESS_PERMISSION
