indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.Policy.IIdentityPermissionFactory"

deferred external class
	SYSTEM_SECURITY_POLICY_IIDENTITYPERMISSIONFACTORY

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	create_identity_permission (evidence: SYSTEM_SECURITY_POLICY_EVIDENCE): SYSTEM_SECURITY_IPERMISSION is
		external
			"IL deferred signature (System.Security.Policy.Evidence): System.Security.IPermission use System.Security.Policy.IIdentityPermissionFactory"
		alias
			"CreateIdentityPermission"
		end

end -- class SYSTEM_SECURITY_POLICY_IIDENTITYPERMISSIONFACTORY
