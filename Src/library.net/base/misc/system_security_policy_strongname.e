indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.Policy.StrongName"

frozen external class
	SYSTEM_SECURITY_POLICY_STRONGNAME

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_SECURITY_POLICY_IIDENTITYPERMISSIONFACTORY

create
	make

feature {NONE} -- Initialization

	frozen make (blob: SYSTEM_SECURITY_PERMISSIONS_STRONGNAMEPUBLICKEYBLOB; name: STRING; version: SYSTEM_VERSION) is
		external
			"IL creator signature (System.Security.Permissions.StrongNamePublicKeyBlob, System.String, System.Version) use System.Security.Policy.StrongName"
		end

feature -- Access

	frozen get_version: SYSTEM_VERSION is
		external
			"IL signature (): System.Version use System.Security.Policy.StrongName"
		alias
			"get_Version"
		end

	frozen get_public_key: SYSTEM_SECURITY_PERMISSIONS_STRONGNAMEPUBLICKEYBLOB is
		external
			"IL signature (): System.Security.Permissions.StrongNamePublicKeyBlob use System.Security.Policy.StrongName"
		alias
			"get_PublicKey"
		end

	frozen get_name: STRING is
		external
			"IL signature (): System.String use System.Security.Policy.StrongName"
		alias
			"get_Name"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Security.Policy.StrongName"
		alias
			"GetHashCode"
		end

	is_equal (o: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Security.Policy.StrongName"
		alias
			"Equals"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Security.Policy.StrongName"
		alias
			"ToString"
		end

	frozen create_identity_permission (evidence: SYSTEM_SECURITY_POLICY_EVIDENCE): SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (System.Security.Policy.Evidence): System.Security.IPermission use System.Security.Policy.StrongName"
		alias
			"CreateIdentityPermission"
		end

	frozen copy: ANY is
		external
			"IL signature (): System.Object use System.Security.Policy.StrongName"
		alias
			"Copy"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Security.Policy.StrongName"
		alias
			"Finalize"
		end

end -- class SYSTEM_SECURITY_POLICY_STRONGNAME
