indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Permissions.IUnrestrictedPermission"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	IUNRESTRICTED_PERMISSION

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	is_unrestricted: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Security.Permissions.IUnrestrictedPermission"
		alias
			"IsUnrestricted"
		end

end -- class IUNRESTRICTED_PERMISSION
