indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.Policy.Publisher"

frozen external class
	SYSTEM_SECURITY_POLICY_PUBLISHER

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

	frozen make (cert: SYSTEM_SECURITY_CRYPTOGRAPHY_X509CERTIFICATES_X509CERTIFICATE) is
		external
			"IL creator signature (System.Security.Cryptography.X509Certificates.X509Certificate) use System.Security.Policy.Publisher"
		end

feature -- Access

	frozen get_certificate: SYSTEM_SECURITY_CRYPTOGRAPHY_X509CERTIFICATES_X509CERTIFICATE is
		external
			"IL signature (): System.Security.Cryptography.X509Certificates.X509Certificate use System.Security.Policy.Publisher"
		alias
			"get_Certificate"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Security.Policy.Publisher"
		alias
			"GetHashCode"
		end

	is_equal (o: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Security.Policy.Publisher"
		alias
			"Equals"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Security.Policy.Publisher"
		alias
			"ToString"
		end

	frozen create_identity_permission (evidence: SYSTEM_SECURITY_POLICY_EVIDENCE): SYSTEM_SECURITY_IPERMISSION is
		external
			"IL signature (System.Security.Policy.Evidence): System.Security.IPermission use System.Security.Policy.Publisher"
		alias
			"CreateIdentityPermission"
		end

	frozen copy: ANY is
		external
			"IL signature (): System.Object use System.Security.Policy.Publisher"
		alias
			"Copy"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Security.Policy.Publisher"
		alias
			"Finalize"
		end

end -- class SYSTEM_SECURITY_POLICY_PUBLISHER
