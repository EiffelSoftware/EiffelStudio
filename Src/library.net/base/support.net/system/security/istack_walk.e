indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.IStackWalk"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ISTACK_WALK

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

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

end -- class ISTACK_WALK
