indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Policy.StrongName"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	STRONG_NAME

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	IIDENTITY_PERMISSION_FACTORY

create
	make

feature {NONE} -- Initialization

	frozen make (blob: STRONG_NAME_PUBLIC_KEY_BLOB; name: SYSTEM_STRING; version: VERSION) is
		external
			"IL creator signature (System.Security.Permissions.StrongNamePublicKeyBlob, System.String, System.Version) use System.Security.Policy.StrongName"
		end

feature -- Access

	frozen get_version: VERSION is
		external
			"IL signature (): System.Version use System.Security.Policy.StrongName"
		alias
			"get_Version"
		end

	frozen get_public_key: STRONG_NAME_PUBLIC_KEY_BLOB is
		external
			"IL signature (): System.Security.Permissions.StrongNamePublicKeyBlob use System.Security.Policy.StrongName"
		alias
			"get_PublicKey"
		end

	frozen get_name: SYSTEM_STRING is
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

	frozen copy_: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Security.Policy.StrongName"
		alias
			"Copy"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Policy.StrongName"
		alias
			"ToString"
		end

	frozen create_identity_permission (evidence: EVIDENCE): IPERMISSION is
		external
			"IL signature (System.Security.Policy.Evidence): System.Security.IPermission use System.Security.Policy.StrongName"
		alias
			"CreateIdentityPermission"
		end

	equals (o: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Security.Policy.StrongName"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Security.Policy.StrongName"
		alias
			"Finalize"
		end

end -- class STRONG_NAME
