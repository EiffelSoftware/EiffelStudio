indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.Cryptography.SHA1Managed"

external class
	SYSTEM_SECURITY_CRYPTOGRAPHY_SHA1MANAGED

inherit
	SYSTEM_SECURITY_CRYPTOGRAPHY_SHA1
	SYSTEM_SECURITY_CRYPTOGRAPHY_ICRYPTOTRANSFORM

create
	make_sha1managed

feature {NONE} -- Initialization

	frozen make_sha1managed is
		external
			"IL creator use System.Security.Cryptography.SHA1Managed"
		end

feature -- Basic Operations

	initialize is
		external
			"IL signature (): System.Void use System.Security.Cryptography.SHA1Managed"
		alias
			"Initialize"
		end

feature {NONE} -- Implementation

	hash_core (rgb: ARRAY [INTEGER_8]; ib_start: INTEGER; cb_size: INTEGER) is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32): System.Void use System.Security.Cryptography.SHA1Managed"
		alias
			"HashCore"
		end

	hash_final: ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Security.Cryptography.SHA1Managed"
		alias
			"HashFinal"
		end

end -- class SYSTEM_SECURITY_CRYPTOGRAPHY_SHA1MANAGED
