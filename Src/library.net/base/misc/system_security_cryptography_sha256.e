indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.Cryptography.SHA256"

deferred external class
	SYSTEM_SECURITY_CRYPTOGRAPHY_SHA256

inherit
	SYSTEM_SECURITY_CRYPTOGRAPHY_HASHALGORITHM
	SYSTEM_SECURITY_CRYPTOGRAPHY_ICRYPTOTRANSFORM

feature -- Basic Operations

	frozen create__sha256: SYSTEM_SECURITY_CRYPTOGRAPHY_SHA256 is
		external
			"IL static signature (): System.Security.Cryptography.SHA256 use System.Security.Cryptography.SHA256"
		alias
			"Create"
		end

	frozen create__string2 (hash_name: STRING): SYSTEM_SECURITY_CRYPTOGRAPHY_SHA256 is
		external
			"IL static signature (System.String): System.Security.Cryptography.SHA256 use System.Security.Cryptography.SHA256"
		alias
			"Create"
		end

end -- class SYSTEM_SECURITY_CRYPTOGRAPHY_SHA256
