indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Policy.IIdentityPermissionFactory"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	IIDENTITY_PERMISSION_FACTORY

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	create_identity_permission (evidence: EVIDENCE): IPERMISSION is
		external
			"IL deferred signature (System.Security.Policy.Evidence): System.Security.IPermission use System.Security.Policy.IIdentityPermissionFactory"
		alias
			"CreateIdentityPermission"
		end

end -- class IIDENTITY_PERMISSION_FACTORY
