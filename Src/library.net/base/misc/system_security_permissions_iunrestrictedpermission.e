indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.Permissions.IUnrestrictedPermission"

deferred external class
	SYSTEM_SECURITY_PERMISSIONS_IUNRESTRICTEDPERMISSION

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	is_unrestricted: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Security.Permissions.IUnrestrictedPermission"
		alias
			"IsUnrestricted"
		end

end -- class SYSTEM_SECURITY_PERMISSIONS_IUNRESTRICTEDPERMISSION
