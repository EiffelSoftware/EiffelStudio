indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.Policy.Zone"

frozen external class
	SYSTEM_SECURITY_POLICY_ZONE

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

	frozen make (zone: INTEGER) is
			-- Valid values for `zone' are:
			-- MyComputer = 0
			-- Intranet = 1
			-- Trusted = 2
			-- Internet = 3
			-- Untrusted = 4
			-- NoZone = -1
		require
			valid_security_zone: zone = 0 or zone = 1 or zone = 2 or zone = 3 or zone = 4 or zone = -1
		external
			"IL creator signature (enum System.Security.SecurityZone) use System.Security.Policy.Zone"
		end

feature -- Access

	frozen get_security_zone: INTEGER is
		external
			"IL signature (): enum System.Security.SecurityZone use System.Security.Policy.Zone"
		alias
			"get_SecurityZone"
		ensure
			valid_security_zone: Result = 0 or Result = 1 or Result = 2 or Result = 3 or Result = 4 or Result = -1
		end

feature -- Basic Operations

	frozen create_from_url (url: STRING): SYSTEM_SECURITY_POLICY_ZONE is
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

	is_equal (o: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Security.Policy.Zone"
		alias
			"Equals"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Security.Policy.Zone"
		alias
			"ToString"
		end

	frozen create_identity_permission (evidence: SYSTEM_SECURITY_POLICY_EVIDENCE): SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (System.Security.Policy.Evidence): System.Security.IPermission use System.Security.Policy.Zone"
		alias
			"CreateIdentityPermission"
		end

	frozen copy: ANY is
		external
			"IL signature (): System.Object use System.Security.Policy.Zone"
		alias
			"Copy"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Security.Policy.Zone"
		alias
			"Finalize"
		end

end -- class SYSTEM_SECURITY_POLICY_ZONE
