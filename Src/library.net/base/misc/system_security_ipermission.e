indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.IPermission"

deferred external class
	SYSTEM_SECURITY_IPERMISSION

inherit
	SYSTEM_SECURITY_ISECURITYENCODABLE

feature -- Basic Operations

	intersect (target: SYSTEM_SECURITY_IPERMISSION): SYSTEM_SECURITY_IPERMISSION is
		external
			"IL deferred signature (System.Security.IPermission): System.Security.IPermission use System.Security.IPermission"
		alias
			"Intersect"
		end

	union (target: SYSTEM_SECURITY_IPERMISSION): SYSTEM_SECURITY_IPERMISSION is
		external
			"IL deferred signature (System.Security.IPermission): System.Security.IPermission use System.Security.IPermission"
		alias
			"Union"
		end

	demand is
		external
			"IL deferred signature (): System.Void use System.Security.IPermission"
		alias
			"Demand"
		end

	demand_immediate is
		external
			"IL deferred signature (): System.Void use System.Security.IPermission"
		alias
			"DemandImmediate"
		end

	is_subset_of (target: SYSTEM_SECURITY_IPERMISSION): BOOLEAN is
		external
			"IL deferred signature (System.Security.IPermission): System.Boolean use System.Security.IPermission"
		alias
			"IsSubsetOf"
		end

	copy: SYSTEM_SECURITY_IPERMISSION is
		external
			"IL deferred signature (): System.Security.IPermission use System.Security.IPermission"
		alias
			"Copy"
		end

end -- class SYSTEM_SECURITY_IPERMISSION
