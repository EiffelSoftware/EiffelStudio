indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.Cryptography.MD5"

deferred external class
	SYSTEM_SECURITY_CRYPTOGRAPHY_MD5

inherit
	SYSTEM_SECURITY_CRYPTOGRAPHY_HASHALGORITHM
	SYSTEM_SECURITY_CRYPTOGRAPHY_ICRYPTOTRANSFORM

feature -- Basic Operations

	frozen create__md5: SYSTEM_SECURITY_CRYPTOGRAPHY_MD5 is
		external
			"IL static signature (): System.Security.Cryptography.MD5 use System.Security.Cryptography.MD5"
		alias
			"Create"
		end

	frozen create__string2 (alg_name: STRING): SYSTEM_SECURITY_CRYPTOGRAPHY_MD5 is
		external
			"IL static signature (System.String): System.Security.Cryptography.MD5 use System.Security.Cryptography.MD5"
		alias
			"Create"
		end

end -- class SYSTEM_SECURITY_CRYPTOGRAPHY_MD5
