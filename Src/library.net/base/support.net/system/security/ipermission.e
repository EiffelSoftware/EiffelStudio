indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.IPermission"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	IPERMISSION

inherit
	ISECURITY_ENCODABLE

feature -- Basic Operations

	union (target: IPERMISSION): IPERMISSION is
		external
			"IL deferred signature (System.Security.IPermission): System.Security.IPermission use System.Security.IPermission"
		alias
			"Union"
		end

	intersect (target: IPERMISSION): IPERMISSION is
		external
			"IL deferred signature (System.Security.IPermission): System.Security.IPermission use System.Security.IPermission"
		alias
			"Intersect"
		end

	demand is
		external
			"IL deferred signature (): System.Void use System.Security.IPermission"
		alias
			"Demand"
		end

	is_subset_of (target: IPERMISSION): BOOLEAN is
		external
			"IL deferred signature (System.Security.IPermission): System.Boolean use System.Security.IPermission"
		alias
			"IsSubsetOf"
		end

	copy_: IPERMISSION is
		external
			"IL deferred signature (): System.Security.IPermission use System.Security.IPermission"
		alias
			"Copy"
		end

end -- class IPERMISSION
