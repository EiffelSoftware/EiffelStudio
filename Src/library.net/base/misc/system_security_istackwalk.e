indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.IStackWalk"

deferred external class
	SYSTEM_SECURITY_ISTACKWALK

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	demand_immediate is
		external
			"IL deferred signature (): System.Void use System.Security.IStackWalk"
		alias
			"DemandImmediate"
		end

	permit_only is
		external
			"IL deferred signature (): System.Void use System.Security.IStackWalk"
		alias
			"PermitOnly"
		end

	demand is
		external
			"IL deferred signature (): System.Void use System.Security.IStackWalk"
		alias
			"Demand"
		end

	assert is
		external
			"IL deferred signature (): System.Void use System.Security.IStackWalk"
		alias
			"Assert"
		end

	deny is
		external
			"IL deferred signature (): System.Void use System.Security.IStackWalk"
		alias
			"Deny"
		end

end -- class SYSTEM_SECURITY_ISTACKWALK
