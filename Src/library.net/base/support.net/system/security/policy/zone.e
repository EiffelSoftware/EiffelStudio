indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Policy.Zone"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	ZONE

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

	frozen make (zone: SECURITY_ZONE) is
		external
			"IL creator signature (System.Security.SecurityZone) use System.Security.Policy.Zone"
		end

feature -- Access

	frozen get_security_zone: SECURITY_ZONE is
		external
			"IL signature (): System.Security.SecurityZone use System.Security.Policy.Zone"
		alias
			"get_SecurityZone"
		end

feature -- Basic Operations

	frozen create_from_url (url: SYSTEM_STRING): ZONE is
		external
			"IL static signature (System.String): System.Security.Policy.Zone use System.Security.Policy.Zone"
		alias
			"CreateFromUrl"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Security.Policy.Zone"
		alias
			"GetHashCode"
		end

	frozen copy_: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Security.Policy.Zone"
		alias
			"Copy"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Policy.Zone"
		alias
			"ToString"
		end

	frozen create_identity_permission (evidence: EVIDENCE): IPERMISSION is
		external
			"IL signature (System.Security.Policy.Evidence): System.Security.IPermission use System.Security.Policy.Zone"
		alias
			"CreateIdentityPermission"
		end

	equals (o: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Security.Policy.Zone"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Security.Policy.Zone"
		alias
			"Finalize"
		end

end -- class ZONE
